;��д��װ7ch���ж�����
;�ж����������һ��word������ƽ���Ĺ���
;����ֵ:dx,ax�ֱ��Ž���ĸ�16λ�͵�16λ
;ͬʱ������ʾdword�����ݵ��ӳ�����֤�ж��ӳ���

data segment
	db 256 dup (0)
data ends

show segment
	db 256 dup (0)
show ends
;����show���ݶ������Ե���ʮȡ�෨��ÿһλ
;��Ϊȡ���ǴӸ�λ��ʼȻ�������ŵ�
;������ʾ��Ӧ�ôӸ�λ��ʼ
CODES SEGMENT
    ASSUME CS:CODES
START:
	mov ax,cs
	mov ds,ax
	mov si,offset sqr;����ds:siָ���ж������׵�ַ
	xor ax,ax
	mov es,ax
	mov di,200h;����es:diָ��װ��Ŀ�ĵ�ַ0000:0200
	mov cx,offset sqrend-offset sqr
	cld;����df=0,si,di����
	rep movsb

	;�����ж����������ж����̵ĳ�����ڵ�ַ����
	xor ax,ax
	mov es,ax
	mov word ptr es:[7ch*4],200h
	mov word ptr es:[7ch*4+2],0
	
    MOV AX,3456
    int 7ch
    add ax,ax
    adc dx,dx;����λ�ӷ�,(dx)=(dx)+(dx)+CF
    
    ;��dx,ax������ʾ���������״�㣺��Ҫ����ת���ɶ�Ӧ��ASCII��ֵ
    ;��dx,ax�е���������ת��Ϊ��ӦASCII��ֵ
    MOV bx,DATA
    MOV ds,bx
    mov bx,show
    mov es,bx
    mov cx,0ah
    call dwtoc
    
    mov dh,8
    mov dl,3
    mov cl,2
    call show_str
    
    MOV AH,4CH
    INT 21H
    
    sqr:
    mul ax;���ﲻ��Ҫpush��pop ax���������׳���
    iret
sqrend:nop
	dwtoc:
	push ax
	push bx
	push cx
	push ds
	xor si,si
	xor di,di
	s:
	call divdw
	mov bx,ds:[4]
	add bx,30h
	mov es:[si],bx
	inc di			;����di��¼�����ж���λ
	mov ax,ds:[0]	;ע��ѭ������calldiwʱ�����Ԥ�ȴ����ax��dx��������һ��ȡ�����̴��
	mov dx,ds:[2]
	add si,2
	cmp dx,0		;��������־ax��dx�д�����ݶ�Ϊ0
	je next
	jmp far ptr s
	next:
	cmp ax,0
	je ok
	jmp far ptr s
	
	ok:
	xor si,si		;ʵ�ֽ�show�ε���������ŵ�ds����
	mov cx,di
	dec di
	add di,di
	s1:
	mov ax,es:[di]
	mov ds:[50+si],ax
	sub di,2
	add si,2
	loop s1
	
	ok1:
	xor ax,ax
	mov ds:[50+si],ax
	
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
    
    show_str:
   	push es
   	push cx
   	push ax
   	push si
   	push ds
   	push bx
   	
   	
   	mov bx,0b800h
   	mov es,bx
   	mov bx,500h
   	mov dl,cl
   	xor di,di
   	xor si,si
   	
   	s0:mov al,ds:[50+di]		;ע���Ƕ��ֽڵ�Ԫ���д洢
   	mov es:[bx+si+4],al
   	mov es:[bx+si+5],dl
   	add si,2
   	add di,2					
   	;ʵ����ʮ����ÿλ�ϵ���С��10
   	;�������ڴ浥Ԫ���ʱֻ�����ӵ�Ԫ�ĵ͵�ַ�ֽڵ�Ԫ
   	;���di����2�������ǵ���1
   	cmp al,0
	jna done
   	jmp short s0
   	
   	done:nop
   	pop bx
   	pop ds
   	pop si
   	pop ax
   	pop cx
   	pop es
   	ret
     
CODES ENDS
    END START







