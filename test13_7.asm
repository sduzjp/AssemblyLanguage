;DOS中断例程应用int21h
;在屏幕的5行12列显示字符串"Welcome to masm!"
;调用int21h的第九号子程序，要显示的子程序需用'$'作为结束符

DATAS SEGMENT
    db 'Welcome to masm','$' 
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
	mov ah,2;置光标
	mov bh,0;第0页
	mov dh,5;第5行
	mov dl,12;第12列
	int 10h;调用int10h的2号子程序置光标
	
	;易错点：注意只能用ds:dx指向字符串首地址，不能用ds:si/ds:di
	
    MOV AX,DATAS
    MOV DS,AX
    xor dx,dx;ds:dx指向字符串首地址
    mov ah,9
    int 21h;调用int21h中断例程的9号子程序显示字符串
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
