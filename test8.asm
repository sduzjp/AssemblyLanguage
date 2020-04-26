DATAS SEGMENT
    db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
    db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
    db '1993','1994','1995'
    ;21个字符串，每个字符占一个内存单元（字节单元）
    ;起始段地址：datas
    
    dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
    dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5973000
    ;21个双字形数据，每个双字形数据占2个字单元=4个字节单元
    ;起始段地址：datas+84
    
    dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
    dw 11542,14430,15257,17800
    ;21个字形数据，每个字形数据占1个字单元=2个字节单元
	;起始段地址：datas+84+84
DATAS ENDS

table segment
	db 21 dup ('year summ ne ?? ')
table ends

CODES SEGMENT
    ASSUME CS:CODES
START:
	mov ax,table
	mov es,ax   ;es指向table段
    MOV AX,datas
    MOV ds,ax	;ds指向datas段
    mov bx,0    ;bx作datas段的雇员数数据偏移地址变量
    mov si,0	;si作datas段行偏移地址变量
    mov di,0	;di作table段行偏移地址变量
    
    mov cx,21
    s:mov ax,ds:[si+0]
    mov es:[di],ax
    mov ax,ds:[si+2]
    mov es:[di+2],ax	;将datas段的年份（两个字单元）
    					;分两次传送到table段
    
    mov ax,ds:[si+84+0]
    mov es:[di+5],ax
    mov dx,ds:[si+84+2]
    mov es:[di+7],dx	;将datas段的总收入（两个字单元）
    					;分两次传送到table段
    					;ax放低16位，dx放高16位
    
    push cx				;将cx放入栈中保存
    mov cx,ds:[bx+84+84]
    mov es:[di+0ah],cx	;将雇员人数送到table段
	div cx				;由于被除数为32位放在dx和ax中，
    ;除数为16位放在cx中，结果的商放在ax中，余数放在dx中
    
    pop cx				;将cx从栈中取出恢复
    					
    mov es:[di+0dh],ax	;将结果取整后也就是商送到table段
    add si,4
    add bx,2
    add di,16			;各个循环变量自增
    loop s 
    MOV Ax,4c00h
    INT 21H
CODES ENDS
    END START

