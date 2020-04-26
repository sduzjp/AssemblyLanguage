;端口的访问
;CMOS RAM中存储的时间信息
;编程，在屏幕中间显示以“年/月/日 时：分：秒”的格式显示当前日期、时间
;年、月、日、时、分、秒的数据都是一个字节
;程序存在改进地方：
;(1)年月日和时分秒存放到data段的循环问题
;(2)最后送入显示缓冲区时数据以及'/',':'字符循环问题
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
	push cx
    mov al,dl
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
    dec dl
    pop cx
    loop s
    
    mov si,6
    mov dl,4
    mov cx,3
    s0:
    push cx
    mov al,dl
    out 70h,al;向70h端口写入al
    in al,71h;从71h端口读入(al)号单元的字节型数据
    
    mov ah,al;将该字节型数据分别两个BCD码
    mov cl,4;注意当移动位数大于1时，将移动位数存放在cl中
    shr ah,cl;字节的高四位BCD码
    and al,00001111b;字节的低四位BCD码
    
    add ah,30h;分别将两BCD码代表的十进制数转换成对应的ASCII码值
    add al,30h

    mov ds:[si],ah
    mov ds:[si+1],al
    add si,2
    sub dl,2
    pop cx
    loop s0
    
    ;送入显示缓冲区
    mov bx,0b800h
    mov es,bx
    xor si,si
    xor di,di
    mov bx,160*12+30*2
    mov dl,2
    mov cx,2
    s1:
    mov al,ds:[si]
    mov es:[bx+di],al
    mov es:[bx+di+1],dl
    inc si
    add di,2
    loop s1
    mov al,47
    mov es:[bx+4],al
    mov es:[bx+5],dl
    
    mov di,6
    mov cx,2
    s2:
    mov al,ds:[si]
    mov es:[bx+di],al
    mov es:[bx+di+1],dl
    inc si
    add di,2
    loop s2
    mov al,47
    mov es:[bx+10],al
    mov es:[bx+11],dl
    
    mov di,12
    mov cx,2
    s3:
    mov al,ds:[si]
    mov es:[bx+di],al
    mov es:[bx+di+1],dl
    inc si
    add di,2
    loop s3
    mov al,32
    mov es:[bx+16],al
    mov es:[bx+17],dl
    
    mov di,18
    mov cx,2
    s4:
    mov al,ds:[si]
    mov es:[bx+di],al
    mov es:[bx+di+1],dl
    inc si
    add di,2
    loop s4
    mov al,58
    mov es:[bx+22],al
    mov es:[bx+23],dl
    
    mov di,24
    mov cx,2
    s5:
    mov al,ds:[si]
    mov es:[bx+di],al
    mov es:[bx+di+1],dl
    inc si
    add di,2
    loop s5
    mov al,58
    mov es:[bx+28],al
    mov es:[bx+29],dl
    
    mov di,30
    mov cx,2
    s6:
    mov al,ds:[si]
    mov es:[bx+di],al
    mov es:[bx+di+1],dl
    inc si
    add di,2
    loop s6

    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
