;ʵ����������15λ����
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
datas ends

show segment
	db 128 dup(0)
show ends
;����һ��ջ�������������ֵ�4��16λ
stack segment
	dw 4 dup(0)
stack ends
code segment
	assume cs:code,ds:data,ss:stack
start:
	;��int21h��10�Ź��ܵ���ʵ������һ���ַ������浽�ڴ滺����data
	mov ax,data
	mov ds,ax
	
	lea dx,infon1
	mov ah,9
	int 21h
	
	lea dx,buf
	mov ah,10
	int 21h 

	mov si,2
	mov cx,15
	a:
	mov al,ds:[si]
	call change
	mov ds:[si],al
	inc si
	loop a

	mov bx,data
	mov ds,bx
	lea dx,infon2
	mov ah,9
	int 21h
	
	lea dx,buf1
	mov ah,10
	int 21h 
	
	lea si,buf1+2
	mov cx,15
	b:
	mov al,ds:[si]
	call change
	mov ds:[si],al
	inc si
	loop b
    
    lea si,buf+16
    lea di,buf1+16
    mov cl,[buf+1]
    mov ch,0
    mov al,0
 lp:push cx
 	mov cl,0ah
 	add al,ds:[si]
 	add al,ds:[di]
 	mov ah,0
 	div cl
 	mov ds:[si],ah
 	dec si
 	dec di
 	pop cx
 	loop lp
 	
overlp:
	mov bx,0b800h
	mov es,bx
	mov di,160*10+20*2;es:diָ����ʾ������
	mov si,2;ds:siָ�������ַ���
	mov cx,15
	cmp al,0
	jz xianshi
	mov ds:[1],al
	mov si,1
	mov cx,16
	
xianshi:
	;�Ƚ�����ַ���ת��ΪASCII���Ӧ��ֵ
	push cx
	push si
	jia:
	mov al,30h
	add [si],al
	inc si
	loop jia
	pop si;�ָ�si,cxֵʵ�ִ�������ʾ������
	pop cx
	mov dl,2
	xianshi1:
	mov al,ds:[si]
	mov es:[di],al
	mov es:[di+1],dl
	inc si
	add di,2
	loop xianshi1
	
	
	mov ax,4c00h
	int 21h

   	change:
	push bx
	push es
	
	cmp al,'0'
	jb ok
	cmp al,'9'
	jna next1
	cmp al,'A'
	jb ok
	cmp al,'F'
	jna next2
	cmp al,'a'
	jb ok
	cmp al,'f'
	jna next3
	jmp short ok
	
	next1:
	sub al,30h
	jmp short ok
	next2:
	sub al,37h
	jmp short ok
	next3:
	sub al,57h
	jmp short ok
	ok:nop
	pop es
	pop bx
	ret
	
code ends
	end start
