;�����ʵ������1λ��8λ֮������λ16����������ʾ
;������Ƶ�����ӳ���:change,lbyte,dwtoc,divdw,show_str
;change�ӳ���ʵ������16�����ַ���ת��Ϊ16������
;lbyte�ӳ���ʵ�����������ַ��浽һ���ֽڵ�Ԫ
;dwtocͨ����10ȡ�ཫ16������ת��Ϊ��Ӧ10������ASCII��ֵ
;divdwʵ��32λ(˫����)����
;show_str�ӳ���ʵ����ʾ��0��β���ַ���

;����һ������������������ʮ�������ַ���
data segment
	buf db 100
		db ?
		db 100 dup(0)
	infon db 0dh,0ah,'Please enter hexadecimal digits:$'
data ends

datas segment
	db 128 dup(0)
datas ends

show segment
	db 128 dup(0)
show ends

code segment
	assume cs:code,ds:data
start:
	;��int21h��10�Ź��ܵ���ʵ������һ���ַ������浽�ڴ滺����data
	mov ax,data
	mov ds,ax
	
	lea dx,infon;����Ļ����ʾ��ʾ��Ϣ
	mov ah,9
	int 21h;��infon��ʼ���ַ����������Ļ
	
	lea dx,buf;�Ӽ�������һ��ʮ��������
	mov ah,10
	int 21h 
	
	lea si,buf+2
	mov cl,[buf+1];ע��[buf+1]��һ���ֽڵ�Ԫ
	mov ch,0;cx��������ʮ������λ��
a:
	push cx;����cx
	mov al,ds:[si]
	call change;����change�ӳ���������ַ�ת��Ϊʮ����������
	mov ds:[si],al;��ת��������ִ��ԭ�ڴ��ֽڵ�Ԫ
	inc si
	pop cx;�ָ�cx,ʵ��cx�Լ�
loop a
	;ʵ�ֽ�ʮ���������ִ�ŵ�show��
	;ʵ�ָ�λ���ִ���ڸߵ�ַ��Ԫ����λ���ִ���ڵ͵�ַ��Ԫ
	mov bx,show
	mov es,bx
	mov di,0;es:diָ��show��
	lea si,buf+1 
	mov al,[buf+1]
	mov ah,0
	add si,ax;ds:siָ�򻺳����ַ������һλ��Ŵ�
	mov cl,[buf+1];���ô��䳤��
	mov ch,0
chuanshu:
	mov al,ds:[si]
	mov es:[di],al
	dec si
	inc di
	loop chuanshu 
	
    ;����������λ��δ��8λ����λ��λ��0
	mov cx,8
	mov al,[buf+1]
	mov ah,0
	sub cx,ax;δ��8λ��λ��
