;端口的访问
;CMOS RAM中存储的时间信息
;编程，在屏幕中间显示当前的月份

CODES SEGMENT
    ASSUME CS:CODES
START:
    mov al,8
    out 70h,al;向70h端口写入al
    in al,71h;从71h端口读入8号单元的字节型数据
    
    mov ah,al;将该字节型数据分别两个BCD码
    mov cl,4;注意当移动位数大于1时，将移动位数存放在cl中
    shr ah,cl;字节的高四位BCD码
    and al,00001111b;字节的低四位BCD码
    
    add ah,30h;分别将两BCD码代表的十进制数转换成对应的ASCII码值
    add al,30h
    
    ;送入显示缓冲区
    mov bx,0b800h
    mov es,bx
    mov cl,2
    mov byte ptr es:[160*12+40*2],ah
    mov byte ptr es:[160*12+40*2+1],cl
    mov byte ptr es:[160*12+40*2+2],al
    mov byte ptr es:[160*12+40*2+3],cl
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
