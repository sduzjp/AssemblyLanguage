
CODES SEGMENT
    ASSUME CS:CODES
START:
    mov al,'1'
    mov bl,'1'
    sub al,30h
    sub bl,30h
    mov cl,4
    shl al,cl
    add al,bl
    and ah,0
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START



