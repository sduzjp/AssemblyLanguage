;�˿ڵķ���
;CMOS RAM�д洢��ʱ����Ϣ
;��̣�����Ļ�м���ʾ�ԡ���/��/�� ʱ���֣��롱�ĸ�ʽ��ʾ��ǰ���ڡ�ʱ��
;�ꡢ�¡��ա�ʱ���֡�������ݶ���һ���ֽ�
;������ڸĽ��ط���
;(1)�����պ�ʱ�����ŵ�data�ε�ѭ������
;(2)���������ʾ������ʱ�����Լ�'/',':'�ַ�ѭ������
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
	push cx
    mov al,dl
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
    dec dl
    pop cx
    loop s
    
    mov si,6
    mov dl,4
    mov cx,3
    s0:
    push cx
    mov al,dl
    out 70h,al;��70h�˿�д��al
    in al,71h;��71h�˿ڶ���(al)�ŵ�Ԫ���ֽ�������
    
    mov ah,al;�����ֽ������ݷֱ�����BCD��
    mov cl,4;ע�⵱�ƶ�λ������1ʱ�����ƶ�λ�������cl��
    shr ah,cl;�ֽڵĸ���λBCD��
    and al,00001111b;�ֽڵĵ���λBCD��
    
    add ah,30h;�ֱ���BCD������ʮ������ת���ɶ�Ӧ��ASCII��ֵ
    add al,30h

    mov ds:[si],ah
    mov ds:[si+1],al
    add si,2
    sub dl,2
    pop cx
    loop s0
    
    ;������ʾ������
    mov bx,0b800h
    mov es,bx
    xor si,si
    xor di,di
    mov bx,160*12+30*2
    mov dl,2
    mov cx,2
    s1:
    mov al,ds:[si]
    mov es:[bx+di],al
    mov es:[bx+di+1],dl
    inc si
    add di,2
    loop s1
    mov al,47
    mov es:[bx+4],al
    mov es:[bx+5],dl
    
    mov di,6
    mov cx,2
    s2:
    mov al,ds:[si]
    mov es:[bx+di],al
    mov es:[bx+di+1],dl
    inc si
    add di,2
    loop s2
    mov al,47
    mov es:[bx+10],al
    mov es:[bx+11],dl
    
    mov di,12
    mov cx,2
    s3:
    mov al,ds:[si]
    mov es:[bx+di],al
    mov es:[bx+di+1],dl
    inc si
    add di,2
    loop s3
    mov al,32
    mov es:[bx+16],al
    mov es:[bx+17],dl
    
    mov di,18
    mov cx,2
    s4:
    mov al,ds:[si]
    mov es:[bx+di],al
    mov es:[bx+di+1],dl
    inc si
    add di,2
    loop s4
    mov al,58
    mov es:[bx+22],al
    mov es:[bx+23],dl
    
    mov di,24
    mov cx,2
    s5:
    mov al,ds:[si]
    mov es:[bx+di],al
    mov es:[bx+di+1],dl
    inc si
    add di,2
    loop s5
    mov al,58
    mov es:[bx+28],al
    mov es:[bx+29],dl
    
    mov di,30
    mov cx,2
    s6:
    mov al,ds:[si]
    mov es:[bx+di],al
    mov es:[bx+di+1],dl
    inc si
    add di,2
    loop s6

    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
