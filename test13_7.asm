;DOS�ж�����Ӧ��int21h
;����Ļ��5��12����ʾ�ַ���"Welcome to masm!"
;����int21h�ĵھź��ӳ���Ҫ��ʾ���ӳ�������'$'��Ϊ������

DATAS SEGMENT
    db 'Welcome to masm','$' 
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
	mov ah,2;�ù��
	mov bh,0;��0ҳ
	mov dh,5;��5��
	mov dl,12;��12��
	int 10h;����int10h��2���ӳ����ù��
	
	;�״�㣺ע��ֻ����ds:dxָ���ַ����׵�ַ��������ds:si/ds:di
	
    MOV AX,DATAS
    MOV DS,AX
    xor dx,dx;ds:dxָ���ַ����׵�ַ
    mov ah,9
    int 21h;����int21h�ж����̵�9���ӳ�����ʾ�ַ���
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
