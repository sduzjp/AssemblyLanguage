;将一个全是字母的字符串转化为大写

DATAS SEGMENT
    db 'conversation'  
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    xor si,si		;ds：si指向datas段
    
    mov cx,12		;字符串有12个字母，因此循环12次
    call capital	;调用capital子程序，将字母转化为大写
  
    MOV AH,4CH
    INT 21H
    
    capital:and byte ptr [si],11011111b
    ;字母转换为大写只需要减30H，进行与运算
    inc si
    loop capital
    ret
    
CODES ENDS
    END START
