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
    
    mov cx,8
    s:mov ax,[si]
    mov [si+16],ax
    add si,2
    loop s
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START

