;��ɶԶ���ַ�����ת����Сдת��Ϊ��д��
DATAS SEGMENT
    db 'word',0
    db 'unix',0
    db 'wind',0
    db 'good',0  ;�����ַ�����β��0��ʾ
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    xor bx,bx
    
    mov cx,4		;�ĸ��ַ�����ѭ���Ĵ�
    s:mov si,bx
    call capital	
    add bx,5		;һ���ַ������ת���������һ���ַ���
    loop s
    
    MOV AH,4CH
    INT 21H
    
    capital:		;ע���Ժ��д�ӳ���ʱҪ�ȱ���Ĵ���ԭ��ֵ
    push cx
    push si
    
    change:
    mov cl,[si]
    mov ch,0
    jcxz ok			;��һ���ַ�������ʱ�������ж����ת����cx=0
    and byte ptr [si],11011111b
    inc si
    jmp short change
    
    ok:
    pop si
    pop cx
    ret
CODES ENDS
    END START
