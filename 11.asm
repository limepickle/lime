section .data


array dq 2.00 , 3.00 , 8.00 , 0.00 , 0.00 , 6.00
cnt db 6
cnt1 dw 6
hundred dw 100

point db "."
len equ $-point


section .bss

%macro scall 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall 
%endmacro


mean resb 8
var resb 8
num resb 4
buffer resb 10
result resb 2



section .text
global main
main :



FINIT
FLDZ 
mov rdi,array
mov byte[cnt],6
;mov qword[cnt1],6
temp :

FADD qword[rdi]
add rdi,8
dec byte[cnt]
jnz temp


FIDIV word[cnt1]
FST qword[mean]
call disp



varr :

FLDZ
mov byte[cnt],6
mov qword[var],0
mov rdi,array
temp3 :
	
	FLD qword[rdi]
	FSUB qword[mean]
	FST st1
	FMUL st0,st1
	FADD qword[var]
	FSTP qword[var]
	add rdi,8
	dec byte[cnt]
	jnz temp3

FLD qword[var]
FIDIV word[cnt1]
FST qword[var]
call disp




mov rax,60
mov rdi,1
syscall


disp:

FIMUL word[hundred]
FBSTP [buffer]

mov rdi,buffer + 9
mov byte[cnt],09H

temp2 :
	mov dl,byte[rdi]
	push rdi
	call HtoA
	pop rdi
	dec rdi
	dec byte[cnt]
	jnz temp2

scall 1,1,point,len
mov rdi,buffer
mov dl,byte[rdi]
call HtoA

ret









HtoA :


mov rcx,02
mov rdi,result


L1 : rol dl,04
	mov al,dl
	and al,0FH
	cmp al,09H
	jbe L2
	add al,07H
L2 :	add al,30H
	mov byte[rdi],al
	inc rdi
	loop L1

scall 1,1,result,2	

ret













