#include <string.h>
#include <stdio.h>
#include <unistd.h>

extern "C" int test(char *input)
{
  char v2;
  signed int v3;
  unsigned int v4;
  char *v5;
  char v6;
  char v7;
  char v8;
  int v9;

  printf("msg:%s\n", input);
  if ( input[0] != 't' )
  {
    printf("Error 1\n");
    return 0;
  }
  if ( input[1] != 'e' )
  {
    printf("Error 2\n");
    return 0;
  }
  if ( input[2] != 's' )
  {
    printf("Error 3\n");
    return 0;
  }
  if (input[3] == '*' )
  {
    // simple nullptr deref
    *(volatile char*)0 = 1;
    return 0;
  }
  else if (input[3] == '!')
  {
    // trigger a timeout
    sleep(5000);
    return 0;
  }
  else if (input[3] != 't' )
  {
    printf("Error 4\n");
    return 0;
  }

  // buffer overflow
  v8 = 0;
  v3 = 5;
  v9 = 0;
  do
  {
    v4 = strlen(input) + 1;
    v5 = &v7;
    do
      v6 = (v5++)[1];
    while ( v6 );
    memcpy(v5, input, v4);
    --v3;
  }
  while ( v3 );
  printf("buffer: %s\n", &v8);
  return 0;
}

