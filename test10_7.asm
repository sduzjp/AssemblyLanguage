;dwtoc�ӳ���dword������ת��Ϊ��ʾʮ���������ַ���
;show_str�ӳ�����ʾ��0��β���ַ���
;��ʾʮ������ֵ�Ľ�����
;����Ľ��˳�����������⣬ʹ����divdw�ӳ���

DATAS SEGMENT
     db 256 dup (0)
DATAS ENDS
;����show���ݶ������Ե���ʮȡ�෨��ÿһλ
;��Ϊȡ���ǴӸ�λ��ʼȻ�������ŵ�
;������ʾ��Ӧ�ôӸ�λ��ʼ
show segment
	db 256 dup (0)
show ends
data segment
	dw 000fh,4240h
data ends

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
	mov bx,data
	mov ds,bx
	mov dx,ds:[0]
	mov ax,ds:[2]
    MOV bx,DATAS
    MOV ds,bx
    mov bx,show
    mov es,bx

    mov cx,0ah
    call dwtoc
    
    mov dh,8
    mov dl,3
    mov cl,2
    call show_str

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
   	
   	pop bx
   	pop ds
   	pop si
   	pop ax
   	pop cx
   	pop es
   	ret
        
    done:MOV AH,4CH
    INT 21H
    
CODES ENDS
    END START















