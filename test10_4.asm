;�����������ӳ���

CODES SEGMENT
    ASSUME CS:CODES
START:
    mov ax,4240H	;����1000000/10��F4240H/0AH��
    mov dx,000Fh	;ax��ŵ�16λ��dx��Ÿ�16λ
    mov cx,0ah		;cx��ų���16λ
    call divdw
    
    MOV AH,4CH
    INT 21H
    
    divdw:
    push ds
    push dx
    push cx
    push ax
    
    mov ax,dx	;�����16λ���Գ����Ľ����ax����̣�dx�������
    xor dx,dx
    div cx
    push dx
    			;��������������
    mov dx,ax
    xor ax,ax
    mov ds:[0],ax
    mov ds:[2],dx;����16λ�ĳ�����������ڸߵ�ַ�ֵ�Ԫ��
    
    pop dx		;������16λ�������������
    pop ax		;���������ĵ�16λȡ����
    push ax		;�ָ�ջ����ά��push��popƽ��
    div cx		;��ʱdx��Ÿ�16λ������������ax��ű�������16λ
    			;�����ax����̣�dx�������
    			
    mov ds:[0],ax;����16λ�ĳ�������̷��ڵ͵�ַ�ֵ�Ԫ
    mov ds:[4],dx;������������ds:[4]�ֵ�Ԫ��
    ;������ĵ�16λ��ds:[0],��16λ��ds:[2],������ds:[4]
    pop ax
    pop cx
    pop dx
    pop ds
    ret
CODES ENDS
    END START


