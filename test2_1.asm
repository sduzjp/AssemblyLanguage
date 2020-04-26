
CODES SEGMENT
    ASSUME CS:CODES
START:
    MOV Al,3eh;向al寄存器中写入一个两位十六进制数
    MOV bl,al ;保存al中的值
    mov dl,al ;将al中数写入dl寄存器中
    		  ;之后将每位数保存成ASCII码对应的十进制数
    		  ;最后通过执行程序显示数
    mov cl,4  ;设置dl中数据右移位数
    shr dl,cl ;先操作al中数的高位，一位一位显示ASCII码字符
 
    cmp dl,9  ;判断dl中数是否小于等于9,
    		  ;若满足条件，则直接加30H变成ASCII码对应的十进制数
    		  ;不满足，则加7之后再加30H变成ASCII码对应的十进制数
    
    jbe next1
    add dl,7
    next1:add dl,30h
    mov ah,2
    int 21h			;显示al中高位数ASCII码
    mov dl,bl		;恢复al值
    and dl,0fh		;dl中保存低位数，按照处理高位方法继续显示低位
    cmp dl,9
    jbe next2
    add dl,7
    
    next2:add dl,30h
    mov ah,2
    int 21h			;显示al中低位数ASCII码
    
    mov ah,4ch
    int 21h
CODES ENDS
    END START

