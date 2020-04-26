;程序可实现输入1位到8位之间任意位16进制数并显示
;程序设计到多个子程序:change,lbyte,dwtoc,divdw,show_str
;change子程序实现输入16进制字符串转换为16进制数
;lbyte子程序实现两个输入字符存到一个字节单元
;dwtoc通过除10取余将16进制数转换为对应10进制数ASCII码值
;divdw实现32位(双字型)除法
;show_str子程序实现显示以0结尾的字符串

;定义一个缓冲区，存放输入的十六进制字符串
data segment
	buf db 100
		db ?
		db 100 dup(0)
	infon db 0dh,0ah,'Please enter hexadecimal digits:$'
data ends

datas segment
	db 128 dup(0)
datas ends

show segment
	db 128 dup(0)
show ends

code segment
	assume cs:code,ds:data
start:
	;用int21h的10号功能调用实现输入一个字符串并存到内存缓冲区data
	mov ax,data
	mov ds,ax
	
	lea dx,infon;在屏幕上显示提示信息
	mov ah,9
	int 21h;将infon开始的字符串输出到屏幕
	
	lea dx,buf;从键盘输入一个十六进制数
	mov ah,10
	int 21h 
	
	lea si,buf+2
	mov cl,[buf+1];注意[buf+1]是一个字节单元
	mov ch,0;cx存放输入的十六进制位数
a:
	push cx;保护cx
	mov al,ds:[si]
	call change;调用change子程序将输入的字符转化为十六进制数字
	mov ds:[si],al;将转换后的数字存回原内存字节单元
	inc si
	pop cx;恢复cx,实现cx自减
loop a
	;实现将十六进制数字存放到show段
	;实现高位数字存放在高地址单元，低位数字存放在低地址单元
	mov bx,show
	mov es,bx
	mov di,0;es:di指向show段
	lea si,buf+1 
	mov al,[buf+1]
	mov ah,0
	add si,ax;ds:si指向缓冲区字符串最后一位存放处
	mov cl,[buf+1];设置传输长度
	mov ch,0
chuanshu:
	mov al,ds:[si]
	mov es:[di],al
	dec si
	inc di
	loop chuanshu 
	
    ;若输入数字位数未满8位，高位空位补0
	mov cx,8
	mov al,[buf+1]
	mov ah,0
	sub cx,ax;未满8位的位数
