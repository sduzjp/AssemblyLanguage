;字符串的输入


CODES SEGMENT
    ASSUME CS:CODES
START:

	call getstr
	
    MOV AH,4CH
    INT 21H
    
    getstr:
    push ax
    
    getstrs:
    xor ah,ah
    int 16h
    cmp al,20h
    jb nochar;判断输入字符ASCII码，若小于20h，则代表的不是字符
    xor ah,ah
    call charstack;调用0号功能字符入栈
    mov ah,2
    call charstack;调用2号功能，字符显示
    jmp getstrs
    
    nochar:
    cmp ah,0eh;退格键的扫描码
    je backspace
    cmp ah,1ch;回车键的扫描码
    je enter1
    jmp getstrs
    
    backspace:
    mov ah,1
    call charstack;调用1号功能字符出栈
    mov ah,2
    call charstack;调用2号功能字符显示
    jmp getstrs
    
    enter1:
    xor al,al
    xor ah,ah
    call charstack;调用0号功能将al中0入栈
    mov ah,2
    call charstack;调用2号功能显示以0结尾的字符串
    
    pop ax
    ret
    
    
    charstack: jmp short charstart
    
    table dw charpush,charpop,charshow
    top dw 0;栈顶
    
    charstart:
    push bx
    push dx
    push di
    push es
    
    cmp ah,2
    ja sret
    mov bl,ah
    xor bh,bh
    add bx,bx
    jmp word ptr table[bx];调用ah功能号对应的子程序
    
    ;入栈子程序
    charpush:
    mov bx,top
    mov [bx][si],al;al中存放入栈字符
    inc top
    jmp sret
    
    ;出栈子程序
    charpop:
    cmp top,0
    je sret
    dec top
    mov bx,top
    mov al,[bx][si];al中存放出栈字符
    jmp sret
    
    ;字符显示子程序
    charshow:
    mov bx,0b800h
    mov es,bx
    mov al,160
    xor ah,ah
    mul dh;dh中存放显示位置行号，dl存放列号
    mov di,ax;ax中存放乘法结果
    add dl,dl;dl中存放显示位置的列偏移地址
    xor dh,dh
    add di,dx;di中存放显示位置总偏移地址
    
    xor bx,bx
    
    charshows:
    cmp bx,top
    jne noempty
    mov byte ptr es:[di],' '
    jmp sret
    
    noempty:
    mov al,[bx][si]
    mov es:[di],al
    mov byte ptr es:[di+2],' '
    inc bx
    add di,2
    jmp charshows
    
    sret:
    pop es
    pop di
    pop bx
    pop ax
    ret

CODES ENDS
    END START
