DATAS SEGMENT
    db 'ibm             '
    db 'dec             '
    db 'dos             '  
    db 'vax             '  
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    mov cx,4
    s0:mov ds:[40],cx
    mov si,0
    mov cx,3
    s:mov al,[bx+si]
    and al,11011111b
    mov [bx][si],al
    inc si
    loop s
    
    add bx,16
    mov cx,ds:[40]
    loop s0
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
