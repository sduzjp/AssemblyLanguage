DATAS SEGMENT
    db 'Welcome to masm!'
    db 'Hello World'
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    mov ax,datas
    mov ds,ax
    xor si,si
    MOV dh,8
    MOV dl,3
    mov cl,2
    call show_str
	mov dh,9
	mov dl,3
	mov ds,ax
	add ax,1
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




