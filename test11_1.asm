;利用串传送指令将data段第一个字符串
;复制到后面的空间
DATAS SEGMENT
    db 'welcome to masm!'
    db 16 dup (0)  
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    xor si,si;ds:si指向第一个字符串
    mov es,ax
    mov di,16;ds:di指向后面首地址
    mov cx,16;设置cx为传输长度
    cld		 ;设置df=0,si,di递增
    rep movsb
    
    mov dh,8
    mov dl,3
    mov cl,2
    call show_str
    mov dh,9
    mov dl,3
    mov cl,2
    mov ax,ds
    inc ax
    mov ds,ax
    call show_str
    
    MOV AH,4CH
    INT 21H
    
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



