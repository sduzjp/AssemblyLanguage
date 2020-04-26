;dtoc子程序将word型数据转变为表示十进制数的字符串
;show_str子程序显示以0结尾的字符串
;显示十进制数值改进程序
;程序还需改进地方，存在除法溢出
DATAS SEGMENT
    db 10 dup (0) 
DATAS ENDS

stack segment
	db 256 dup (0)
stack ends

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV bx,DATAS
    MOV DS,bx
    mov bx,stack
    mov ss,bx
    mov sp,100h
    mov ax,10000
    xor si,si
    call dtoc
    
    mov dh,8
    mov dl,3
    mov cl,2
    call show_str
    
    done:MOV AH,4CH
    INT 21H
    ;利用除10取余法依次将ax中各位数字提取出来
    ;然后加上30H变为对应的ASCII码数值存放
    ;注意存放的时候的顺序，由于取余时是从最后位开始
    ;所以存放时要将顺序反过来,利用push和pop指令实现这一功能
    dtoc:push ax
    push cx
    push ds
    push bx
    push dx
    push di
    
    xor si,si
	s:mov cx,10
	xor dx,dx
	div cx
	add dx,30h
	push dx
	inc si
	mov cx,ax
	jcxz s1			;jcxz指令是当cx=0才跳转到标号处执行
	jmp near ptr s
	
	s1:xor di,di
	mov cx,si
	s2:pop ds:[di]
	add di,2		;注意di的递增数值
	dec cx
    jcxz s3
	jmp short s2
	
	s3:xor ax,ax	;注意最后要在字符串后面字单元存放0
	mov ds:[di],ax
	
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
   	xor di,di
   	xor si,si
   	
   	s0:mov al,ds:[di]		;注意是对字节单元进行存储
   	mov es:[bx+si+4],al
   	mov es:[bx+si+5],dl
   	add si,2
   	add di,2
   	cmp al,0
	jna done
   	jmp short s0
   	
   	
   	pop bx
   	pop ds
   	pop si
   	pop ax
   	pop cx
   	pop es
   	ret
    

CODES ENDS
    END START


