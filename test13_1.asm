;中断例程int0
CODES SEGMENT
    ASSUME CS:CODES
START:
    MOV AX,0b800h
    mov es,ax
    ;屏幕中间显示'!'
    mov byte ptr es:[12*160+40*2],'!'
    ;调用int0中断子程序显示divide error
    int 0
 
CODES ENDS
    END START
