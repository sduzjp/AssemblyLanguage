;BIOS�ж�����Ӧ��
;����Ļ��5��12����ʾ3����׸�����˸��ɫ��'a'

CODES SEGMENT
    ASSUME CS:CODES
START:
    mov ah,2;�ù��
    mov bh,0;��ʾ��0ҳ
    mov dh,5;��ʾ��5��
    mov dl,12;��ʾ��12��
    int 10h  ;����int 10h�ж�������2���ӳ���
    
    mov ah,9;�ڹ��λ����ʾ�ַ�
    mov al,'a';al�д���ַ�
    mov bl,11001010b;bl�д����ɫ���ԣ�11001010���ں�׸�����˸��ɫ
    mov  bh,0;��0ҳ
    mov cx,3;�ַ��ظ��ĸ���
    int 10h;����int 10h�ж����̵�9���ӳ���
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
