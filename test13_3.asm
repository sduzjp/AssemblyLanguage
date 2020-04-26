;编写安装中断7ch的中断例程
;将一个全是字母以0结尾的字符串转化为大写

DATAS SEGMENT
    db 'conversation',0
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES
START:
	mov ax,cs
	mov ds,ax
	mov si,offset capital;设置ds:si指向中断程序首地址
	xor ax,ax
	mov es,ax
	mov di,200h;设置es:di指向安装的目的地址0000:0200
	mov cx,offset capitalend-offset capital;设置传输长度
	cld;设置df=0，si,di递增
	rep movsb
	
	;设置int7ch中断例程向量表
	xor ax,ax
	mov es,ax
	mov word ptr es:[7ch*4],200h
	mov word ptr es:[7ch*4+2],0
	
	;调用int7ch中断例程将字符串转化为大写
    MOV AX,datas
    mov ds,ax
    xor si,si
    int 7ch
    
    ;调用显示字符串子程序验证中断例程结果
    mov ax,datas
    mov ds,ax
    xor si,si
    MOV dh,8
    MOV dl,3
    mov cl,2
    call show_str
    
    MOV AH,4CH
    INT 21H
    
    capital:
    push cx
    push si
    
    change:
    mov cl,[si]
    xor ch,ch
    jcxz ok;当输入字符为0时跳出循环
    and byte ptr [si],11011111b
    inc si
    jmp short change
    
    ok:pop si
    pop cx
    iret
    
   	capitalend:nop
        
    show_str:
   	push es
   	push cx
   	push ax
   	push si
   	push ds
   	push bx
   	
   	mov bx,0b800h
   	mov es,bx
   	mov al,160
   	mul dh
  	mov bx,ax
   	dec dl
   	add dl,dl
   	xor dh,dh
   	add bx,dx
   	mov dl,cl
   	xor di,di
   	xor si,si
   	
   	mov cx,16
   	
   	s:mov al,ds:[di]
   	mov es:[bx+si],al
   	mov es:[bx+si+1],dl
   	add si,2
   	inc di
   	loop s
   	
   	
   	pop bx
   	pop ds
   	pop si
   	pop ax
   	pop cx
   	pop es
   	ret
CODES ENDS
    END START



