;��д��װ�ж�7ch���ж�����
;��һ��ȫ����ĸ��0��β���ַ���ת��Ϊ��д

DATAS SEGMENT
    db 'conversation',0
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES
START:
	mov ax,cs
	mov ds,ax
	mov si,offset capital;����ds:siָ���жϳ����׵�ַ
	xor ax,ax
	mov es,ax
	mov di,200h;����es:diָ��װ��Ŀ�ĵ�ַ0000:0200
	mov cx,offset capitalend-offset capital;���ô��䳤��
	cld;����df=0��si,di����
	rep movsb
	
	;����int7ch�ж�����������
	xor ax,ax
	mov es,ax
	mov word ptr es:[7ch*4],200h
	mov word ptr es:[7ch*4+2],0
	
	;����int7ch�ж����̽��ַ���ת��Ϊ��д
    MOV AX,datas
    mov ds,ax
    xor si,si
    int 7ch
    
    ;������ʾ�ַ����ӳ�����֤�ж����̽��
    mov ax,datas
    mov ds,ax
    xor si,si
    MOV dh,8
    MOV dl,3
    mov cl,2
    call show_str
    
    MOV AH,4CH
    INT 21H
    
    capital:
    push cx
    push si
    
    change:
    mov cl,[si]
    xor ch,ch
    jcxz ok;�������ַ�Ϊ0ʱ����ѭ��
    and byte ptr [si],11011111b
    inc si
    jmp short change
    
    ok:pop si
    pop cx
    iret
    
   	capitalend:nop
        
    show_str:
   	push es
   	push cx
   	push ax
   	push si
   	push ds
   	push bx
   	
   	mov bx,0b800h
   	mov es,bx
   	mov al,160
   	mul dh
  	mov bx,ax
   	dec dl
   	add dl,dl
   	xor dh,dh
   	add bx,dx
   	mov dl,cl
   	xor di,di
   	xor si,si
   	
   	mov cx,16
   	
   	s:mov al,ds:[di]
   	mov es:[bx+si],al
   	mov es:[bx+si+1],dl
   	add si,2
   	inc di
   	loop s
   	
   	
   	pop bx
   	pop ds
   	pop si
   	pop ax
   	pop cx
   	pop es
   	ret
CODES ENDS
    END START



