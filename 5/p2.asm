extern buffer
extern character
global countNewlines
global countSpaces
global countCharacters
section .data

section .bss

section .text

countSpaces:
	mov rsi,buffer
	xor rcx,rcx
	
up1:	cmp byte[rsi],00
	je down1
	cmp byte[rsi],20h
	jne down2;
	inc rcx
down2:	
 	inc rsi
	jmp up1
down1:
	ret	
	
countNewlines:
	mov rsi,buffer
	xor rdx,rdx
	
up2:	cmp byte[rsi],00
	je down4
	cmp byte[rsi],10
	jne down5
	inc rdx
down5:
	inc rsi
	jmp up2
down4:
	ret
	
countCharacters:
	mov rsi,buffer
	mov rdi,character
	mov cl,byte[rdi]
	
up3:	cmp byte[rsi],00
	je down6
	cmp byte[rsi],cl
	jne down7
	inc rbx
	
down7:	inc rsi
	jmp up3
down6:
	;pop rcx
	;pop rdx
	ret
