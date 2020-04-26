;将f000H段的最后16个字符复制到data段中
DATAS SEGMENT
    db 16 dup (0)  
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,0f000h
    MOV DS,AX	;ds:si指向F000:ffff
    mov si,0ffffh
    mov ax,datas
    mov es,ax
    mov di,15;ds:di指向datas:000f
    mov cx,16;设置cx为传输长度
    std		 ;设置df=1，si和di递减
    rep movsb
    
    MOV AH,4CH
    INT 21H
    
CODES ENDS
    END START


