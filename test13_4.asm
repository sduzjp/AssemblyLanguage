;��int��iret��ջ���������
;��7ch�ж��������loopָ��Ĺ���
;�ж��������cx�ݼ���ת��ָ�����

CODES SEGMENT
    ASSUME CS:CODES
START:
	;��װ�ж�����
	mov ax,cs
	mov ds,ax
	mov si,offset lp;����ds:siָ���ж������׵�ַ
	xor ax,ax
	mov es,ax
	mov di,200h;����es:diָ��װĿ�ĵ�ַ0000:0200
	mov cx,offset lpend-offset lp;���ô��䳤��
	cld;����df=0��si,di����
	rep movsb
	
	;�����ж�������
	xor ax,ax
	mov es,ax
	mov word ptr es:[7ch*4],200h
	mov word ptr es:[7ch*4+2],0
	
	;����Ļ�м���ʾ40��'!'
	
    MOV AX,0b800h
    mov es,ax
    mov di,160*12+30;����ds:diָ����ʾ���������м䲿��
    
    ;cx��¼ѭ��������bx��¼loopָ����Ҫ��ת�ĵ�ַת�Ƴ���
    ;�״�㣺���ε�ַ����es��ʱ�����öμĴ���:[ƫ�Ƶ�ַ]��֪��ʽʱ������ע��es
    ;�״�㣺���ַ�'!'������ʾ������ʱ����ע��byte ptr
    mov es:[di+1],al
    mov bx,offset s-offset se
    mov al,2
    mov cx,40
    s:
    mov byte ptr es:[di],'!'
    mov es:[di+1],al
    add di,2
    int 7ch
    
    se:nop
    
    MOV AH,4CH
    INT 21H
    
    ;�ж�����
    ;���ڵ����ж����̻��Ƚ�int7ch��һ��ָ���cs��ipѹջ
    ;�����Ҫ����ջ����һ��ָ���IP�Լ�ת�Ƶĵ�ַ����������ѭ���׵�ַ��
    
    lp:
    push bp;��bp��ջ����
    mov bp,sp;����ss:bpָ��ջ��
    dec cx;���loopָ���cx�ݼ�����
    jcxz lpret;���cx=0ֱ�ӽ���ѭ����ִ��ѭ������һ��ָ��
    add [bp+2],bx;���cx��=0����ѹ��ջ�ڵ�int 7ch����һ��ָ���IP�޸�Ϊѭ���׵�ַ��IP
    lpret:
    pop bp;��bp��ջ�ָ�
    iret;����ѹ��ջ��CS,IPֵ�Լ���־�Ĵ���ֵ
	
	lpend:nop
	
	
CODES ENDS
    END START

