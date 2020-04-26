DATAS SEGMENT
    db 'D','E','C'
    db 'K','e','n',' ','O','s','l','e','n'
    dw 137,40
    db 'P','D','P'
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    mov bx,0
    
    mov word ptr [bx+0ch],38
    add word ptr [bx+0eh],70
    
    mov si,0
    mov byte ptr [bx+10h+si],'V'
    inc si
    mov byte ptr [bx+10h+si],'A'
    inc si
    mov byte ptr [bx+10h+si],'X'
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
