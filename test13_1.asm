;�ж�����int0
CODES SEGMENT
    ASSUME CS:CODES
START:
    MOV AX,0b800h
    mov es,ax
    ;��Ļ�м���ʾ'!'
    mov byte ptr es:[12*160+40*2],'!'
    ;����int0�ж��ӳ�����ʾdivide error
    int 0
 
CODES ENDS
    END START
