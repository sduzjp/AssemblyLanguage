data segment
	buf db 100
		db ?
		db 100 dup(0)
	infon db 0dh,0ah,'Please enter hexadecimal digits:$'
data ends

datas segment
	db 128 dup(0)
datas ends

show segment
	db 128 dup(0)
show ends

code segment
	assume cs:code,ds:data
start:
	;用int21h的10号功能调用实现输入一个字符串并存到内存缓冲区data
	mov ax,data
	mov ds,ax
	
	lea dx,infon
	mov ah,9
	int 21h
	
	lea dx,buf
	mov ah,10
	int 21h 
	
	mov si,2
	mov cx,8
	a:
	push cx
	mov al,ds:[si]
	call change
	mov ds:[si],al
	inc si
	pop cx
	loop a
	
	mov si,2
	call lbyte
	mov bx,show
	mov es,bx
	mov di,0
	mov si,3
	mov cx,4
	nixu:
	mov al,ds:[si]
	mov es:[di],al
	dec si
	inc di
	loop nixu
	mov ax,es:[0]
	mov dx,es:[2]
	
	MOV bx,DATAS
    MOV ds,bx
    mov bx,show
    mov es,bx
    mov cx,0ah
    call dwtoc
    
    mov cl,2
    call show_str
    
	done:mov ax,4c00h
	int 21h
	
	dwtoc:
	push ax
	push bx
	push cx
	push ds
	xor si,si
	xor di,di
	s:
	call divdw
	mov bx,ds:[4]
	add bx,30h
	mov es:[si],bx
	inc di			;设置di记录数据有多少位
	mov ax,ds:[0]	;注意循环调用calldiw时候必须预先处理好ax，dx，即将上一次取余后的商存好
	mov dx,ds:[2]
	add si,2
	cmp dx,0		;最后结束标志ax，dx中存放数据都为0
	je next
	jmp far ptr s
	next:
	cmp ax,0
	je ok1
	jmp far ptr s
	
	ok1:
	xor si,si		;实现将show段的数据逆序放到ds段中
	mov cx,di
	dec di
	add di,di
	s1:
	mov ax,es:[di]
	mov ds:[50+si],ax
	sub di,2
	add si,2
	loop s1
	
	xor ax,ax
	mov ds:[50+si],ax
	
	pop ds
	pop cx
	pop bx
	pop ax
	
	ret
	
    divdw:
    push ds
    push dx
    push cx
    push ax
    
    mov ax,dx	;先求高16位除以除数的结果，ax存放商，dx存放余数
    xor dx,dx
    div cx
    push dx
    			;将余数保存下来
    mov dx,ax
    xor ax,ax
    mov ds:[0],ax
    mov ds:[2],dx;将高16位的除法结果保存在高地址字单元中
    
    pop dx		;弹出高16位除法结果的余数
    pop ax		;将被除数的低16位取出来
    push ax		;恢复栈顶，维持push和pop平衡
    div cx		;此时dx存放高16位除法的余数，ax存放被除数低16位
    			;最后结果ax存放商，dx存放余数
    			
    mov ds:[0],ax;将低16位的除法结果商放在低地址字单元
    mov ds:[4],dx;最后的余数放在ds:[4]字单元中
    ;最后结果的低16位在ds:[0],高16位在ds:[2],余数在ds:[4]
    pop ax
    pop cx
    pop dx
    pop ds
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
   	
   	s0:mov al,ds:[50+di]		;注意是对字节单元进行存储
   	mov es:[bx+si+4],al
   	mov es:[bx+si+5],dl
   	add si,2
   	add di,2					
   	;实际上十进制每位上的数小于10
   	;所以在内存单元存放时只放在子单元的低地址字节单元
   	;因此di递增2，而不是递增1
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
   	
   	change:
	push bx
	push es
	
	cmp al,'0'
	jb ok
	cmp al,'9'
	jna next1
	cmp al,'A'
	jb ok
	cmp al,'F'
	jna next2
	cmp al,'a'
	jb ok
	cmp al,'f'
	jna next3
	jmp short ok
	
	next1:
	sub al,30h
	jmp short ok
	next2:
	sub al,37h
	jmp short ok
	next3:
	sub al,57h
	jmp short ok
	ok:nop
	pop es
	pop bx
	ret
	
	lbyte:
	xor di,di
	mov cx,4
	s4:
	push cx
	mov al,ds:[si]
	mov bl,ds:[si+1]
	mov cl,4
	shl al,cl
	add al,bl
	mov ds:[di],al
	inc di
	add si,2
	pop cx
	loop s4
	ret
code ends
	end start
















