;��һ��ȫ����ĸ���ַ���ת��Ϊ��д

DATAS SEGMENT
    db 'conversation'  
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    xor si,si		;ds��siָ��datas��
    
    mov cx,12		;�ַ�����12����ĸ�����ѭ��12��
    call capital	;����capital�ӳ��򣬽���ĸת��Ϊ��д
  
    MOV AH,4CH
    INT 21H
    
    capital:and byte ptr [si],11011111b
    ;��ĸת��Ϊ��дֻ��Ҫ��30H������������
    inc si
    loop capital
    ret
    
CODES ENDS
    END START
