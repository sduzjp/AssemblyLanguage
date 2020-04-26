DATA SEGMENT
    dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
DATA ENDS

STACK SEGMENT
    dw 0,0,0,0,0,0,0,0
STACK ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATA,SS:STACK
START:
    MOV AX,stack
    MOV ss, ax
    mov sp,16h
    
    mov ax,data
    mov ds,ax
    
    push ds:[0]
    push ds:[2]
    pop ds:[2]
    pop ds:[0]
    
    MOV Ah,4CH
    INT 21H
CODES ENDS
    END START

