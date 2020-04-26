DATAS SEGMENT
buf db 8
    db ?
    db 8 dup (?)
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
	mov dx,0
	mov ah,0ah
	int 21h
	
    mov bx,0b800h
    mov es,bx
    xor si,si
    mov al,ds:[si]
    mov es:[500h+si],al
   
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START






