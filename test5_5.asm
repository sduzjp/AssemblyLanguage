a SEGMENT
    db 1,2,3,4,5,6,7,8  
a ENDS

b SEGMENT
    db 1,2,3,4,5,6,7,8
b ENDS

d segment
	db 0,0,0,0,0,0,0,0
d ends
CODES SEGMENT
    ASSUME CS:CODES
START:
    MOV AX,a
    MOV es,ax
    
    mov bx,b
    mov ds,bx
    
    mov bx,0
    mov cx,8
    
    s:mov al,es:[bx]
    add ds:[bx],al
    push es
    mov ax,d
    mov es,ax
    mov al,ds:[bx]
    mov es:[bx],al
    pop es
    inc bx
    loop s
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
