;完成对多个字符串的转换（小写转换为大写）
DATAS SEGMENT
    db 'word',0
    db 'unix',0
    db 'wind',0
    db 'good',0  ;单个字符串结尾用0表示
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    xor bx,bx
    
    mov cx,4		;四个字符串，循环四次
    s:mov si,bx
    call capital	
    add bx,5		;一个字符串完成转换后调到下一个字符串
    loop s
    
    MOV AH,4CH
    INT 21H
    
    capital:		;注意以后编写子程序时要先保存寄存器原有值
    push cx
    push si
    
    change:
    mov cl,[si]
    mov ch,0
    jcxz ok			;当一个字符串结束时或者所有都完成转换后cx=0
    and byte ptr [si],11011111b
    inc si
    jmp short change
    
    ok:
    pop si
    pop cx
    ret
CODES ENDS
    END START
