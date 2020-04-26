DATAS SEGMENT
    db '1. file         '
    db '2. edit         '
    db '3. search       '
    db '4. view         '
    db '5. options      '
    db '6. help         '
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    mov bx,0
    
    mov cx,6
    s: mov al,[bx+3]
    and al,11011111b
    mov 3[bx],al
    add bx,16
    loop s
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
