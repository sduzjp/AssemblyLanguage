;解决除法溢出子程序

CODES SEGMENT
    ASSUME CS:CODES
START:
    mov ax,4240H	;计算1000000/10（F4240H/0AH）
    mov dx,000Fh	;ax存放低16位，dx存放高16位
    mov cx,0ah		;cx存放除数16位
    call divdw
    
    MOV AH,4CH
    INT 21H
    
    divdw:
    push ds
    push dx
    push cx
    push ax
    
    mov ax,dx	;先求高16位除以除数的结果，ax存放商，dx存放余数
    xor dx,dx
    div cx
    push dx
    			;将余数保存下来
    mov dx,ax
    xor ax,ax
    mov ds:[0],ax
    mov ds:[2],dx;将高16位的除法结果保存在高地址字单元中
    
    pop dx		;弹出高16位除法结果的余数
    pop ax		;将被除数的低16位取出来
    push ax		;恢复栈顶，维持push和pop平衡
    div cx		;此时dx存放高16位除法的余数，ax存放被除数低16位
    			;最后结果ax存放商，dx存放余数
    			
    mov ds:[0],ax;将低16位的除法结果商放在低地址字单元
    mov ds:[4],dx;最后的余数放在ds:[4]字单元中
    ;最后结果的低16位在ds:[0],高16位在ds:[2],余数在ds:[4]
    pop ax
    pop cx
    pop dx
    pop ds
    ret
CODES ENDS
    END START


