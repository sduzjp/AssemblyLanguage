;��f000H�ε����16���ַ����Ƶ�data����
DATAS SEGMENT
    db 16 dup (0)  
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,0f000h
    MOV DS,AX	;ds:siָ��F000:ffff
    mov si,0ffffh
    mov ax,datas
    mov es,ax
    mov di,15;ds:diָ��datas:000f
    mov cx,16;����cxΪ���䳤��
    std		 ;����df=1��si��di�ݼ�
    rep movsb
    
    MOV AH,4CH
    INT 21H
    
CODES ENDS
    END START


