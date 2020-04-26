;实现输入两个任意位数(最高15位)十进制数
;若15位大数相加有进位也可正常显示，但16位大数相加进位的话则需改动显示位数
;其余少于16位的任意位数相加均可正常显示十进制数相加结果
;定义一个缓冲区存放键盘输入
data segment
	buf db 100
		db ?
		db 100 dup(0)
	buf1 db 100
		 db ?
		 db 100 dup(0)
	infon1 db 0dh,0ah,'Please input the first number:$'
	infon2 db 0dh,0ah,'Please input the second number:$'
data ends

datas segment
	db 128 dup(0)
datas ends;定义一个datas数据段，128个字节

show segment
	db 128 dup(0)
show ends;定义一个show数据段，128个字节

show1 segment
	db 128 dup(0)
show1 ends;定义一个show1数据段，128个字节

stack segment
	dw 4 dup(0)
stack ends;定义一个栈段用来保存数字的4个16位

code segment
	assume cs:code,ds:data,ss:stack
start:
	;用int21h的10号功能调用实现输入一个字符串并存到内存缓冲区data
	mov ax,data
	mov ds,ax
	
	lea dx,infon1
	mov ah,9
	int 21h;屏幕显示提示输入信息
	
	lea dx,buf
	mov ah,10
	int 21h ;输入第一个十进制数字符串
	
	mov bx,show
	mov es,bx
	xor di,di;es:di指向show段，依次存放输入十进制的低位到高位
	lea si,buf+1
	mov cl,[buf+1]
	mov ch,0;实际输入十进制数位数
	add si,cx;ds:si指向第一个十进制数最后一位
	a:
	mov al,ds:[si]
	sub al,30h;将十进制字符串字符转换为十进制
	mov es:[di],al;十进制数从低位开始存到show段
	dec si
	inc di
	loop a
	;未满16位的高位位数补0
	mov cl,[buf+1]
	mov ch,0
	mov si,16
	sub si,cx
	cmp si,0
	jz tiaoguo;若满16位，则跳过补0
	mov cx,si
bu0:
	mov al,0
	mov es:[di],al
	inc di
loop bu0
tiaoguo:
	lea dx,infon2
	mov ah,9
	int 21h;屏幕显示提示输入信息
	
	lea dx,buf1
	mov ah,10
	int 21h ;输入第二个十进制数字符串
	
	mov bx,show1
	mov es,bx
	xor di,di;es:di指向show1段
	lea si,buf1+1
	mov cl,[buf1+1]
	mov ch,0;cx存放实际输入的十进制数的位数
	add si,cx;ds:si指向第二个十进制数字符串最后一位
	b:
	mov al,ds:[si]
	sub al,30h;将十进制字符串字符转换为十进制数
	mov es:[di],al;将十进制数从低位开始存放到show1段
	dec si
	inc di
	loop b
	;未满16位的高位位数补0
	mov cl,[buf1+1]
	mov ch,0
	mov si,16
	sub si,cx
	cmp si,0
	jz tiaoguo1;若满16位，则跳过补0
	mov cx,si
bu1:
	mov al,0
	mov es:[di],al
	inc di
loop bu1
    ;至此完成了两个十进制数从低位到高位分别存放在show和show1段

tiaoguo1:   
    mov bx,show
    mov ds,bx
    xor si,si;ds:si指向show段，第一个十进制数
    xor di,di;es:di指向show1段，第二个十进制数
    xor al,al;将(al)置0
	mov cx,16
lp:push cx
 	mov cl,0ah
 	add al,ds:[si]
 	add al,es:[di]
 	mov ah,0;进行的十六进制加法结果转十进制
 	div cl;ah存放余数代表十进制本位数，al存商代表十进制进位数
 	mov ds:[si],ah;将最后十进制加法结果从低位到高位存放到show段
 	inc si
 	inc di
 	pop cx
loop lp
 	
 	;比较两个实际输入的十进制数位数
 	mov bx,data
 	mov ds,bx;使ds指向data缓冲段
 	mov al,[buf+1]
 	mov bl,[buf1+1];分别取得两个输入十进制字符串的位数
 	mov cx,show
	mov ds,cx;恢复ds重新指向show段
 	cmp al,bl
 	jnb next1;若(al)>=(bl),则第一个十进制数位数多
 	jmp short next2;若(al)<(bl),则第二个十进制数位数多
next1:
	mov ah,0
	mov bx,ax
	mov si,ds:[bx];判断最后的一个字符是否为0，即判断是否存在进位
	cmp si,0
	jz overnext1;若为0，即不存在进位，则显示位数就是两个位数中的大者
	add ax,1;若为0，即存在进位，则显示位数要在输入两个十进制位数的最大位数上增1
	mov si,ax
	jmp short zhuanhuan
next2:
	mov bh,0
	mov si,ds:[bx];同理判断最后的字符是否为0从而确定显示位数
	cmp si,0
	jz overnext2
	add bx,1
	mov si,bx
	jmp short zhuanhuan
overnext1:
 	mov si,ax
 	jmp short zhuanhuan
overnext2:
	mov si,bx
	;将最后的十进制结果存入显示缓冲区并转换为ASCII码值
zhuanhuan:
    mov cx,si;cx记录需要显示的位数
	mov bx,0b800h
	mov es,bx
	mov di,160*10+20*2;es:di指向显示缓冲区中间
    mov dl,2
 lp1:
 ;由于show段低地址存放低字节单元，因此显示的时候要逆序存到显示缓冲
	mov al,ds:[si-1]
	add al,30h
    mov es:[di],al
    mov es:[di+1],dl
	dec si
	add di,2
 loop lp1
	
	mov ax,4c00h
	int 21h;程序返回
	
code ends
	end start

