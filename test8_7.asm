
CODES SEGMENT
    ASSUME CS:CODES
START:
    MOV dx,1
    MOV ax,86a1h
    mov bx,100
    div bx

    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
