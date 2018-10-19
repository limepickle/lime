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

%macro end 0
	mov rax,60
	mov rdi,0
	syscall
%endmacro

section .data
	success db 10,'Successful operation'
	len_success equ $-success
section .bss
	buffer resb 100
	choice resb 8
	file1 resb 8
	file2 resb 8
	file3 resb 8
	des1 resb 8
	des2 resb 8
	des3 resb 8
	
section .text
	global _start
_start:
	pop rbx
	pop rbx
	pop rbx
	mov qword[choice],rbx
	mov rsi,qword[choice]
	
	cmp byte[rsi],54h
	je type_choice
	cmp byte[rsi],43h
	je copy_choice
	cmp byte[rsi],44h
	je delete_choice
	
	
type_choice:
	pop rbx
	mov rsi,file1
up1:	mov al,byte[rbx]
	mov byte[rsi],al
	inc rsi
	inc rbx
	cmp byte[rbx],20h
	jne up1
	
	;====open
	mov rax,2
	mov rdi,file1
	mov rsi,2
	mov rdx,0777
	syscall
	
	mov qword[des1],rax
	
	;===read
	mov rax,0
	mov rdi,[des1]
	mov rsi,buffer
	mov rdx,100
	syscall
	
	write buffer,8
	
	;===close
	mov rax,3
	mov rdi,[des1]
	syscall
	
	jmp endOfProg
copy_choice:
	pop rbx
	mov rsi,file1
up2:	mov al,byte[rbx]
	mov byte[rsi],al
	inc rsi
	inc rbx
	cmp byte[rbx],20h
	jne up2
	
	;====open
	mov rax,2
	mov rdi,file1
	mov rsi,2
	mov rdx,0777
	syscall
	
	mov qword[des1],rax
	
	;===read
	mov rax,0
	mov rdi,[des1]
	mov rsi,buffer
	mov rdx,9
	syscall
	
	pop rbx
	mov rsi,file2
up4:	mov al,byte[rbx]
	mov byte[rsi],al
	inc rsi
	inc rbx
	cmp byte[rbx],20h
	jne up4
	
	;====open
	mov rax,2
	mov rdi,file2
	mov rsi,2
	mov rdx,0777
	syscall
	
	mov qword[des2],rax
	;===write file
	mov rax,1
	mov rdi,[des2]
	mov rsi,buffer
	mov rdx,9
	syscall
	
	;===close both
	mov rax,3
	mov rdi,[des1]
	syscall
	
	mov rax,3
	mov rdi,[des2]
	syscall

	jmp endOfProg
delete_choice:

	pop rbx
	mov rsi,file1
up3:	mov al,byte[rbx]
	mov byte[rsi],al
	inc rsi
	inc rbx
	cmp byte[rbx],20h
	jne up3
	
	;===delete file
	mov rax,87
	mov rdi,file1
	syscall
	
endOfProg:
	end
