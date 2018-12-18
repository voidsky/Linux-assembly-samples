%define	SYS_WRITE	1
%define	STD_IN		1
%define	SYS_EXIT	60
%define	EXIT_CODE	0

	SECTION .data
wrong_argc:	db	"Must contain two arguments",0xA
wrong_argc_len:	equ	$-wrong_argc
number:		times 100 db 0

	SECTION .text
	global	_start
_start:
	pop	rcx		; get command line arg count
	cmp	rcx,3
	jne	argcError

	add	rsp,8		; skip pointer to file name 
	;mov	rax,SYS_WRITE
	;mov	rdi,STD_IN
	;pop	rsi
	;mov	rdx,255
	;syscall

	pop	rdx		; get first 'real' argument
	call	str_to_int
	mov	r10,rax


	pop	rdx		; get secind 'real' argument
	call	str_to_int
	mov	r11,rax

	add	r11,r10

	mov	rax,r11
	call	int_to_str

	mov	rax,SYS_WRITE
	mov	rdi,STD_IN
	mov	rsi,number
	mov	rdx,10
	syscall
	
	jmp	exit

argcError:
	mov	rax,SYS_WRITE
	mov	rdi,STD_IN
	mov	rsi,wrong_argc
	mov	rdx,wrong_argc_len
	syscall
	jmp	exit

exit:
	mov	rax,SYS_EXIT
	mov	rdi,EXIT_CODE
	syscall

str_to_int:
	mov	rbx,rdx
	mov	rax,0
	mov	rsi,0
	mov	rcx,0
	mov	rdx,0
.leading_spaces:
	cmp	[rbx],byte ' '
	jne 	.next1
	inc	rbx
	jmp	.leading_spaces
.next1:
	cmp	[rbx], byte 0
	jne	.next2
	jmp	.end_parse
.next2:
	cmp	[rbx], byte '0'
	jb	.not_numeric
	cmp	[rbx], byte '9'
	jbe	.next3
.not_numeric:
	jmp	.end_parse
.next3:
	mov	rdx,10
	mul	edx
	mov	dh,0
	mov	dl,byte [rbx]
	sub	dl,'0'
	add	eax,edx
	inc	rsi
	inc	rbx
	jmp	.next1
.end_parse:
	cmp	rsi,0
	je	.error_return
	clc
	jmp	.return	
.error_return:
	stc
	jmp	.return
.return:
	ret



int_to_str:
	xor	rdi,rdi
	xor	rbx,rbx
.loop:	
	mov	rdx,0
	mov	rbx,10
	div	rbx		;rax/rbx -> rax whole, rdx reminder

	add	dl,byte '0'		; convert reminder to ascii
	
	mov	byte [number+rdi],dl

	inc	rdi

	cmp	rax,0
	jne	.loop

	mov	byte [number+rdi],0
	
	dec	rdi

	xor	rcx,rcx
	mov	rcx,rdi
	mov	rdx,rdi
	xor	rdi,rdi
	
.exchange:	
	mov	al,byte [number+rcx]
	mov	ah,byte [number+rdi]
	mov	byte [number+rcx],ah
	mov	byte [number+rdi],al
	dec	rcx
	cmp	rcx,rdi
	je	.finished
	inc	rdi
	cmp	rcx,rdi
	je	.finished
	jmp	.exchange
.finished:

	ret



