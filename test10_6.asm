;dtoc�ӳ���word������ת��Ϊ��ʾʮ���������ַ���
;show_str�ӳ�����ʾ��0��β���ַ���
;��ʾʮ������ֵ�Ľ�����
;������Ľ��ط������ڳ������
DATAS SEGMENT
    db 10 dup (0) 
DATAS ENDS

stack segment
	db 256 dup (0)
stack ends

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV bx,DATAS
    MOV DS,bx
    mov bx,stack
    mov ss,bx
    mov sp,100h
    mov ax,10000
    xor si,si
    call dtoc
    
    mov dh,8
    mov dl,3
    mov cl,2
    call show_str
    
    done:MOV AH,4CH
    INT 21H
    ;���ó�10ȡ�෨���ν�ax�и�λ������ȡ����
    ;Ȼ�����30H��Ϊ��Ӧ��ASCII����ֵ���
    ;ע���ŵ�ʱ���˳������ȡ��ʱ�Ǵ����λ��ʼ
    ;���Դ��ʱҪ��˳�򷴹���,����push��popָ��ʵ����һ����
    dtoc:push ax
    push cx
    push ds
    push bx
    push dx
    push di
    
    xor si,si
	s:mov cx,10
	xor dx,dx
	div cx
	add dx,30h
	push dx
	inc si
	mov cx,ax
	jcxz s1			;jcxzָ���ǵ�cx=0����ת����Ŵ�ִ��
	jmp near ptr s
	
	s1:xor di,di
	mov cx,si
	s2:pop ds:[di]
	add di,2		;ע��di�ĵ�����ֵ
	dec cx
    jcxz s3
	jmp short s2
	
	s3:xor ax,ax	;ע�����Ҫ���ַ��������ֵ�Ԫ���0
	mov ds:[di],ax
	
    pop di
    pop dx
    pop bx
    pop ds
    pop cx
    pop ax
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
   	
   	s0:mov al,ds:[di]		;ע���Ƕ��ֽڵ�Ԫ���д洢
   	mov es:[bx+si+4],al
   	mov es:[bx+si+5],dl
   	add si,2
   	add di,2
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
    

CODES ENDS
    END START


