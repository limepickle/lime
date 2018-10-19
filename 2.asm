section .data
	menu db "Enter 1 for non overlapped block transfer",10
	     db "Enter 2 for overlapped block transfer",10
	     db "Enter 3 for non overlapped block transfer using string",10
	     db "Enter 4 for overlapped block transfer using string",10
	     db "Enter 5 to exit",10
	     db "Your option : "
	len equ $-menu	     
	block dq 1234567891234567h,8765432187654321h,2468135724681357h
	block_len equ 03
	tmsg db " : "
	tlen equ $-tmsg
	newline db 10
	len_nl equ $-newline
	addWrite db "Address: "
	len_add equ $-addWrite
	dataWrite db "Data: "
	len_data equ $-dataWrite
	space db "  "
	len_space equ $-space
	newline2 db 10
	len_nl2 equ $-newline
	addWrite2 db "Address: "
	len_add2 equ $-addWrite
	dataWrite2 db "Data: "
	len_data2 equ $-dataWrite
	space2 db "  "
	len_space2 equ $-space
	
section .bss
	choice resb 02
	dataByte resb 08
	sum resb 16
	

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

%macro read 1
	mov rax,0
	mov rdi,1
	mov rsi,%1
	mov rdx,2
	syscall
%endmacro
	
section .text
	global _start

_start:	
	write menu,len
	read choice
	
	
;printing the block + 6
	;mov rbx,06
	;mov rsi,block
	;xor rdx,rdx
	
main_up:mov rdx,[rsi]
	;push rsi
	;call htoa
	;write dataWrite,len_data
	;write sum,16
	;write space,len_space
	;pop rsi
	;mov rdx,rsi
	;push rsi
	;call htoa
	;write addWrite,len_add
	;write sum,16
	;write newline,len_nl
	;pop rsi
	;add rsi,08h
	;dec rbx
	;jnz main_up
;end of printing block
	
	
	
	
	write newline,len_nl
	
	
	
	
	
	
	;switch case
	cmp byte[choice],31h
	je main_below1
	cmp byte[choice],32h
	je main_below2
	cmp byte[choice],33h
	je main_below3
	cmp byte[choice],34h
	je main_below4
	jmp end_of_prog
	
	
	
	
	
	
	;if choice is 1
main_below1:


	mov rcx,03
	mov rsi,block
	mov rdi,block+70h
	
c1_up:	;xor rdx,rdx	

	mov rdx,qword[rsi]
	mov qword[rdi],rdx
	
	add rsi,08h
	add rdi,08h
	dec rcx
	cmp rcx,00h
	jnz c1_up
	
	
	
;printing the block + 3
	mov rbx,03
	mov rsi,block
	xor rdx,rdx
	
main_up1:mov rdx,qword[rsi]
	push rsi
	call htoa
	write dataWrite,len_data
	write sum,16
	write space,len_space
	pop rsi
	mov rdx,rsi
	push rsi
	call htoa
	write addWrite,len_add
	write sum,16
	write newline,len_nl
	pop rsi
	add rsi,08h
	dec rbx
	jnz main_up1
	
;printing the block+30 + 3
	mov rbx,03
	mov rsi,block+70h
	xor rdx,rdx
	
main_up2:mov rdx,qword[rsi]
	push rsi
	call htoa
	write dataWrite,len_data
	write sum,16
	write space,len_space
	pop rsi
	mov rdx,rsi
	push rsi
	call htoa
	write addWrite,len_add
	write sum,16
	write newline,len_nl
	pop rsi
	add rsi,08h
	dec rbx
	jnz main_up2
;end of printing block
	jmp end_of_prog

	
	
	
	;if choice is 2
main_below2:
	
;printing the block + 3
	mov rbx,03
	mov rsi,block
	xor rdx,rdx
	
