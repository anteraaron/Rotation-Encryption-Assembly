title RotEnc
.model small
.data
	char db ?
	final db 10 dup(?)
	space db 0ah, "$"
	input db "INPUT EXACTLY 10 CHARACTERS: ", "$"
	output db "ROT-13 EQUIVALENT: ", "$"
	userVal db ?
.stack 100h
.code
	main proc
	
	mov ax, @data
	mov ds,ax
	
	mov dl, space ;print new line
	mov ah, 02h
	int 21h
	
	lea dx, input ;print input statement
	mov ah, 09h
	int 21h
	
	;loop
	mov cl, 10
	l1:
		mov ah, 01h;get input from user
		int 21h
		
		mov userVal, al
		add al, 13 ;add 13 to ascii value
		
		cmp userVal, 90 ; 90 = highest possible value for uppercase letters
		jg higher ;if letter is a lower case jump to higher function
			
		sub al, 65
		mov char, al ;assign
	
		mov ah, 0 ;clear ah
		mov al, char ;al/bl
		mov bl, 26
		div bl
			
		add ah, 65
		mov char, ah
			
		mov bh, cl
		mov dl, char
		mov final[bx], dl
		jmp cont
		
		higher: ;if > 90
			sub al, 97
			mov char, al ;assign
			
			mov ah, 0
			mov al, char
			mov bl, 26
			div bl
			
			add ah, 97
			mov char, ah
			
			mov bh, cl
			mov dl, char
			mov final[bx], dl
			jmp cont
			
	cont:
	dec cl
	jnz l1
	;end loop
	
	mov dl, space ;print new line
	mov ah, 02h
	int 21h
	
	lea dx, output ;print rot13 statement
	mov ah, 09h
	int 21h
	
	;loop
	mov cl, 10
	l2:
		mov bh, cl
		mov dl, final[bx] ;print value
		mov ah, 02h
		int 21h
	
	dec cl
	jnz l2
	;end loop
	
	mov dl, space ;print new line
	mov ah, 02h
	int 21h
	
	mov ax, 4c00h ;return 0
	int 21h
	
	main endp
	end main

