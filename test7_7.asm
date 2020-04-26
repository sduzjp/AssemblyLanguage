DATAS SEGMENT
    db 'welcome to masm!'
    db '................'  
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    mov si,0
    mov di,16
    
    mov cx,8
    s:mov ax,[si]
    mov [di],ax
    add si,2
    add di,2
    loop s
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
