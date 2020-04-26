;利用中断调用，在屏幕上显示1-9之间的随机数。中断号为86H。
;需要写好中断子程序，安装好中断子程序(安装在内存0000:0200中，因为随时可能会发生中断)
;设置中断向量表
;写中断子程序，产生一个1-9的随机数

CODES SEGMENT
    ASSUME CS:CODES
START:
	;mov ax,cs
	;mov ds,ax
	;mov si,offset suijishu;ds:si指向源地址
	;
	;xor ax,ax
	;mov es,ax
	;mov di,200h;es:di指向安装的目的地址
	;mov cx,offset suijishuend-offset suijishu;设置传输长度
	;cld;设置df=0,si,di递增
	;rep movsb
	;
	;设置中断向量表，中断号为86H
	xor ax,ax
	mov es,ax
	mov ax,offset suijishu
	mov word ptr es:[86h*4],ax;中断程序偏移地址
	mov ax,seg suijishu 
	mov word ptr es:[86h*4+2],ax;中断程序段地址
	
	;调用86H中断子程序
	int 86h
	
	mov ax,4c00h
	int 21h;程序返回
	
suijishu:
	push ax
	push dx
	sti;sti指令将IF=1,响应int 1ah中断
    MOV ah,0
    int 1ah;调用第1ah的0子程序，读取始终滴答计数
    
    mov ax,dx;将产生的随机数存入ax
    and ax,15;进行与运算得到低4位,(ah)=0
    mov dl,10
    div dl;除10后,ah中存放余数,al中存放商.余数就是随机十进制数
    mov dl,2;设置字符颜色
    cmp ah,0;判断随机数是否为0
    jz next;若为0则增1改为显示随机数1
    jmp short next1
next:
	add ah,1
next1:
    add ah,30h;将十进制随机数转换为对应ASCII码值
    mov bx,0b800h
    mov es,bx
    mov es:[160*12+40*2],ah
    mov es:[160*12+40*2+1],dl;在屏幕中间显示随机数
    
    pop dx
    pop ax
	iret

CODES ENDS
    END START