chuanshu1:
	mov al,0
	mov es:[di],al
	inc di
	loop chuanshu1
	;至此十六进制数字所有位数存放到show段中
	;由于每个位上的数字存放一个字节单元，需把两个合到一起
	
	mov bx,es
	mov ds,bx
	xor si,si
	call lbyte;调用lbyte子程序实现两个数字合到一个字节单元
	mov ax,ds:[0]
	mov dx,ds:[2]
	
	MOV bx,DATAS
    MOV ds,bx
    mov bx,show
    mov es,bx
    mov cx,0ah
    call dwtoc
    ;调用dwtoc子程序将dx，ax中的十六进制数转化为十进制数对应的ASCII码值
    
    mov cl,2
    call show_str;调用show_str子程序显示十进制数
    
	done:mov ax,4c00h
	int 21h
	
	dwtoc:
	push ax
	push bx
	push cx
	push ds
	xor si,si
	xor di,di
	s:
	call divdw;调用divdw子程序将dx，ax十六进制数除10取余
	mov bx,ds:[4];bx记录每一次除10的余数
	add bx,30h;转化为十进制数对应ASCII码值
	mov es:[si],bx
	inc di			;设置di记录数据有多少位
	mov ax,ds:[0]	;注意循环调用calldiw时候必须预先处理好ax，dx，即将上一次取余后的商存好
	mov dx,ds:[2]
	add si,2
	cmp dx,0		;最后结束标志ax，dx中存放数据都为0
	je next;(dx)为0继续判断(ax)是否为0
	jmp far ptr s;(dx)不为0则继续进行除10取余
	next:
	cmp ax,0
	je ok1;(ax)为0则结束，跳出循环
	jmp far ptr s;(ax)不为0则继续进行除10取余
	
	ok1:
	xor si,si;实现将show段的数据逆序放到ds段中
	mov cx,di;di记录的十进制位数存到cx中
	dec di;由于位数最后跳出前多加了1，所以减去1
	add di,di;es:di指向show段最后一个内存字单元
	s1:
	mov ax,es:[di]
	mov ds:[si],ax;ds:si指向datas段
	sub di,2;传输的是一个字单元，循环自减为2
	add si,2
	loop s1
	
	xor ax,ax;在十进制数字符串后存放0
	mov ds:[si],ax
	
	pop ds
	pop cx
	pop bx
	pop ax
	ret
	
    divdw:
    push ds
    push dx
    push cx
    push ax
    
    mov ax,dx	;先求高16位除以除数的结果，ax存放商，dx存放余数
    xor dx,dx
    div cx
    push dx
    			;将余数保存下来
    mov dx,ax
    xor ax,ax
    mov ds:[0],ax
    mov ds:[2],dx;将高16位的除法结果保存在高地址字单元中
    
    pop dx		;弹出高16位除法结果的余数
    pop ax		;将被除数的低16位取出来
    push ax		;恢复栈顶，维持push和pop平衡
    div cx		;此时dx存放高16位除法的余数，ax存放被除数低16位
    			;最后结果ax存放商，dx存放余数
    			
    mov ds:[0],ax;将低16位的除法结果商放在低地址字单元
    mov ds:[4],dx;最后的余数放在ds:[4]字单元中
    ;最后结果的低16位在ds:[0],高16位在ds:[2],余数在ds:[4]
    pop ax
    pop cx
    pop dx
    pop ds
    ret
    ;显示一个十进制数字以0结尾的字符串
    show_str:
   	push es
   	push cx
   	push ax
   	push si
   	push ds
   	push bx
   	
   	mov bx,0b800h
   	mov es,bx;指向显示缓冲区中间
   	mov si,160*12+40*2
   	mov dl,cl
   	xor di,di
   	
   	s0:mov al,ds:[di]		;注意是对字节单元进行存储
   	mov es:[si],al
   	mov es:[si+1],dl
   	add si,2
   	add di,2					
   	;实际上十进制每位上的数小于10
   	;所以在内存单元存放时只放在子单元的低地址字节单元
   	;因此di递增2，而不是递增1
   	cmp al,0;判断是否为0(即字符串是否结束)
	jna done
   	jmp short s0
   	
   	pop bx
   	pop ds
   	pop si
   	pop ax
   	pop cx
   	pop es
   	ret
   	;将输入的十六进制字符转换为对应的十六进制数
   	change:
	push bx
	push es
	
	cmp al,'0'
	jb ok
	cmp al,'9';判断是否为数字字符'0'到'9'
	jna next1
	cmp al,'A'
	jb ok
	cmp al,'F';判断是否为大写字母字符'A'到'F'
	jna next2
	cmp al,'a'
	jb ok
	cmp al,'f';判断是否为小写字母字符'a'到'f'
	jna next3
	jmp short ok
	
	next1:
	sub al,30h;若为数字字符则减去30H
	jmp short ok
	next2:
	sub al,37h;若为大写字母字符则减去37H
	jmp short ok
	next3:
	sub al,57h;若为小写字母字符则减去57H
	jmp short ok
	ok:nop
	pop es
	pop bx
	ret
	
	lbyte:
	xor di,di
	mov cx,4;循环四次
	s4:
	push cx;保护cx
	mov al,ds:[si]
	mov bl,ds:[si+1]
	mov cl,4
	shl bl,cl;取得一个字节单元高位十六进制数
	add bl,al;加上一个字节单元低位十六进制数，从而合并两个一位十六进制数
	mov ds:[di],bl;将合并后的十六进数存到show段
	inc di;合并后的十六进制数占一个字节，di自增1
	add si,2;si自增2
	pop cx;恢复cx
	loop s4
	ret
code ends
	end start

