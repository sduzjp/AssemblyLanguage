;编写0号中断程序，使得除法溢出时
;屏幕中间显示"divide overflow!"
;然后返回dos
CODES SEGMENT
    ASSUME CS:CODES
START:
	;安装do0中断程序
    MOV AX,cs
    MOV DS,AX
    mov si,offset do0;设置ds:si指向do0，即要安装的程序首地址
    
    xor ax,ax
    mov es,ax
    mov di,200h;设置es:si指向安装的目的地址0000:0200
    
    ;mov cx,offset do0
    ;sub cx,offset next注意不能这样直接减
    ;mov ax,offset do0
    ;mov cx,offset next
    ;sub cx,ax;应该这样减
    mov cx,offset next-offset do0;设置cx为传输长度
    cld
    rep movsb
    
    ;设置0号中断向量表
    xor ax,ax
    mov es,ax
    mov word ptr es:[0],200h
    mov word ptr es:[2],0
    
    ;测试除法溢出显示divide overflow！
    mov ax,4240h
    mov dx,000fh
    mov cx,10
    div cx
    ;int 0
    MOV AH,4CH
    INT 21H
    
    ;do0中断子程序
    do0:
    jmp short do0start
    db "divide overflow!"
    ;将显示的字符串送入显示缓冲区
    do0start:
    push ax
    push bx
    push cx
    push di
    push si
    push ds
  
    mov ax,cs
    mov ds,ax
    mov si,202h;设置ds:si指向字符串首地址
    mov ax,0b800h
    mov es,ax
    xor di,di
    mov dl,2
    mov bx,500h
    mov cx,16
    s:
    mov al,ds:[si]
    mov es:[bx+di],al
    mov es:[bx+di+1],dl
    inc si
    add di,2
    loop s
    
    pop ds
    pop si
    pop di
    pop cx
    pop bx
    pop ax
    
    mov ax,4c00h
    int 21h
	iret
next:nop
CODES ENDS
    END START




