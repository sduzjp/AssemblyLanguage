;�ж��Ƿ�Ϊ����
DATAS SEGMENT
    infon db 0dh,0ah,'Please input a year:$';�����ռ�洢������ʾ��Ϣ������0d�س���0a����
    Y db 0dh,0ah,'This is a leap year!$';�����ռ�洢��������ʾ��Ϣ����һһ�����
    N db 0dh,0ah,'This is not a leap year!$';�����ռ�洢����������Ϣ����һһ�����
    W dw 0;�����ռ�洢����ַ�����Ӧ���������
    buf db 8
    	db ?
    	db 8 dup(0)
   ;�����ռ�Ϊ����������10���ֽ�
DATAS ENDS

STACKS SEGMENT
    db 200 dup(0)
STACKS ENDS;����һ���ֽ�Ϊ200��ջ��

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX;ָ�����ݶ�
    
    lea dx,infon
    mov ah,9
    int 21h;����Ļ����ʾ��ʾ������Ϣ
    
    lea dx,buf
    mov ah,10
    int 21h;�Ӽ�����������ַ���
    
    mov cl,[buf+1]
	mov ch,0;cx�д��ʵ�������ַ�����λ��
	lea di,buf+2;��ȡ�ַ����׵�ַ
	call datacate;�����ӳ�������ַ���ת��Ϊ�������
	call ifyears;�����ӳ����ж��Ƿ�Ϊ����
	jc a1;�ж�cf��־�Ĵ����Ƿ�Ϊ1����������ת��a1
	
	lea dx,n
	mov ah,9
	int 21h;�����������ʾ����������ʾ��Ϣ
	jmp exit
	
a1: lea dx,y
	mov ah,9
	int 21h;���������ʾ��������ʾ��Ϣ
	
exit:mov ah,4ch
	int 21h;���򷵻�
	
;������ַ���ת��Ϊ�������
datacate proc near;ָ�����ַ��������������
	push cx;����cx
	dec cx;cx�Լ�1��ʹ������ѭ��siָ�����һ���ַ�(buf�лس���ǰһ��)
	lea si,buf+2
tt1:
	inc si
	loop tt1
	pop cx;��siָ�����һ���ַ�
	
	mov dh,30h;�������ݣ������������ַ���Ӧ��ASCII��ת��Ϊ��������ֱ���
	mov bl,10;�������ݣ�����ÿ��һλʱʹax��10
	mov ax,1;ax����װ��Ӧλ��Ȩֵ
I1: push ax
	push bx
	push dx;�����Ĵ���ֵ
	
	sub byte ptr [si],dh;�������ַ�ת��Ϊ���ֱ���
	mov bl,byte ptr [si];��ȡ��λ����
	mov bh,0
	mul bx;��λ���ֳ��Զ�ӦȨֵ,ʵ�������ֲ��ᳬ��һ���ֽ�
	add [W],ax;�����ּӵ�����У����м����Ϊ��Ӧ�������
	
	pop dx
	pop bx
	pop ax;�ָ��Ĵ���ֵ
	mul bl;Ȩֵ����10
	dec si;si�Լ�1��ָ�����һλ
	loop I1
	ret;�ӳ��򷵻�
datacate endp
;�ж��Ƿ�Ϊ�����ӳ���
ifyears proc near;ָ���ӳ�������������
	push bx
	push cx
	push dx;�����Ĵ���ֵ
	
	mov ax,[W];��ȡ�������
	mov cx,ax;��������ֱ��ݵ�cx��
	mov dx,0
	mov bx,100
	div bx;�ж�����Ƿ��ܱ�100����
	cmp dx,0
	jnz lab1;����������ת��lab1�����ж��ܷ�4����
	mov ax,cx
	mov bx,400
	div bx;����������ж��ܷ�400����
	cmp dx,0
	jz lab2;��������ת��lab2
	clc;�����ܽ�cf��0����������
	jmp short lab3;��ת��lab3
lab1:
	mov ax,cx
	mov dx,0
	mov bx,4
	div bx;�ж��ܷ�4����
	cmp dx,0
	jz lab2;��������ת��lab2
	clc;��������cf��0����������
	jmp lab3;��ת��lab3
lab2:stc;cf��1��������
lab3:
	pop dx
	pop cx
	pop bx
	ret;�ӳ��򷵻�
ifyears endp

CODES ENDS
    END START



