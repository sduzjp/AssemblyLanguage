;��д0���жϳ���ʹ�ó������ʱ
;��Ļ�м���ʾ"divide overflow!"
;Ȼ�󷵻�dos
CODES SEGMENT
    ASSUME CS:CODES
START:
	;��װdo0�жϳ���
    MOV AX,cs
    MOV DS,AX
    mov si,offset do0;����ds:siָ��do0����Ҫ��װ�ĳ����׵�ַ
    
    xor ax,ax
    mov es,ax
    mov di,200h;����es:siָ��װ��Ŀ�ĵ�ַ0000:0200
    
    ;mov cx,offset do0
    ;sub cx,offset nextע�ⲻ������ֱ�Ӽ�
    ;mov ax,offset do0
    ;mov cx,offset next
    ;sub cx,ax;Ӧ��������
    mov cx,offset next-offset do0;����cxΪ���䳤��
    cld
    rep movsb
    
    ;����0���ж�������
    xor ax,ax
    mov es,ax
    mov word ptr es:[0],200h
    mov word ptr es:[2],0
    
    ;���Գ��������ʾdivide overflow��
    mov ax,4240h
    mov dx,000fh
    mov cx,10
    div cx
    ;int 0
    MOV AH,4CH
    INT 21H
    
    ;do0�ж��ӳ���
    do0:
    jmp short do0start
    db "divide overflow!"
    ;����ʾ���ַ���������ʾ������
    do0start:
    push ax
    push bx
    push cx
    push di
    push si
    push ds
  
    mov ax,cs
    mov ds,ax
    mov si,202h;����ds:siָ���ַ����׵�ַ
    mov ax,0b800h
    mov es,ax
    xor di,di
    mov dl,2
    mov bx,500h
    mov cx,16
    s:
    mov al,ds:[si]
    mov es:[bx+di],al
    mov es:[bx+di+1],dl
    inc si
    add di,2
    loop s
    
    pop ds
    pop si
    pop di
    pop cx
    pop bx
    pop ax
    
    mov ax,4c00h
    int 21h
	iret
next:nop
CODES ENDS
    END START




