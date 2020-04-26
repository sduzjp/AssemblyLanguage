DATAS SEGMENT
	db 'BaSiC'
	db 'MinIX'
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
    mov al,[5+bx]
    or al,00100000b
    mov 5[bx],al
    inc bx
    loop s
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
