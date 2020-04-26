;BIOS中断例程应用
;在屏幕的5行12列显示3个红底高亮闪烁绿色的'a'

CODES SEGMENT
    ASSUME CS:CODES
START:
    mov ah,2;置光标
    mov bh,0;表示第0页
    mov dh,5;表示第5行
    mov dl,12;表示第12列
    int 10h  ;调用int 10h中断例程中2号子程序
    
    mov ah,9;在光标位置显示字符
    mov al,'a';al中存放字符
    mov bl,11001010b;bl中存放颜色属性，11001010属于红底高亮闪烁绿色
    mov  bh,0;第0页
    mov cx,3;字符重复的个数
    int 10h;调用int 10h中断例程的9号子程序
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
