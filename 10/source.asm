%macro read 2
	mov rax,0
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro

%macro write 2
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro

section .data
	menu db 10,'The quadratic equation is of the form ax2 + bx + c = 0'
	lenMenu equ $-menu
	inA db 10,'Enter a: '
	lenA equ $-inA
	inB db 10,'Enter b: '
	lenB equ $-inB
	iC db 10,'Enter c: '
	lenC equ $-iC
	two dw 2
	four dw 4
	
section .bss
	a resw 2
	b resw 2
	c resw 2
	root1 resb 10
	root2 resb 10
	temp resb 10
	result resb 16
section .text
	global _start
_start:

	;==== Menu and input the coefficients
	write menu,lenMenu
	write inA,lenA
	read a,2
	xor rdx,rdx
	mov dx,word[a]
	and dx,00FFh
bp1:	sub dx,30h
	mov word[a],dx
	write inB,lenB
	read b,2
	xor rdx,rdx
	mov dx,word[b]
	and dx,00FFh
	sub dx,30h
	mov word[b],dx
	write iC,lenC
	read c,2
	xor rdx,rdx
	mov dx,word[c]
	and dx,00FFh
	
	sub byte[c],30h
	
	;====Floating point unit
	
	finit
	fld dword[a]
	fimul word[two]
	fldz
	fsub dword[b]
	fld dword[b]
	fmul st0
	fld st2
	fimul word[two]
	fimul dword[c]
	fsub st1,st0
	fsqrt
	fld st0
	
	fld st2
	fadd st1,st0
	fbstp [temp]
	fldz
	fsub st2
	fadd st3
	
	fdiv st0,st4
	fbstp [root1]
	fdiv st0,st3
	fbstp [root2]
bp2:	
	mov rdx,rax
	
	write result,16
	
	
	
end:
	mov rax,60
	mov rdi,0
	syscall
	
htoa:
	mov rcx,16
	xor rax,rax
	mov rsi,result
up1:	
	rol rdx,04
	mov al,dl
	and al,0fh
	cmp al,09h
	jbe down2
	add al,07h
down2:
	add al,30h
	mov byte[rsi],al
	inc rsi
	loop up1
	ret
