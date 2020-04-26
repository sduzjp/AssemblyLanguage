;实现字符串的复制功能，正序和倒序依次显示字符串
;datas段正序存放需要复制和显示的字符串

DATAS SEGMENT
    string db 'The school of Information Science and Engineering Shandong University','$'  
DATAS ENDS

;定义一个EXT段存放复制的字符串
EXT segment
	string_b db 100 dup(?)
EXT ends
;定义一个ext1段存放倒序复制的字符串
ext1 segment
	string_c db 100 dup(?)
ext1 ends
CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
 	mov ax,datas
 	mov ds,ax
 	xor si,si;ds:si指向datas段
 	;获取字符串长度
 	xor cx,cx;cx置零后用来记录字符串长度
 lp:mov al,ds:[si]
 	cmp al,'$';判断是否达到字符串结尾位
 	jz outlp;若到达则跳出循环;跳出时cx记录了字符串长度
 	inc si
 	inc cx
 jmp short lp
 outlp:
 	add cx,1;加上'$'这一位数，得到以'$'结尾的字符串长度
 	push cx;保存cx
 	xor si,si;ds:si指向datas段
 	mov bx,ext
 	mov es,bx
 	xor di,di;es:di指向ext段
 	
    cld;设置df=0，si,di递增
    rep movsb;利用串传送指令复制字符串
    
    pop cx;恢复cx
    mov si,cx
    sub si,2;ds:si指向datas段字符串最后一位(即'$'前一位)
    mov bx,ext1
    mov es,bx
    xor di,di;es:di指向ext1段
    sub cx,1;cx存放字符串长度(不包括'$'这一位)
lp1:mov al,ds:[si]
	mov es:[di],al
	dec si
	inc di
loop lp1;实现将字符串逆序存放到ext1段
	mov al,'$'
	mov es:[di],al;实现字符串逆序存放在ext1段，并以'$'结尾
	
	;正序显示复制的字符串
    ;调用第10h的2号子程序设置光标位置
    mov ah,2;置光标
    mov bh,0;第0页
    mov dh,5;第5行
    mov dl,12;第12列
    int 10h
    ;调用第21h的9号子程序在光标位置显示字符串
    mov ax,ext
    mov ds,ax
    xor dx,dx;ds:dx指向正序复制的字符串首地址ext:0
    mov ah,9
    int 21h
    
    ;倒序显示复制的字符串
    ;同理调用中断10h的2号子程序和21h的9号子程序
    mov ah,2
    mov bh,0
    mov dh,8;第8行
    mov dl,12;第12列
    int 10h
    
    mov ax,ext1
    mov ds,ax
    xor dx,dx;ds:dx指向倒序复制字符串首地址ext1:0
    mov ah,9
    int 21h
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START


