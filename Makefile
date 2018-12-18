all:	hello_syscall hello sumargs_syscall

hello:	hello.o
	gcc -no-pie -o hello hello.o

hello.o:
	nasm -f elf64 -o hello.o hello.asm


hello_syscall: hello_syscall.o
	ld -o hello_syscall hello_syscall.o

hello_syscall.o:
	nasm -f elf64 -o hello_syscall.o hello_syscall.asm
	
sumargs_syscall: sumargs_syscall.o
	ld -o sumargs_syscall sumargs_syscall.o

sumargs_syscall.o:
	nasm -f elf64 -o sumargs_syscall.o sumargs_syscall.asm


clean:
	-rm *.o $(objects) hello_syscall
	-rm *.o $(objects) hello
	-rm *.o $(objects) sumargs_syscall
