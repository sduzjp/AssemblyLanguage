datas segment
	db 'welcome to masm'
datas ends

CODES SEGMENT
    ASSUME CS:CODES
START:
    MOV AX,0b800h;47104
    MOV DS,AX
    mov ax,datas
    mov es,ax
	mov si,0
	mov bx,0
	
	mov cx,16
	s:mov al,es:[si]
	mov ds:[bx+50],al
	mov ds:[bx+0a0h+50],al
	mov ds:[bx+140h+50],al
	mov al,02h
	mov ds:[bx+51],al
	mov al,24h
	mov ds:[bx+0a0h+51],al
	mov al,71h
	mov ds:[bx+140h+51],al
	add bx,2
	inc si
	loop s
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
