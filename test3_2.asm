;ʵ��������������λ��(���15λ)ʮ������
;��15λ��������н�λҲ��������ʾ����16λ������ӽ�λ�Ļ�����Ķ���ʾλ��
;��������16λ������λ����Ӿ���������ʾʮ��������ӽ��
;����һ����������ż�������
data segment
	buf db 100
		db ?
		db 100 dup(0)
	buf1 db 100
		 db ?
		 db 100 dup(0)
	infon1 db 0dh,0ah,'Please input the first number:$'
	infon2 db 0dh,0ah,'Please input the second number:$'
data ends

datas segment
	db 128 dup(0)
datas ends;����һ��datas���ݶΣ�128���ֽ�

show segment
	db 128 dup(0)
show ends;����һ��show���ݶΣ�128���ֽ�

show1 segment
	db 128 dup(0)
show1 ends;����һ��show1���ݶΣ�128���ֽ�

stack segment
	dw 4 dup(0)
stack ends;����һ��ջ�������������ֵ�4��16λ

code segment
	assume cs:code,ds:data,ss:stack
start:
	;��int21h��10�Ź��ܵ���ʵ������һ���ַ������浽�ڴ滺����data
	mov ax,data
	mov ds,ax
	
	lea dx,infon1
	mov ah,9
	int 21h;��Ļ��ʾ��ʾ������Ϣ
	
	lea dx,buf
	mov ah,10
	int 21h ;�����һ��ʮ�������ַ���
	
	mov bx,show
	mov es,bx
	xor di,di;es:diָ��show�Σ����δ������ʮ���Ƶĵ�λ����λ
	lea si,buf+1
	mov cl,[buf+1]
	mov ch,0;ʵ������ʮ������λ��
	add si,cx;ds:siָ���һ��ʮ���������һλ
	a:
	mov al,ds:[si]
	sub al,30h;��ʮ�����ַ����ַ�ת��Ϊʮ����
	mov es:[di],al;ʮ�������ӵ�λ��ʼ�浽show��
	dec si
	inc di
	loop a
	;δ��16λ�ĸ�λλ����0
	mov cl,[buf+1]
	mov ch,0
	mov si,16
	sub si,cx
	cmp si,0
	jz tiaoguo;����16λ����������0
	mov cx,si
bu0:
	mov al,0
	mov es:[di],al
	inc di
loop bu0
tiaoguo:
	lea dx,infon2
	mov ah,9
	int 21h;��Ļ��ʾ��ʾ������Ϣ
	
	lea dx,buf1
	mov ah,10
	int 21h ;����ڶ���ʮ�������ַ���
	
	mov bx,show1
	mov es,bx
	xor di,di;es:diָ��show1��
	lea si,buf1+1
	mov cl,[buf1+1]
	mov ch,0;cx���ʵ�������ʮ��������λ��
	add si,cx;ds:siָ��ڶ���ʮ�������ַ������һλ
	b:
	mov al,ds:[si]
	sub al,30h;��ʮ�����ַ����ַ�ת��Ϊʮ������
	mov es:[di],al;��ʮ�������ӵ�λ��ʼ��ŵ�show1��
	dec si
	inc di
	loop b
	;δ��16λ�ĸ�λλ����0
	mov cl,[buf1+1]
	mov ch,0
	mov si,16
	sub si,cx
	cmp si,0
	jz tiaoguo1;����16λ����������0
	mov cx,si
bu1:
	mov al,0
	mov es:[di],al
	inc di
loop bu1
    ;�������������ʮ�������ӵ�λ����λ�ֱ�����show��show1��

tiaoguo1:   
    mov bx,show
    mov ds,bx
    xor si,si;ds:siָ��show�Σ���һ��ʮ������
    xor di,di;es:diָ��show1�Σ��ڶ���ʮ������
    xor al,al;��(al)��0
	mov cx,16
lp:push cx
 	mov cl,0ah
 	add al,ds:[si]
 	add al,es:[di]
 	mov ah,0;���е�ʮ�����Ƽӷ����תʮ����
 	div cl;ah�����������ʮ���Ʊ�λ����al���̴���ʮ���ƽ�λ��
 	mov ds:[si],ah;�����ʮ���Ƽӷ�����ӵ�λ����λ��ŵ�show��
 	inc si
 	inc di
 	pop cx
loop lp
 	
 	;�Ƚ�����ʵ�������ʮ������λ��
 	mov bx,data
 	mov ds,bx;ʹdsָ��data�����
 	mov al,[buf+1]
 	mov bl,[buf1+1];�ֱ�ȡ����������ʮ�����ַ�����λ��
 	mov cx,show
	mov ds,cx;�ָ�ds����ָ��show��
 	cmp al,bl
 	jnb next1;��(al)>=(bl),���һ��ʮ������λ����
 	jmp short next2;��(al)<(bl),��ڶ���ʮ������λ����
next1:
	mov ah,0
	mov bx,ax
	mov si,ds:[bx];�ж�����һ���ַ��Ƿ�Ϊ0�����ж��Ƿ���ڽ�λ
	cmp si,0
	jz overnext1;��Ϊ0���������ڽ�λ������ʾλ����������λ���еĴ���
	add ax,1;��Ϊ0�������ڽ�λ������ʾλ��Ҫ����������ʮ����λ�������λ������1
	mov si,ax
	jmp short zhuanhuan
next2:
	mov bh,0
	mov si,ds:[bx];ͬ���ж������ַ��Ƿ�Ϊ0�Ӷ�ȷ����ʾλ��
	cmp si,0
	jz overnext2
	add bx,1
	mov si,bx
	jmp short zhuanhuan
overnext1:
 	mov si,ax
 	jmp short zhuanhuan
overnext2:
	mov si,bx
	;������ʮ���ƽ��������ʾ��������ת��ΪASCII��ֵ
zhuanhuan:
    mov cx,si;cx��¼��Ҫ��ʾ��λ��
	mov bx,0b800h
	mov es,bx
	mov di,160*10+20*2;es:diָ����ʾ�������м�
    mov dl,2
 lp1:
 ;����show�ε͵�ַ��ŵ��ֽڵ�Ԫ�������ʾ��ʱ��Ҫ����浽��ʾ����
	mov al,ds:[si-1]
	add al,30h
    mov es:[di],al
    mov es:[di+1],dl
	dec si
	add di,2
 loop lp1
	
	mov ax,4c00h
	int 21h;���򷵻�
	
code ends
	end start

