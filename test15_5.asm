;��װ�µ�int9�ж����̣�ʹԭ��int9�ж����̵ĵ���չ
;���ܣ���DOS�£�����A���ı䵱ǰ��Ļ����ʾ��ɫ���������ճ�����

STACKS SEGMENT
    db 128 dup (0);��ű�־�Ĵ�����ֵ
    
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,SS:STACKS
START:
    MOV AX,stacks
    mov ss,ax
    mov sp,128
    
    push cs
    pop ds
    mov si,offset int9;����ds:siָ��װ�жϳ����׵�ַ
    
    
    xor ax,ax
    mov es,ax
    mov di,204h;����es:diָ��װ��Ŀ�ĵ�ַ0000:0204
    mov cx,offset int9end-offset int9;���ô��䳤��
    cld;����df=0��si,di����
    rep movsb
    
    ;���ԭint9�ж�������
    push es:[9*4]
    pop es:[200h];���ԭ�ж��������ƫ�Ƶ�ַ
    push es:[9*4+2]
    pop es:[202h];���ԭ�ж�������ڶε�ַ
    
    ;������int9�ж�������
    cli;����IF=0���ڴ���int9�жϳ����ʱ���ֹ�����Ŀ������ж�
    mov word ptr es:[9*4],204h
    mov word ptr es:[9*4+2],0
    sti;����IF=1����������int9�жϳ����ɽ��������Ŀ������ж�
    
    ;�����ӳٳ�����֤�°�װ���ж��ӳ���
    call delay
    
    MOV AH,4CH
    INT 21H
    
    ;�ӳ��ӳ���
    delay:
    push ax
    push dx
    mov dx,0100h
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
    push cx
    push es
    
    in al,60h
    pushf
    call dword ptr cs:[200h];�����ж�����ִ��ʱ,(cs)=0
    
    cmp al,1eh;�жϰ��µļ��Ƿ�ΪA��
    jne int9ret
    
    ;�ı���ʾ��Ļ��������ɫ
    mov ax,0b800h
    mov es,ax
    mov bx,1
    mov cx,2000
    s:
    inc byte ptr es:[bx]
    add bx,2
    loop s
    
    int9ret:
    pop es
    pop cx
    pop bx
    pop ax
    iret
    
    int9end:
    nop
    
CODES ENDS
    END START

