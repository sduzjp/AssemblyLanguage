;�˿ڵķ���
;CMOS RAM�д洢��ʱ����Ϣ
;��̣�����Ļ�м���ʾ�ԡ���/��/�� ʱ���֣��롱�ĸ�ʽ��ʾ��ǰ���ڡ�ʱ��
;�ꡢ�¡��ա�ʱ���֡�������ݶ���һ���ֽ�
;�Ľ�����
data segment
	db 16 dup (0)
data ends

CODES SEGMENT
    ASSUME CS:CODES
START:
	mov bx,data
    mov ds,bx
    xor si,si
    ;ʵ���ꡢ�¡��մ�ŵ�data��
    mov dl,9
    mov cx,3
    s:
    mov al,dl
    call read
    dec dl
	loop s
	
	;ʵ��ʱ�����ŵ�data��
	mov dl,4
	mov cx,3
	s0:
	mov al,dl
	call read
	sub dl,2
	loop s0

    ;������ʾ������
    mov bx,0b800h
    mov es,bx
    xor si,si
    xor di,di
    mov bx,160*12+30*2
    ;ʵ�ֽ����ڡ��¼�������������ʾ������
    mov dl,2
    mov cx,6
    s3:
    call show_number
    add di,2;ע������ֻ��Ҫ��di����2����Ϊ�����ӳ���ʱѭ��������es:di�Ѿ�ָ����һ����ʾ�ֽڵ�Ԫ
    loop s3
    
    ;ʵ�ֽ�����'/'�͸����������������м�ָ�
    mov cx,2
    mov si,4
    mov al,47
    s4:
    mov es:[bx+si],al
    mov es:[bx+si+1],dl
    add si,6
    loop s4
    
    ;ʵ�ֽ��ո��������ں�ʱ���м�ָ�
    mov al,32
    mov es:[bx+16],al
    mov es:[bx+17],dl
    
    ;ʵ�ֽ�����':'����ʱ������м�ָ�
    mov cx,2
    mov si,22
    mov al,58
    s5: 
    mov es:[bx+si],al
    mov es:[bx+si+1],dl
    add si,6
    loop s5
    
    MOV AH,4CH
    INT 21H
    
    ;�Ӷ˿ڶ����ӳ���
    read:
	push ds
	push cx
	
    out 70h,al;��70h�˿�д��al
    in al,71h;��71h�˿ڶ���(al)�ŵ�Ԫ���ֽ�������
    
    mov ah,al;�����ֽ������ݷֱ�����BCD��
    mov cl,4;ע�⵱�ƶ�λ������1ʱ�����ƶ�λ�������cl��
    shr ah,cl;�ֽڵĸ���λBCD��
    and al,00001111b;�ֽڵĵ���λBCD��
    
    add ah,30h;�ֱ���BCD������ʮ������ת���ɶ�Ӧ��ASCII��ֵ
    add al,30h

    mov byte ptr ds:[si],ah
    mov byte ptr ds:[si+1],al
    add si,2
  	
  	pop cx
  	pop ds
    ret
    
    ;��ʾ�����ӳ���
    show_number:
    push cx
    push bx
    push ds
    push es
    
    mov cx,2
    s2:
    mov al,ds:[si]
    mov es:[bx+di],al
    mov es:[bx+di+1],dl
    inc si
    add di,2
    loop s2
    
    pop es
    pop ds
    pop bx
    pop cx
    ret
    
CODES ENDS
    END START
