%macro write 2
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro

%macro end 0
	mov rax,60
	mov rdi,0
	syscall
%endmacro 

section .data
	msg0 db 10,"The processor is in protected mode"
	len0 equ $-msg0
	msg1 db 10,"Gdt == "
	len1 equ $-msg1
	msg2 db 10,"Idt == "
	len2 equ $-msg2
	msg3 db 10,"Ldt == "
	len3 equ $-msg3
	msg4 db 10,"Tr == "
	len4 equ $-msg4
	msg5 db 10,"Msw == "
	len5 equ $-msg5
	colon db ":"
	len_colon equ $-colon
	
	
section .bss
	gdtr resd 1
	     resw 1
	idtr resd 1
	     resw 1
	ldtr resw 1
	tr resw 1
	msw resd 1
	result resw 2 	
	
	   
section .text
	global _start
_start:
	;Store all the values in respective buffers
	
	sgdt [gdtr]
	sidt [idtr]
	sldt [ldtr]
	str [tr]
	smsw [msw]
	
	;check whether the processor is in the protected mode or not
	
	bt dword[msw],0
	jnc down
	write msg0,len0
down:
	
	;print contents of gdt
	write msg1,len1
	mov ax,word[gdtr+4]
	call htoa
	write result,4
	mov ax,word[gdtr+2]
	call htoa
	write result,4
	mov ax,word[gdtr]
	call htoa
	write colon,len_colon
	write result,4
	
	;print contents of idt
	write msg2,len2
	mov ax,word[idtr+4]
	call htoa
	write result,4
	mov ax,word[idtr+2]
	call htoa
	write result,4
	mov ax,word[idtr]
	call htoa
	write colon,len_colon
	write result,4
	
	;print contents of ldt
	write msg3,len3
	mov ax,word[ldtr]
	call htoa
	write result,4
	
	;print contents of tr
	write msg4,len4
	mov ax,word[tr]
	call htoa
	write result,4

	;print contents of msw
	write msg5,len5
	mov ax,word[msw+2]
	call htoa
	write result,4
	mov ax,word[msw]
	call htoa
	write result,4
	
	end
	
htoa:
	mov rcx,8
	xor rdx,rdx
	mov rdi,result
htoaUp:	rol ax,04
	mov dl,al
	and dl,0fh
	cmp dl,09h
	jbe htoa1
	add dl,07h
htoa1:	add dl,30h
	mov byte[rdi],dl
	inc rdi
	loop htoaUp
	ret
