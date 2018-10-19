section .data
global file


m1  db "",10
	db "File opened successfully ",10 
len1 equ $-m1


m2  db "",10
	db "File opened unsuccessfully",10 
len2 equ $-m2

file db 'file.txt',0






section .bss
global size,buffer,result,ele

%macro scall 4
MOV rax,%1
MOV rdi,%2
MOV rsi,%3
MOV rdx,%4
syscall
%endmacro




fd_1 resB 10
buffer resB 100
size resB 8
result resB 2
ele resB 2
cnt1 resb 2
cnt2 resb 2


section .text
global main
main:


scall 2,file,2,0777

mov qword[fd_1],rax

bt qword[fd_1],63
jnc work

scall 1,1,m2,len2

jmp next 	

work :

scall 1,1,m1,len1

next :

scall 0,[fd_1],buffer,100


mov qword[size],rax
mov qword[cnt1],rax
mov qword[cnt2],rax



mov rax,3
mov rdi,[fd_1]
syscall

scall 1,1,buffer,100




i :

mov rsi,buffer
mov rdi,buffer
mov cl,byte[size]
dec cl
mov byte[cnt1],cl


j :
	mov al,byte[rsi]
	add rsi,1

	cmp byte[rsi],al
	jc next1 
	xchg al,byte[rsi]
	mov byte[rdi],al
	;mov byte[rsi],al
	
	next1 :
	add rdi,1
	dec byte[cnt1]
	jnz j
	dec byte[cnt2]
	jnz i 


 	

scall 1,1,buffer,100



scall 2,file,2,7

mov qword[fd_1],rax

scall 1,[fd_1],buffer,qword[size]




mov rax,60
mov rdi,1
syscall

