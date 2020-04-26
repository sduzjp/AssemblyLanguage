;�ַ���������


CODES SEGMENT
    ASSUME CS:CODES
START:

	call getstr
	
    MOV AH,4CH
    INT 21H
    
    getstr:
    push ax
    
    getstrs:
    xor ah,ah
    int 16h
    cmp al,20h
    jb nochar;�ж������ַ�ASCII�룬��С��20h�������Ĳ����ַ�
    xor ah,ah
    call charstack;����0�Ź����ַ���ջ
    mov ah,2
    call charstack;����2�Ź��ܣ��ַ���ʾ
    jmp getstrs
    
    nochar:
    cmp ah,0eh;�˸����ɨ����
    je backspace
    cmp ah,1ch;�س�����ɨ����
    je enter1
    jmp getstrs
    
    backspace:
    mov ah,1
    call charstack;����1�Ź����ַ���ջ
    mov ah,2
    call charstack;����2�Ź����ַ���ʾ
    jmp getstrs
    
    enter1:
    xor al,al
    xor ah,ah
    call charstack;����0�Ź��ܽ�al��0��ջ
    mov ah,2
    call charstack;����2�Ź�����ʾ��0��β���ַ���
    
    pop ax
    ret
    
    
    charstack: jmp short charstart
    
    table dw charpush,charpop,charshow
    top dw 0;ջ��
    
    charstart:
    push bx
    push dx
    push di
    push es
    
    cmp ah,2
    ja sret
    mov bl,ah
    xor bh,bh
    add bx,bx
    jmp word ptr table[bx];����ah���ܺŶ�Ӧ���ӳ���
    
    ;��ջ�ӳ���
    charpush:
    mov bx,top
    mov [bx][si],al;al�д����ջ�ַ�
    inc top
    jmp sret
    
    ;��ջ�ӳ���
    charpop:
    cmp top,0
    je sret
    dec top
    mov bx,top
    mov al,[bx][si];al�д�ų�ջ�ַ�
    jmp sret
    
    ;�ַ���ʾ�ӳ���
    charshow:
    mov bx,0b800h
    mov es,bx
    mov al,160
    xor ah,ah
    mul dh;dh�д����ʾλ���кţ�dl����к�
    mov di,ax;ax�д�ų˷����
    add dl,dl;dl�д����ʾλ�õ���ƫ�Ƶ�ַ
    xor dh,dh
    add di,dx;di�д����ʾλ����ƫ�Ƶ�ַ
    
    xor bx,bx
    
    charshows:
    cmp bx,top
    jne noempty
    mov byte ptr es:[di],' '
    jmp sret
    
    noempty:
    mov al,[bx][si]
    mov es:[di],al
    mov byte ptr es:[di+2],' '
    inc bx
    add di,2
    jmp charshows
    
    sret:
    pop es
    pop di
    pop bx
    pop ax
    ret

CODES ENDS
    END START
