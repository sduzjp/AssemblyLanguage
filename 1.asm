DATAS SEGMENT
    ;此处输入数据段代码  
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,1200h
    MOV DS,AX
    mov ax,6634h
    mov bx,0f24h
    mov si,0012h
    ;mov ds:[bx+si],2500h
    mov dx,2500h
    mov ds:[bx+si],dx
    
    xchg ah,al
    mov bx,0b800h
    mov es,bx
    xor di,di
    mov bl,2
    mov es:[di],ah
    mov es:[di+1],bl
    mov es:[di+2],al
    mov es:[di+3],bl
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START


