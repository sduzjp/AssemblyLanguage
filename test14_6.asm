;端口的访问
;CMOS RAM中存储的时间信息
;编程，在屏幕中间显示以“年/月/日 时：分：秒”的格式显示当前日期、时间
;年、月、日、时、分、秒的数据都是一个字节
;改进程序
data segment
	db 16 dup (0)
data ends

CODES SEGMENT
    ASSUME CS:CODES
START:
	mov bx,data
    mov ds,bx
    xor si,si
    ;实现年、月、日存放到data段
    mov dl,9
    mov cx,3
    s:
    mov al,dl
    call read
    dec dl
	loop s
	
	;实现时分秒存放到data段
	mov dl,4
	mov cx,3
	s0:
	mov al,dl
	call read
	sub dl,2
	loop s0

    ;送入显示缓冲区
    mov bx,0b800h
    mov es,bx
    xor si,si
    xor di,di
    mov bx,160*12+30*2
    ;实现将日期、事件的数字送入显示缓冲区
    mov dl,2
    mov cx,6
    s3:
    call show_number
    add di,2;注意这里只需要将di递增2，因为调用子程序时循环结束后es:di已经指向下一个显示字节单元
    loop s3
    
    ;实现将两个'/'送个年月日三个数据中间分隔
    mov cx,2
    mov si,4
    mov al,47
    s4:
    mov es:[bx+si],al
    mov es:[bx+si+1],dl
    add si,6
    loop s4
    
    ;实现将空格送入日期和时间中间分隔
    mov al,32
    mov es:[bx+16],al
    mov es:[bx+17],dl
    
    ;实现将两个':'送入时分秒的中间分隔
    mov cx,2
    mov si,22
    mov al,58
    s5: 
    mov es:[bx+si],al
    mov es:[bx+si+1],dl
    add si,6
    loop s5
    
    MOV AH,4CH
    INT 21H
    
    ;从端口读入子程序
    read:
	push ds
	push cx
	
    out 70h,al;向70h端口写入al
    in al,71h;从71h端口读入(al)号单元的字节型数据
    
    mov ah,al;将该字节型数据分别两个BCD码
    mov cl,4;注意当移动位数大于1时，将移动位数存放在cl中
    shr ah,cl;字节的高四位BCD码
    and al,00001111b;字节的低四位BCD码
    
    add ah,30h;分别将两BCD码代表的十进制数转换成对应的ASCII码值
    add al,30h

    mov byte ptr ds:[si],ah
    mov byte ptr ds:[si+1],al
    add si,2
  	
  	pop cx
  	pop ds
    ret
    
    ;显示数字子程序
    show_number:
    push cx
    push bx
    push ds
    push es
    
    mov cx,2
    s2:
    mov al,ds:[si]
    mov es:[bx+di],al
    mov es:[bx+di+1],dl
    inc si
    add di,2
    loop s2
    
    pop es
    pop ds
    pop bx
    pop cx
    ret
    
CODES ENDS
    END START
