;Assemble yasm -f elf64 -l hello.lst hello.asm
;link gcc -o hello hello.o
;run hello

	SECTION .data
msg:	db "Hello world",10
len:	equ $-msg

	SECTION .text
	global main
main:
	mov	edx,len
	mov	ecx,msg
	mov	ebx,1
	mov	eax,4
	int	0x80

	mov	ebx,0
	mov	eax,1
	int	0x80


