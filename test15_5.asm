;安装新的int9中断例程，使原有int9中断例程的到拓展
;功能，在DOS下，按下A键改变当前屏幕的显示颜色，其他键照常处理

STACKS SEGMENT
    db 128 dup (0);存放标志寄存器的值
    
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,SS:STACKS
START:
    MOV AX,stacks
    mov ss,ax
    mov sp,128
    
    push cs
    pop ds
    mov si,offset int9;设置ds:si指向安装中断程序首地址
    
    
    xor ax,ax
    mov es,ax
    mov di,204h;设置es:di指向安装的目的地址0000:0204
    mov cx,offset int9end-offset int9;设置传输长度
    cld;设置df=0，si,di递增
    rep movsb
    
    ;存放原int9中断向量表
    push es:[9*4]
    pop es:[200h];存放原中断例程入口偏移地址
    push es:[9*4+2]
    pop es:[202h];存放原中断例程入口段地址
    
    ;设置新int9中断向量表
    cli;设置IF=0，在处理int9中断程序的时候禁止其他的可屏蔽中断
    mov word ptr es:[9*4],204h
    mov word ptr es:[9*4+2],0
    sti;设置IF=1，处理完新int9中断程序后可接受其他的可屏蔽中断
    
    ;调用延迟程序验证新安装的中断子程序
    call delay
    
    MOV AH,4CH
    INT 21H
    
    ;延迟子程序
    delay:
    push ax
    push dx
    mov dx,0100h
    xor ax,ax
    s1:
    sub ax,1
    sbb dx,0
    cmp ax,0
    jne s1
    cmp dx,0
    jne s1
    
    pop dx
    pop ax
    ret
    
    int9:
    push ax
    push bx
    push cx
    push es
    
    in al,60h
    pushf
    call dword ptr cs:[200h];当此中断例程执行时,(cs)=0
    
    cmp al,1eh;判断按下的键是否为A键
    jne int9ret
    
    ;改变显示屏幕的字体颜色
    mov ax,0b800h
    mov es,ax
    mov bx,1
    mov cx,2000
    s:
    inc byte ptr es:[bx]
    add bx,2
    loop s
    
    int9ret:
    pop es
    pop cx
    pop bx
    pop ax
    iret
    
    int9end:
    nop
    
CODES ENDS
    END START

