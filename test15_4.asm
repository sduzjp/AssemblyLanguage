;���жϣ���дint9�ж�����
;����Ļ�м�������ʾ'a'��'z'���������˿���
;����ʾ�Ĺ����У�����Esc�������л�������ɫ
;Ҫ��DOSʵģʽ������
DATAS SEGMENT
    dw 0,0;����data�δ��int9�ж����̵�ԭ��ڵ�ַ
DATAS ENDS

STACKS SEGMENT
    db 128 dup (0);����stack�δ�ű�־�Ĵ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,stacks
    mov ss,ax
    mov sp,128
    
    mov ax,datas
    mov ds,ax
    
    xor ax,ax
    mov es,ax
    
    push es:[9*4]
    pop ds:[0];����int9�ж����̵�ԭ���ƫ�Ƶ�ַ
    push es:[9*4+2]
    pop ds:[2];����int9�ж����̵�ԭ��ڶε�ַ
    
    ;������int9�ж����̵��ж�������
    mov word ptr es:[9*4],offset int9
    mov word ptr es:[9*4+2],cs
    
    ;���ַ�������ʾ������
    mov ax,0b800h
    mov es,ax
    mov ah,'a'
    s:
    mov es:[160*12+40*2],ah
    call delay
    inc ah
    cmp ah,'z'
    jna s
    
    ;�ָ�ԭint9�ж����̵���ڵ�ַ����֤֮��ĳ������int9����ȷ��
    
    xor ax,ax
    mov es,ax
    
    push ds:[0]
    pop es:[9*4]
    push ds:[2]
    pop es:[9*4+2]
    
    MOV AH,4CH
    INT 21H
    
    delay:
    push ax
    push dx
    mov dx,000fh
    xor ax,ax
    s1:
    sub ax,1
    sbb dx,0
    cmp ax,0
    jne s1
    cmp dx,0
    jne s1
    
    pop dx
    pop ax
    ret
    
    int9:
    push ax
    push bx
    push es
    
    in al,60h
    
    pushf;��־�Ĵ�����ջ
    ;��intָ�����ģ�⣬����ԭ����int9�ж�����
    pushf
    pop bx
    and bh,11111100b
    push bx
    popf
    call dword ptr ds:[0]
    
    ;�жϼ�������ɨ�����Ƿ�Ϊ1�����Ƿ����Esc
    
    cmp al,1
    jne int9ret
    
    mov ax,0b800h
    mov es,ax
    inc byte ptr es:[160*12+40*2+1]
    
    int9ret:
    pop es
    pop bx
    pop ax
    iret
    
CODES ENDS
    END START
