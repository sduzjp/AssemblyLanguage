;dtoc子程序将word型数据转变为表示十进制数的字符串
;show_str子程序显示以0结尾的字符串
;该程序需要进一步改进的地方，如果事先不知道ax数值位数
;如果有多个数值需要显示
DATAS SEGMENT
    db 10 dup (0) 
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV bx,DATAS
    MOV DS,bx
    mov ax,12666
    xor si,si
    call dtoc
    
    mov dh,8
    mov dl,3
    mov cl,2
    call show_str
    
    MOV AH,4CH
    INT 21H
    ;利用除10取余法依次将ax中各位数字提取出来
    ;然后加上30H变为对应的ASCII码数值存放
    ;注意存放的时候的顺序，由于取余时是从最后位开始
    ;所以存放时要将顺序反过来
    dtoc:push ax
    push cx
    push ds
    push bx
    push dx
    push di
    
    mov di,8
    mov cx,5
    mov bx,10
    s:xor dx,dx
    div bx
    add dx,30h
    mov ds:[di],dx
    sub di,2
    loop s
    
    xor ax,ax
    mov ds:[10],ax
    pop di
    pop dx
    pop bx
    pop ds
    pop cx
    pop ax
    ret
    
    show_str:
   	push es
   	push cx
   	push ax
   	push si
   	push ds
   	push bx
   	
   	
   	mov bx,0b800h
   	mov es,bx
   	mov bx,500h
   	mov dl,cl
   	mov di,0
   	
   	mov cx,16
   	
   	s0:mov al,ds:[di]
   	mov es:[bx+si+4],al
   	mov es:[bx+si+5],dl
   	add si,2
   	inc di
   	loop s0
   	
   	
   	pop bx
   	pop ds
   	pop si
   	pop ax
   	pop cx
   	pop es
   	ret
    

CODES ENDS
    END START

