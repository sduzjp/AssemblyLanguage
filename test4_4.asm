;�����жϵ��ã�����Ļ����ʾ1-9֮�����������жϺ�Ϊ86H��
;��Ҫд���ж��ӳ��򣬰�װ���ж��ӳ���(��װ���ڴ�0000:0200�У���Ϊ��ʱ���ܻᷢ���ж�)
;�����ж�������
;д�ж��ӳ��򣬲���һ��1-9�������

CODES SEGMENT
    ASSUME CS:CODES
START:
	;mov ax,cs
	;mov ds,ax
	;mov si,offset suijishu;ds:siָ��Դ��ַ
	;
	;xor ax,ax
	;mov es,ax
	;mov di,200h;es:diָ��װ��Ŀ�ĵ�ַ
	;mov cx,offset suijishuend-offset suijishu;���ô��䳤��
	;cld;����df=0,si,di����
	;rep movsb
	;
	;�����ж��������жϺ�Ϊ86H
	xor ax,ax
	mov es,ax
	mov ax,offset suijishu
	mov word ptr es:[86h*4],ax;�жϳ���ƫ�Ƶ�ַ
	mov ax,seg suijishu 
	mov word ptr es:[86h*4+2],ax;�жϳ���ε�ַ
	
	;����86H�ж��ӳ���
	int 86h
	
	mov ax,4c00h
	int 21h;���򷵻�
	
suijishu:
	push ax
	push dx
	sti;stiָ�IF=1,��Ӧint 1ah�ж�
    MOV ah,0
    int 1ah;���õ�1ah��0�ӳ��򣬶�ȡʼ�յδ����
    
    mov ax,dx;�����������������ax
    and ax,15;����������õ���4λ,(ah)=0
    mov dl,10
    div dl;��10��,ah�д������,al�д����.�����������ʮ������
    mov dl,2;�����ַ���ɫ
    cmp ah,0;�ж�������Ƿ�Ϊ0
    jz next;��Ϊ0����1��Ϊ��ʾ�����1
    jmp short next1
next:
	add ah,1
next1:
    add ah,30h;��ʮ���������ת��Ϊ��ӦASCII��ֵ
    mov bx,0b800h
    mov es,bx
    mov es:[160*12+40*2],ah
    mov es:[160*12+40*2+1],dl;����Ļ�м���ʾ�����
    
    pop dx
    pop ax
	iret

CODES ENDS
    END START

