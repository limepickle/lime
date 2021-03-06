extern countSpaces
extern countNewlines
extern countCharacters
global buffer
global character

section .data
	length db 1
	fname1 db "./file",0
	menu db 10,"=========Menu======="
	     db 10,">Enter 1 to count spaces"
	     db 10,">Enter 2 to count newlines"
	     db 10,">Enter 3 to count character"
	     db 10,">Your option: "
	len_menu equ $-menu
	input_char db 10,">Enter your character to be scanned: "
	len_input equ $-input_char
	
	
	
		
section .bss
	option resb 2
	fd_in resb 8
	buffer resb 1
	cntSpaces resb 4
	cntNewlines resb 4
	character resb 2
	cntCharacters resb 4

section .text
	global _start
_start:
	;====open file
	
	mov rax,2
	mov rdi,fname1
	mov rsi,2
	mov rdx,0777
	syscall
	
	;====the file descriptor is stored in rax

	mov [fd_in],rax	
	
	;====to read a file
	
	mov rax,0
	mov rdi,[fd_in]
	mov rsi,buffer
	mov rdx,length
	syscall
	
	;====to write a file
	
	;mov rax,01
	;mov rdi,[fd_in]
	;mov rsi,buffer
	;mov rdx,length
	;syscall
	
	
	;====program to write file contents on the terminal
	;mov rax, 1
	;mov rdi,1
	;mov rsi,buffer
	;mov rdx,length
	;syscall
	
	
	;------------------------------------------------ driver program --------------------------------------------------
	
	
	push rax
	push rdx
	
	;====write menu
	mov rax,1
	mov rdi,1
	mov rsi,menu
	mov rdx,len_menu
	syscall
	
	;====read option
	mov rax,0
	mov rdi,1
	mov rsi,option
	mov rdx,2
	syscall
	
	pop rdx
	pop rax
	
	;====compare the option and jump, if invalid it jumps to end of program
	cmp byte[option],31h
	je choice1
	cmp byte[option],32h
	je choice2
	cmp byte[option],33h
	je choice3
	jmp close_file
	
	
choice1:
	call countSpaces
	push rdx
	mov rsi,cntSpaces
	mov rdx,rcx
	call htoa
	pop rdx
	
	mov rax,1
	mov rdi,1
	mov rsi,cntSpaces
	mov rdx,4
	syscall
	
	
	jmp close_file
	
choice2:
	call countNewlines
	mov rsi,cntNewlines
	call htoa
	
	mov rax,1
	mov rdi,1
	mov rsi,cntNewlines
	mov rdx,4
	syscall
	
	jmp close_file
	
choice3:
	;====ask for the character
	mov rax,1
	mov rdi,1
	mov rsi,input_char
	mov rdx,len_input
	syscall
	
	;====read the character
	mov rax,0
	mov rdi,1
	mov rsi,character
	mov rdx,2
	syscall
	
	call countCharacters
	mov rsi,cntCharacters
	push rdx
	mov rdx,rbx
	call htoa
	mov rsi,cntCharacters
	sub byte[rsi+3],1
	pop rdx
	
	mov rax,1
	mov rdi,1
	mov rsi,cntCharacters
	mov rdx,4
	syscall
	
	
close_file:
	;====close file
	mov rax,3
	mov rdi,[fd_in]
	syscall

end:
	mov rax,60
	mov rdi,0
	syscall
	

htoa: 
	push rax
	xor rax,rax
	mov rcx,4
	
htoaUp:	rol dx,04
	mov al,dl
	and al,0fh
	cmp al,09h
	jbe htoaDown
	add al,07h
htoaDown:
	add al,30h
	mov [rsi],al
	inc rsi
	loop htoaUp
	
	pop rax
	ret

