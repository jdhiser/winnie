// fuzz_me will typically be at 0x401000

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <dlfcn.h>

#define DEBUG_LOG_FILE "toy_example.log"

#define dbg_printf (void)printf

typedef int (*test_func_t)(char*);
void * hMathlib;

void check_fwrite()
{
    static int counter = 0;
    FILE *fp;
    fp = fopen(DEBUG_LOG_FILE, "a");
    fprintf(fp, "hello from toy example! counter value: %d\n", counter);
    fclose(fp);
    counter++;
}

void fuzz_me(char* filename)
{
    char buf[201];
    bzero(&buf, 201);
    FILE *fp = fopen(filename, "rb");
    if(!fp) 
    {
	    perror("fuzz_me");
	    printf("Cannt open %s for input.\n", filename);
	    exit(1);
    }
    fread(buf, 1, 200, fp);

    test_func_t test_func = (test_func_t) dlsym(hMathlib, "test"); // index
    int result = test_func(buf);
    printf("Result: %d\n", result);    
    fclose(fp);  

    check_fwrite();

    printf("Bye");
    exit(0);
}

int main(int argc, char ** argv)
{
    hMathlib = dlopen("./example_library.so", RTLD_LAZY);
    if (hMathlib == NULL) {
        perror("failed to load example_library");
        exit(1);
    }
    printf("example_library loaded ");
    if(argc != 2) 
    {
	    printf("usage: %s <input file>\n", argv[0]);
	    return 1;
    }

    fuzz_me(argv[1]);

    printf("main() ends\n");

    return 0;
}
