
main() {
	local src="library_trace.cpp"
	local exe="library_trace.so"
	local pinpath="$PWD/../../../pin/"
	

	g++ -DX64 -Wno-unknown-pragmas -DPIN_CRT=1 -fno-stack-protector -fno-exceptions -funwind-tables -fasynchronous-unwind-tables -fno-rtti -DTARGET_IA32E -DHOST_IA32E -fPIC -DTARGET_LINUX -fabi-version=2 -faligned-new  -I$pinpath/source/include/pin -I$pinpath/source/include/pin/gen -isystem $pinpath/extras/stlport/include -isystem $pinpath/extras/libstdc++/include -isystem $pinpath/extras/crt/include -isystem $pinpath/extras/crt/include/arch-x86_64 -isystem $pinpath/extras/crt/include/kernel/uapi -isystem $pinpath/extras/crt/include/kernel/uapi/asm-x86 -I$pinpath/extras/components/include -I$pinpath/extras/xed-intel64/include/xed -I$pinpath/source/tools/Utils -I$pinpath/source/tools/InstLib -g -fomit-frame-pointer -fno-strict-aliasing   -c ${src}  -fmax-errors=2  -w
	g++ -shared -Wl,--hash-style=sysv $pinpath/intel64/runtime/pincrt/crtbeginS.o -Wl,-Bsymbolic -Wl,--version-script=$pinpath/source/include/pin/pintool.ver -fabi-version=2    -o ${exe} *.o  -L$pinpath/intel64/runtime/pincrt -L$pinpath/intel64/lib -L$pinpath/intel64/lib-ext -L$pinpath/extras/xed-intel64/lib -lpin -lxed $pinpath/intel64/runtime/pincrt/crtendS.o -lpin3dwarf  -ldl-dynamic -nostdlib -lstlport-dynamic -lm-dynamic -lc-dynamic -lunwind-dynamic  -fmax-errors=2  -rdynamic


}

main "$@"
