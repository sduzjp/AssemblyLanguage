;�����жϵ��ã�����Ļ����ʾ1-9֮�����������жϺ�Ϊ86H��
;��Ҫд���ж��ӳ��򣬰�װ���ж��ӳ���(��װ���ڴ�0000:0200�У���Ϊ��ʱ���ܻᷢ���ж�)
;�����ж�������
;д�ж��ӳ��򣬲���һ��1-9�������

CODES SEGMENT
    ASSUME CS:CODES
START:
	;�����ж��������жϺ�Ϊ86H
	xor ax,ax
	mov es,ax
	mov ax,offset suijishu;ȡ���жϳ���ƫ�Ƶ�ַ
	mov word ptr es:[86h*4],ax
	mov ax,seg suijishu;ȡ���жϳ���ε�ַ
	mov word ptr es:[86h*4+2],ax
	
	;����86H�ж��ӳ���
	int 86h
	
	mov ax,4c00h
	int 21h;���򷵻�
	;�жϳ���ʵ�ֲ���һ��1-9���������ʾ
suijishu:
	push ax
	push dx;�����Ĵ���ֵ
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
    pop ax;�ָ��Ĵ���ֵ
	iret

CODES ENDS
    END START