main_up9:mov rdx,[rsi]
	push rsi
	call htoa
	write dataWrite,len_data
	write sum,16
	write space,len_space
	pop rsi
	mov rdx,rsi
	push rsi
	call htoa
	write addWrite,len_add
	write sum,16
	write newline,len_nl
	pop rsi
	add rsi,08h
	dec rbx
	jnz main_up9
;end of printing block
	
	
	
	mov rcx,03h
	mov rsi,block+10h
	mov rdi,block+20h
choice2_up:
	mov rdx,qword[rsi]
	mov qword[rdi],rdx
	sub rsi,08h
	sub rdi,08h
	loop choice2_up
	
	
;printing the bloc + 3
	mov rbx,03
	mov rsi,block+10h
	xor rdx,rdx
	
main_up10:mov rdx,qword[rsi]
	push rsi
	call htoa
	;write dataWrite,len_data
	write sum,16
	write space,len_space
	pop rsi
	mov rdx,rsi
	push rsi
	call htoa
	;write addWrite,len_add
	write sum,16
	write newline,len_nl
	pop rsi
	add rsi,08h
	dec rbx
	jnz main_up10
;end of printing block	
	

	jmp end_of_prog
	
	
	;if choice is 3
main_below3:
	
	cld
	mov rcx,03h
	mov rsi,block
	mov rdi,block+90h
	rep movsq
	
;printing the block + 3
	mov rbx,03
	mov rsi,block
	xor rdx,rdx
	
main_up3:mov rdx,qword[rsi]
	push rsi
	call htoa
	write dataWrite,len_data
	write sum,16
	write space,len_space
	pop rsi
	mov rdx,rsi
	push rsi
	call htoa
	write addWrite,len_add
	write sum,16
	write newline,len_nl
	pop rsi
	add rsi,08h
	dec rbx
	jnz main_up3
	
;printing the bloc + 3
	mov rbx,03
	mov rsi,block+90h
	xor rdx,rdx
	
main_up4:mov rdx,qword[rsi]
	push rsi
	call htoa
	write dataWrite,len_data
	write sum,16
	write space,len_space
	pop rsi
	mov rdx,rsi
	push rsi
	call htoa
	write addWrite,len_add
	write sum,16
	write newline,len_nl
	pop rsi
	add rsi,08h
	dec rbx
	jnz main_up4
;end of printing block
	jmp end_of_prog
	
	
	
	
	
	
	
	
	
	;if choice is 4
main_below4:
	
	
;printing the block + 3
	mov rbx,03
	mov rsi,block
	xor rdx,rdx
	
main_up5:mov rdx,qword[rsi]
	push rsi
	call htoa
	write dataWrite,len_data
	write sum,16
	write space,len_space
	pop rsi
	mov rdx,rsi
	push rsi
	call htoa
	write addWrite,len_add
	write sum,16
	write newline,len_nl
	pop rsi
	add rsi,08h
	dec rbx
	jnz main_up5


;transfer
	std
	mov rcx,03h
	mov rsi,block+10h
	mov rdi,block+20h
	rep movsq
	
	
;printing the bloc + 3
	mov rbx,03
	mov rsi,block+10h
	xor rdx,rdx
	
main_up6:mov rdx,qword[rsi]
	push rsi
	call htoa
	;write dataWrite,len_data
	write sum,16
	write space,len_space
	pop rsi
	mov rdx,rsi
	push rsi
	call htoa
	;write addWrite,len_add
	write sum,16
	write newline,len_nl
	pop rsi
	add rsi,08h
	dec rbx
	jnz main_up6
;end of printing block
	jmp end_of_prog
	
	
	
end_of_prog:	
	end








;htoa function
htoa:	mov rcx,16
	mov rdi,sum
	
htoa_up:rol rdx,4		;Remember to roll rdx not dl
	mov al,dl
	and al, 0fh
	cmp al,09h
	jbe htoa_a3
	add al,07h
	
htoa_a3:add al,30h
	mov [rdi],al
	inc rdi
	dec rcx
	jne htoa_up
	ret
;end of htoa	
