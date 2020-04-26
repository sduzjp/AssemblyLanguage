;判断是否为闰年
DATAS SEGMENT
    infon db 0dh,0ah,'Please input a year:$';声明空间存储输入提示信息，其中0d回车，0a换行
    Y db 0dh,0ah,'This is a leap year!$';声明空间存储是闰年提示信息，另一一行输出
    N db 0dh,0ah,'This is not a leap year!$';声明空间存储不是闰年信息，另一一行输出
    W dw 0;声明空间存储年份字符串对应的年份数字
    buf db 8
    	db ?
    	db 8 dup(0)
   ;声明空间为缓冲区，共10个字节
DATAS ENDS

STACKS SEGMENT
    db 200 dup(0)
STACKS ENDS;定义一个字节为200的栈段

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX;指向数据段
    
    lea dx,infon
    mov ah,9
    int 21h;在屏幕上显示提示输入信息
    
    lea dx,buf
    mov ah,10
    int 21h;从键盘输入年份字符串
    
    mov cl,[buf+1]
	mov ch,0;cx中存放实际输入字符串的位数
	lea di,buf+2;获取字符串首地址
	call datacate;调用子程序将年份字符串转换为年份数字
	call ifyears;调用子程序判断是否为闰年
	jc a1;判断cf标志寄存器是否为1，如是则跳转到a1
	
	lea dx,n
	mov ah,9
	int 21h;如果不是则显示不是闰年提示信息
	jmp exit
	
a1: lea dx,y
	mov ah,9
	int 21h;如果是则显示是闰年提示信息
	
exit:mov ah,4ch
	int 21h;程序返回
	
;将年份字符串转换为年份数字
datacate proc near;指明该字符串在主程序段内
	push cx;保存cx
	dec cx;cx自减1，使得下面循环si指向最后一个字符(buf中回车符前一个)
	lea si,buf+2
tt1:
	inc si
	loop tt1
	pop cx;将si指向最后一个字符
	
	mov dh,30h;辅助数据，用来将数字字符对应的ASCII码转换为代表的数字本身
	mov bl,10;辅助数据，用来每进一位时使ax乘10
	mov ax,1;ax用来装对应位的权值
I1: push ax
	push bx
	push dx;保护寄存器值
	
	sub byte ptr [si],dh;将单个字符转换为数字本身
	mov bl,byte ptr [si];获取该位数字
	mov bh,0
	mul bx;该位数字乘以对应权值,实际上数字不会超过一个字节
	add [W],ax;将数字加到结果中，所有加完后即为对应年份数字
	
	pop dx
	pop bx
	pop ax;恢复寄存器值
	mul bl;权值乘以10
	dec si;si自减1，指向更高一位
	loop I1
	ret;子程序返回
datacate endp
;判断是否为闰年子程序
ifyears proc near;指明子程序在主程序内
	push bx
	push cx
	push dx;保护寄存器值
	
	mov ax,[W];获取年份数字
	mov cx,ax;将年份数字备份到cx中
	mov dx,0
	mov bx,100
	div bx;判断年份是否能被100整除
	cmp dx,0
	jnz lab1;若不能则跳转到lab1继续判断能否被4整除
	mov ax,cx
	mov bx,400
	div bx;若能则继续判读能否被400整除
	cmp dx,0
	jz lab2;若能则跳转到lab2
	clc;若不能将cf置0，不是闰年
	jmp short lab3;跳转到lab3
lab1:
	mov ax,cx
	mov dx,0
	mov bx,4
	div bx;判断能否被4整除
	cmp dx,0
	jz lab2;若能则跳转到lab2
	clc;若不能则cf置0，不是闰年
	jmp lab3;跳转到lab3
lab2:stc;cf置1，是闰年
lab3:
	pop dx
	pop cx
	pop bx
	ret;子程序返回
ifyears endp

CODES ENDS
    END START



