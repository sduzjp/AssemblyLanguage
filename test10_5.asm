;dtoc�ӳ���word������ת��Ϊ��ʾʮ���������ַ���
;show_str�ӳ�����ʾ��0��β���ַ���
;�ó�����Ҫ��һ���Ľ��ĵط���������Ȳ�֪��ax��ֵλ��
;����ж����ֵ��Ҫ��ʾ
DATAS SEGMENT
    db 10 dup (0) 
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV bx,DATAS
    MOV DS,bx
    mov ax,12666
    xor si,si
    call dtoc
    
    mov dh,8
    mov dl,3
    mov cl,2
    call show_str
    
    MOV AH,4CH
    INT 21H
    ;���ó�10ȡ�෨���ν�ax�и�λ������ȡ����
    ;Ȼ�����30H��Ϊ��Ӧ��ASCII����ֵ���
    ;ע���ŵ�ʱ���˳������ȡ��ʱ�Ǵ����λ��ʼ
    ;���Դ��ʱҪ��˳�򷴹���
    dtoc:push ax
    push cx
    push ds
    push bx
    push dx
    push di
    
    mov di,8
    mov cx,5
    mov bx,10
    s:xor dx,dx
    div bx
    add dx,30h
    mov ds:[di],dx
    sub di,2
    loop s
    
    xor ax,ax
    mov ds:[10],ax
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
   	mov di,0
   	
   	mov cx,16
   	
   	s0:mov al,ds:[di]
   	mov es:[bx+si+4],al
   	mov es:[bx+si+5],dl
   	add si,2
   	inc di
   	loop s0
   	
   	
   	pop bx
   	pop ds
   	pop si
   	pop ax
   	pop cx
   	pop es
   	ret
    

CODES ENDS
    END START

