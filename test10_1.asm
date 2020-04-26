;计算data段中的第一组数据的三次方，结果保存在后面一组dword
;单元中

DATAS SEGMENT
    dw 1,2,3,4,5,6,7,8
    dd 0,0,0,0,0,0,0,0
     
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    xor si,si		;用xor指令代替mov si,0
    mov di,16		;ds：si指向第一组word单元
    				;ds：di指向第二组dword单元
    
    mov cx,8		;第一组有八个数，循环计算八次
  s:mov bx,[si]
    call cube		;cube为计算三次方子程序
    mov [di],ax		;三次方结果的低八位存放在ax中
    mov [di].2,dx	;三次方结果的高八位存档在dx中
    add si,2
    add di,4
    loop s
    
    MOV AH,4CH
    INT 21H
    
    cube: mov ax,bx
    mul bx
    mul bx
    ret
CODES ENDS
    END START

