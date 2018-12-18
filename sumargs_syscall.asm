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

	;pop	rsi		; get first 'real' argument
	;call	str_to_int
	;mov	r10,rax

	;pop	rsi		; get secind 'real' argument
	;call	str_to_int
	;mov	r11,rax

	;add	r11,r10

	;mov	rax,r11
	;xor	r12,r12
	mov	rax,1234
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

int_to_str:
	
	mov	rdx,0
	mov	rbx,10
	div	rbx		;rax/rbx -> rax whole, rdx reminder

	add	rdx,48		; convert reminder to ascii
	mov	byte [number+rdi],dl

	inc	rdi

	cmp	rax,0
	jne	int_to_str

	mov	byte [number+rdi],0

	ret



