;外中断，编写int9中断例程
;在屏幕中间依次显示'a'到'z'，并且让人看清
;在显示的过程中，按下Esc键可以切换字体颜色
;要在DOS实模式下运行
DATAS SEGMENT
    dw 0,0;定义data段存放int9中断例程的原入口地址
DATAS ENDS

STACKS SEGMENT
    db 128 dup (0);定义stack段存放标志寄存器
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,stacks
    mov ss,ax
    mov sp,128
    
    mov ax,datas
    mov ds,ax
    
    xor ax,ax
    mov es,ax
    
    push es:[9*4]
    pop ds:[0];保存int9中断例程的原入口偏移地址
    push es:[9*4+2]
    pop ds:[2];保存int9中断例程的原入口段地址
    
    ;设置新int9中断例程的中断向量表
    mov word ptr es:[9*4],offset int9
    mov word ptr es:[9*4+2],cs
    
    ;将字符送入显示缓冲区
    mov ax,0b800h
    mov es,ax
    mov ah,'a'
    s:
    mov es:[160*12+40*2],ah
    call delay
    inc ah
    cmp ah,'z'
    jna s
    
    ;恢复原int9中断例程的入口地址，保证之后的程序调用int9的正确性
    
    xor ax,ax
    mov es,ax
    
    push ds:[0]
    pop es:[9*4]
    push ds:[2]
    pop es:[9*4+2]
    
    MOV AH,4CH
    INT 21H
    
    delay:
    push ax
    push dx
    mov dx,000fh
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
    push es
    
    in al,60h
    
    pushf;标志寄存器入栈
    ;对int指令进行模拟，调用原来的int9中断例程
    pushf
    pop bx
    and bh,11111100b
    push bx
    popf
    call dword ptr ds:[0]
    
    ;判断键盘输入扫描码是否为1，即是否键入Esc
    
    cmp al,1
    jne int9ret
    
    mov ax,0b800h
    mov es,ax
    inc byte ptr es:[160*12+40*2+1]
    
    int9ret:
    pop es
    pop bx
    pop ax
    iret
    
CODES ENDS
    END START
