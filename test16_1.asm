;������Ԫ���ȵı��

CODES SEGMENT
    ASSUME CS:CODES
    a: db 1,2,3,4,5,6,7,8
    b: dw 0 
START:
    mov si,offset a
    mov bx,offset b
    mov cx,8;�ۼ�8��
    s:
    mov al,cs:[si]
    mov ah,0;���ֽ������ݴ�ŵ�16λ�Ĵ�����
    add cs:[bx],ax
    inc si
    loop s
    
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
