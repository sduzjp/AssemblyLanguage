;对int、iret和栈的深入理解
;用7ch中断例程完成loop指令的功能
;中断例程完成cx递减和转移指令操作

CODES SEGMENT
    ASSUME CS:CODES
START:
	;安装中断例程
	mov ax,cs
	mov ds,ax
	mov si,offset lp;设置ds:si指向中断例程首地址
	xor ax,ax
	mov es,ax
	mov di,200h;设置es:di指向安装目的地址0000:0200
	mov cx,offset lpend-offset lp;设置传输长度
	cld;设置df=0，si,di递增
	rep movsb
	
	;设置中断向量表
	xor ax,ax
	mov es,ax
	mov word ptr es:[7ch*4],200h
	mov word ptr es:[7ch*4+2],0
	
	;在屏幕中间显示40个'!'
	
    MOV AX,0b800h
    mov es,ax
    mov di,160*12+30;设置ds:di指向显示缓冲区的中间部分
    
    ;cx记录循环次数，bx记录loop指令需要跳转的地址转移长度
    ;易错点：当段地址放在es中时，采用段寄存器:[偏移地址]须知方式时，必须注明es
    ;易错点：将字符'!'送入显示缓冲区时，须注明byte ptr
    mov es:[di+1],al
    mov bx,offset s-offset se
    mov al,2
    mov cx,40
    s:
    mov byte ptr es:[di],'!'
    mov es:[di+1],al
    add di,2
    int 7ch
    
    se:nop
    
    MOV AH,4CH
    INT 21H
    
    ;中断例程
    ;由于调用中断例程会先将int7ch下一条指令的cs，ip压栈
    ;因此需要根据栈内下一条指令的IP以及转移的地址长度来返回循环首地址处
    
    lp:
    push bp;将bp入栈保护
    mov bp,sp;设置ss:bp指向栈顶
    dec cx;完成loop指令的cx递减操作
    jcxz lpret;如果cx=0直接结束循环，执行循环外下一条指令
    add [bp+2],bx;如果cx！=0，将压入栈内的int 7ch的下一条指令的IP修改为循环首地址的IP
    lpret:
    pop bp;将bp出栈恢复
    iret;弹出压入栈的CS,IP值以及标志寄存器值
	
	lpend:nop
	
	
CODES ENDS
    END START

