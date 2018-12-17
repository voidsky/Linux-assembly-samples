all:	hello_syscall hello

hello:	hello.o
	gcc -no-pie -o hello hello.o

hello.o:
	nasm -f elf64 -o hello.o hello.asm

hello_syscall: hello_syscall.o
	ld -o hello_syscall hello_syscall.o

hello_syscall.o:
	nasm -f elf64 -o hello_syscall.o hello_syscall.asm
	
clean:
	-rm *.o $(objects) hello_syscall
	-rm *.o $(objects) hello
