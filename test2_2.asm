
CODES SEGMENT
    ASSUME CS:CODES
START:
    MOV ah,1
    int 21h		;此处将键盘上输入字符存储到AL中
 
    cmp al,0dh
    je done		;判断AL中输入字符是否为回车
    			;如果是自动跳转到标号：done处继续执行，done处直接结束程序
    cmp al,'0'  ;判断输入字符是否在‘0’到‘9’之间			
    jb start	;如果比‘0’大则返回等待下一个字符输入
    cmp al,'9'	;如果比‘0’小则继续和‘9’比较
    ja zimuxx	;如果比‘9’大则跳转到zimuxx，判断是否在
    			;小写字母‘a’和‘z'之间
    			;如果比'9'小，则将AL中字符直接显示
    mov dl,al
    mov ah,2
    int 21h
    jmp start
    
    zimuxx: cmp al,41h;如果输入字符比‘a’小，
    jb start		  ;则返回等待下一字符输入
    cmp al,5ah		  ;如果输入字符比‘a'大，继续与‘z'比较
    ja zimudx		  ;如果比‘z'大，则跳转到zimudx
    				  ;判断是否在大写字母‘A’和‘Z’之间
    				  ;如果比‘z’小，则将‘c’存储到dl中显示
    display:mov dl,'c'
    mov ah,2
    int 21h     
    
    jmp start		  ;实现循环，显示一个字符返回等待下一字符输入
    
    zimudx:cmp al,61h ;如果输入字符比‘A’小
    jb start		  ;则返回等待下一字符输入
    cmp al,7ah		  ;如果比‘A’大，则继续与‘Z’比较
    ja start		  ;如果比'Z'大，则返回等待下一字符输入
    jmp display		  ;如果比'Z'小，则跳转到display处显示
    
    done:MOV AH,4CH
    INT 21H
CODES ENDS
    END START

