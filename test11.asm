;编写letterc子程序将包含任意字符以0
;结尾的字符串中的小写字母转变为大写字母
DATAS SEGMENT
    db "Beginner's All-purpose Symbolic Instruction Code.",0 
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    xor si,si;ds:si指向字符串首地址
    call letterc
    
    MOV AH,4CH
    INT 21H
    
    letterc:
    push ds
    push si
    push ax
    xor si,si
    s:mov al,ds:[si]
    cmp al,0;判别字符是否为0，如果是则结束循环
    je next1
    cmp al,97;判别字符是否大于等于'a'，如果小于则进行下一次循环
    jnb next
    jmp short done
    
    next:
    cmp al,122;判别字符是否小于等于'z',如果大于则进行下一次循环
    jna ok
    jmp short done 
    
    ok:
    and al,11011111b;将小写字符转变成大写
    mov ds:[si],al
    
    done:nop;进行下一次循环标志处
    
    inc si;si递增1
    jmp short s
    
    next1:nop;跳出循环标志处
    
    pop ax
    pop si
    pop ds
    
    ret
    
CODES ENDS
    END START
