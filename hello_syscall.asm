;Assemble nasm -f elf64 -l -o hello_syscall.o hello_syscall.asm
;link ld -o hello_syscall hello_syscall.o
;run hello_syscall

	SECTION .data
msg:	db "Hello world!",0xA

	SECTION .text
	global _start
_start:
	mov 	rax,1		;sys_write
	mov	rdi,1		;unsigned int fd
	mov	rsi, msg	;const char *buf
	mov	rdx,13		;size_t count
	syscall

	mov	rax,60		;sys_exit
	mov	rdi,0		;error code
	syscall