chuanshu1:
	mov al,0
	mov es:[di],al
	inc di
	loop chuanshu1
	;����ʮ��������������λ����ŵ�show����
	;����ÿ��λ�ϵ����ִ��һ���ֽڵ�Ԫ����������ϵ�һ��
	
	mov bx,es
	mov ds,bx
	xor si,si
	call lbyte;����lbyte�ӳ���ʵ���������ֺϵ�һ���ֽڵ�Ԫ
	mov ax,ds:[0]
	mov dx,ds:[2]
	
	MOV bx,DATAS
    MOV ds,bx
    mov bx,show
    mov es,bx
    mov cx,0ah
    call dwtoc
    ;����dwtoc�ӳ���dx��ax�е�ʮ��������ת��Ϊʮ��������Ӧ��ASCII��ֵ
    
    mov cl,2
    call show_str;����show_str�ӳ�����ʾʮ������
    
	done:mov ax,4c00h
	int 21h
	
	dwtoc:
	push ax
	push bx
	push cx
	push ds
	xor si,si
	xor di,di
	s:
	call divdw;����divdw�ӳ���dx��axʮ����������10ȡ��
	mov bx,ds:[4];bx��¼ÿһ�γ�10������
	add bx,30h;ת��Ϊʮ��������ӦASCII��ֵ
	mov es:[si],bx
	inc di			;����di��¼�����ж���λ
	mov ax,ds:[0]	;ע��ѭ������calldiwʱ�����Ԥ�ȴ����ax��dx��������һ��ȡ�����̴��
	mov dx,ds:[2]
	add si,2
	cmp dx,0		;��������־ax��dx�д�����ݶ�Ϊ0
	je next;(dx)Ϊ0�����ж�(ax)�Ƿ�Ϊ0
	jmp far ptr s;(dx)��Ϊ0��������г�10ȡ��
	next:
	cmp ax,0
	je ok1;(ax)Ϊ0�����������ѭ��
	jmp far ptr s;(ax)��Ϊ0��������г�10ȡ��
	
	ok1:
	xor si,si;ʵ�ֽ�show�ε���������ŵ�ds����
	mov cx,di;di��¼��ʮ����λ���浽cx��
	dec di;����λ���������ǰ�����1�����Լ�ȥ1
	add di,di;es:diָ��show�����һ���ڴ��ֵ�Ԫ
	s1:
	mov ax,es:[di]
	mov ds:[si],ax;ds:siָ��datas��
	sub di,2;�������һ���ֵ�Ԫ��ѭ���Լ�Ϊ2
	add si,2
	loop s1
	
	xor ax,ax;��ʮ�������ַ�������0
	mov ds:[si],ax
	
	pop ds
	pop cx
	pop bx
	pop ax
	ret
	
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
    ;��ʾһ��ʮ����������0��β���ַ���
    show_str:
   	push es
   	push cx
   	push ax
   	push si
   	push ds
   	push bx
   	
   	mov bx,0b800h
   	mov es,bx;ָ����ʾ�������м�
   	mov si,160*12+40*2
   	mov dl,cl
   	xor di,di
   	
   	s0:mov al,ds:[di]		;ע���Ƕ��ֽڵ�Ԫ���д洢
   	mov es:[si],al
   	mov es:[si+1],dl
   	add si,2
   	add di,2					
   	;ʵ����ʮ����ÿλ�ϵ���С��10
   	;�������ڴ浥Ԫ���ʱֻ�����ӵ�Ԫ�ĵ͵�ַ�ֽڵ�Ԫ
   	;���di����2�������ǵ���1
   	cmp al,0;�ж��Ƿ�Ϊ0(���ַ����Ƿ����)
	jna done
   	jmp short s0
   	
   	pop bx
   	pop ds
   	pop si
   	pop ax
   	pop cx
   	pop es
   	ret
   	;�������ʮ�������ַ�ת��Ϊ��Ӧ��ʮ��������
   	change:
	push bx
	push es
	
	cmp al,'0'
	jb ok
	cmp al,'9';�ж��Ƿ�Ϊ�����ַ�'0'��'9'
	jna next1
	cmp al,'A'
	jb ok
	cmp al,'F';�ж��Ƿ�Ϊ��д��ĸ�ַ�'A'��'F'
	jna next2
	cmp al,'a'
	jb ok
	cmp al,'f';�ж��Ƿ�ΪСд��ĸ�ַ�'a'��'f'
	jna next3
	jmp short ok
	
	next1:
	sub al,30h;��Ϊ�����ַ����ȥ30H
	jmp short ok
	next2:
	sub al,37h;��Ϊ��д��ĸ�ַ����ȥ37H
	jmp short ok
	next3:
	sub al,57h;��ΪСд��ĸ�ַ����ȥ57H
	jmp short ok
	ok:nop
	pop es
	pop bx
	ret
	
	lbyte:
	xor di,di
	mov cx,4;ѭ���Ĵ�
	s4:
	push cx;����cx
	mov al,ds:[si]
	mov bl,ds:[si+1]
	mov cl,4
	shl bl,cl;ȡ��һ���ֽڵ�Ԫ��λʮ��������
	add bl,al;����һ���ֽڵ�Ԫ��λʮ�����������Ӷ��ϲ�����һλʮ��������
	mov ds:[di],bl;���ϲ����ʮ�������浽show��
	inc di;�ϲ����ʮ��������ռһ���ֽڣ�di����1
	add si,2;si����2
	pop cx;�ָ�cx
	loop s4
	ret
code ends
	end start

