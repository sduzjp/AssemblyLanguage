
CODES SEGMENT
    ASSUME CS:CODES
START:
    MOV bx,0b800h
    MOV DS,bx
    mov al,3eh
    mov bl,33h
    mov ds:[0],bl
    mov bl,45h
    mov ds:[2],bl
    mov bl,24h
    mov ds:[1],bl
    mov ds:[3],bl
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
