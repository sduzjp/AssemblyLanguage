;�˿ڵķ���
;CMOS RAM�д洢��ʱ����Ϣ
;��̣�����Ļ�м���ʾ��ǰ���·�

CODES SEGMENT
    ASSUME CS:CODES
START:
    mov al,8
    out 70h,al;��70h�˿�д��al
    in al,71h;��71h�˿ڶ���8�ŵ�Ԫ���ֽ�������
    
    mov ah,al;�����ֽ������ݷֱ�����BCD��
    mov cl,4;ע�⵱�ƶ�λ������1ʱ�����ƶ�λ�������cl��
    shr ah,cl;�ֽڵĸ���λBCD��
    and al,00001111b;�ֽڵĵ���λBCD��
    
    add ah,30h;�ֱ���BCD������ʮ������ת���ɶ�Ӧ��ASCII��ֵ
    add al,30h
    
    ;������ʾ������
    mov bx,0b800h
    mov es,bx
    mov cl,2
    mov byte ptr es:[160*12+40*2],ah
    mov byte ptr es:[160*12+40*2+1],cl
    mov byte ptr es:[160*12+40*2+2],al
    mov byte ptr es:[160*12+40*2+3],cl
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
