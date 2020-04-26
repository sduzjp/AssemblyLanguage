;描述单元长度的标号

CODES SEGMENT
    ASSUME CS:CODES
    a: db 1,2,3,4,5,6,7,8
    b: dw 0 
START:
    mov si,offset a
    mov bx,offset b
    mov cx,8;累加8次
    s:
    mov al,cs:[si]
    mov ah,0;将字节型数据存放到16位寄存器中
    add cs:[bx],ax
    inc si
    loop s
    
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
