;ʵ���ַ����ĸ��ƹ��ܣ�����͵���������ʾ�ַ���
;datas����������Ҫ���ƺ���ʾ���ַ���

DATAS SEGMENT
    string db 'The school of Information Science and Engineering Shandong University','$'  
DATAS ENDS

;����һ��EXT�δ�Ÿ��Ƶ��ַ���
EXT segment
	string_b db 100 dup(?)
EXT ends
;����һ��ext1�δ�ŵ����Ƶ��ַ���
ext1 segment
	string_c db 100 dup(?)
ext1 ends
CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
 	mov ax,datas
 	mov ds,ax
 	xor si,si;ds:siָ��datas��
 	;��ȡ�ַ�������
 	xor cx,cx;cx�����������¼�ַ�������
 lp:mov al,ds:[si]
 	cmp al,'$';�ж��Ƿ�ﵽ�ַ�����βλ
 	jz outlp;������������ѭ��;����ʱcx��¼���ַ�������
 	inc si
 	inc cx
 jmp short lp
 outlp:
 	add cx,1;����'$'��һλ�����õ���'$'��β���ַ�������
 	push cx;����cx
 	xor si,si;ds:siָ��datas��
 	mov bx,ext
 	mov es,bx
 	xor di,di;es:diָ��ext��
 	
    cld;����df=0��si,di����
    rep movsb;���ô�����ָ����ַ���
    
    pop cx;�ָ�cx
    mov si,cx
    sub si,2;ds:siָ��datas���ַ������һλ(��'$'ǰһλ)
    mov bx,ext1
    mov es,bx
    xor di,di;es:diָ��ext1��
    sub cx,1;cx����ַ�������(������'$'��һλ)
lp1:mov al,ds:[si]
	mov es:[di],al
	dec si
	inc di
loop lp1;ʵ�ֽ��ַ��������ŵ�ext1��
	mov al,'$'
	mov es:[di],al;ʵ���ַ�����������ext1�Σ�����'$'��β
	
	;������ʾ���Ƶ��ַ���
    ;���õ�10h��2���ӳ������ù��λ��
    mov ah,2;�ù��
    mov bh,0;��0ҳ
    mov dh,5;��5��
    mov dl,12;��12��
    int 10h
    ;���õ�21h��9���ӳ����ڹ��λ����ʾ�ַ���
    mov ax,ext
    mov ds,ax
    xor dx,dx;ds:dxָ�������Ƶ��ַ����׵�ַext:0
    mov ah,9
    int 21h
    
    ;������ʾ���Ƶ��ַ���
    ;ͬ������ж�10h��2���ӳ����21h��9���ӳ���
    mov ah,2
    mov bh,0
    mov dh,8;��8��
    mov dl,12;��12��
    int 10h
    
    mov ax,ext1
    mov ds,ax
    xor dx,dx;ds:dxָ�������ַ����׵�ַext1:0
    mov ah,9
    int 21h
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START


