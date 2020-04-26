
CODES SEGMENT
    ASSUME CS:CODES
START:
    MOV AX,0
    push ax
    popf 
    mov ax,0fff0h
    add ax,0010h
    pushf
    pop ax
    and al,11000101b
    and ah,01h
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
