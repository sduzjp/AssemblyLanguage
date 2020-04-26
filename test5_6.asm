a SEGMENT
    dw 1,2,3,4,5,6,7,8,9,0ah,0bh,0ch,0dh,0eh,0fh,0ffh  
a ENDS

b SEGMENT
    dw 0,0,0,0,0,0,0,0
b ENDS

CODES SEGMENT
    ASSUME CS:CODES
START:
    MOV AX,a
    MOV ds,ax
    mov bx,b
    mov es,bx
    
    mov bx,0
    mov cx,8
    s:mov al,[bx]
    mov es:[bx],al
    inc bx
    loop s
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
