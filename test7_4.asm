DATAS SEGMENT
    db 'BaSiC'
    db 'iNfOrMaTiOn' 
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    mov bx,0
    
    mov cx,5
    s:mov al,[bx]
    and al,11011111b
    mov [bx],al
    inc bx
    loop s
    
    mov bx,5
    mov cx,11
    s0:mov al,[bx]
    or al,00100000b
    mov [bx],al
    inc bx
    loop s0
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
