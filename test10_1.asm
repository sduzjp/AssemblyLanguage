;����data���еĵ�һ�����ݵ����η�����������ں���һ��dword
;��Ԫ��

DATAS SEGMENT
    dw 1,2,3,4,5,6,7,8
    dd 0,0,0,0,0,0,0,0
     
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    xor si,si		;��xorָ�����mov si,0
    mov di,16		;ds��siָ���һ��word��Ԫ
    				;ds��diָ��ڶ���dword��Ԫ
    
    mov cx,8		;��һ���а˸�����ѭ������˴�
  s:mov bx,[si]
    call cube		;cubeΪ�������η��ӳ���
    mov [di],ax		;���η�����ĵͰ�λ�����ax��
    mov [di].2,dx	;���η�����ĸ߰�λ�浵��dx��
    add si,2
    add di,4
    loop s
    
    MOV AH,4CH
    INT 21H
    
    cube: mov ax,bx
    mul bx
    mul bx
    ret
CODES ENDS
    END START

