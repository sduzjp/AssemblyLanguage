;��дletterc�ӳ��򽫰��������ַ���0
;��β���ַ����е�Сд��ĸת��Ϊ��д��ĸ
DATAS SEGMENT
    db "Beginner's All-purpose Symbolic Instruction Code.",0 
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    xor si,si;ds:siָ���ַ����׵�ַ
    call letterc
    
    MOV AH,4CH
    INT 21H
    
    letterc:
    push ds
    push si
    push ax
    xor si,si
    s:mov al,ds:[si]
    cmp al,0;�б��ַ��Ƿ�Ϊ0������������ѭ��
    je next1
    cmp al,97;�б��ַ��Ƿ���ڵ���'a'�����С���������һ��ѭ��
    jnb next
    jmp short done
    
    next:
    cmp al,122;�б��ַ��Ƿ�С�ڵ���'z',��������������һ��ѭ��
    jna ok
    jmp short done 
    
    ok:
    and al,11011111b;��Сд�ַ�ת��ɴ�д
    mov ds:[si],al
    
    done:nop;������һ��ѭ����־��
    
    inc si;si����1
    jmp short s
    
    next1:nop;����ѭ����־��
    
    pop ax
    pop si
    pop ds
    
    ret
    
CODES ENDS
    END START
