DATAS SEGMENT
    db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
    db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
    db '1993','1994','1995'
    ;21���ַ�����ÿ���ַ�ռһ���ڴ浥Ԫ���ֽڵ�Ԫ��
    ;��ʼ�ε�ַ��datas
    
    dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
    dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5973000
    ;21��˫�������ݣ�ÿ��˫��������ռ2���ֵ�Ԫ=4���ֽڵ�Ԫ
    ;��ʼ�ε�ַ��datas+84
    
    dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
    dw 11542,14430,15257,17800
    ;21���������ݣ�ÿ����������ռ1���ֵ�Ԫ=2���ֽڵ�Ԫ
	;��ʼ�ε�ַ��datas+84+84
DATAS ENDS

table segment
	db 21 dup ('year summ ne ?? ')
table ends

CODES SEGMENT
    ASSUME CS:CODES
START:
	mov ax,table
	mov es,ax   ;esָ��table��
    MOV AX,datas
    MOV ds,ax	;dsָ��datas��
    mov bx,0    ;bx��datas�εĹ�Ա������ƫ�Ƶ�ַ����
    mov si,0	;si��datas����ƫ�Ƶ�ַ����
    mov di,0	;di��table����ƫ�Ƶ�ַ����
    
    mov cx,21
    s:mov ax,ds:[si+0]
    mov es:[di],ax
    mov ax,ds:[si+2]
    mov es:[di+2],ax	;��datas�ε���ݣ������ֵ�Ԫ��
    					;�����δ��͵�table��
    
    mov ax,ds:[si+84+0]
    mov es:[di+5],ax
    mov dx,ds:[si+84+2]
    mov es:[di+7],dx	;��datas�ε������루�����ֵ�Ԫ��
    					;�����δ��͵�table��
    					;ax�ŵ�16λ��dx�Ÿ�16λ
    
    push cx				;��cx����ջ�б���
    mov cx,ds:[bx+84+84]
    mov es:[di+0ah],cx	;����Ա�����͵�table��
	div cx				;���ڱ�����Ϊ32λ����dx��ax�У�
    ;����Ϊ16λ����cx�У�������̷���ax�У���������dx��
    
    pop cx				;��cx��ջ��ȡ���ָ�
    					
    mov es:[di+0dh],ax	;�����ȡ����Ҳ�������͵�table��
    add si,4
    add bx,2
    add di,16			;����ѭ����������
    loop s 
    MOV Ax,4c00h
    INT 21H
CODES ENDS
    END START

