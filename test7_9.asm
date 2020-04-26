DATAS SEGMENT
    db '1. display      '
    db '2. brows        '
    db '3. replace      '
    db '4. modify       '
    
DATAS ENDS

STACKS SEGMENT
    dw 0,0,0,0,0,0,0,0
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    mov ax,stacks
    mov ss,ax
    mov sp,10h
    mov bx,0
    mov cx,4
    s0:push cx
    mov si,0
    mov cx,4
    s:mov al,[si][bx+3]
    and al,11011111b
    mov [si+bx+3],al
    inc si
    loop s
    
    add bx,16
    pop cx
    loop s0
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
