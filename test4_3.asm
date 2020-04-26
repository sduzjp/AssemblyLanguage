;键盘输入10个学生成绩，分别统计
;60-69分,70-79分,80-89分,90-99分,100分
;的人数,分别存放在Score6,Score7,Score,Score9,Score10中
;然后分别依次显示
;10个学生成绩:65,98,78,82,88,95,72,62,90,100
;定义缓冲区存放输入的10个学生成绩,输入时每个数据之间隔一个空格
;且第一个数据前和最后一个数据后都加一个空格
DATAS SEGMENT
    infon db 0dh,0ah,'Please input the scores of ten students:$'  
	buf db 100
		db ?
		db 100 dup(0)
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
    ;定义score五个字节内存单元,分别代表score6到score10
    score db 0,0,0,0,0
START:
	
    MOV AX,DATAS
    MOV DS,AX
 	
 	mov di,offset score;取得score的偏移地址
 	
	lea dx,infon
 	mov ah,9
 	int 21h;显示输入提示信息
	
	lea dx,buf
	mov ah,10
	int 21h;输入十个学生成绩
	
	lea si,buf+2;ds:si指向输入字符串
	mov cx,10;循环10次，判断十个数据分别对应区间
lp:
	mov al,ds:[si+3]
	cmp al,' ';判断隔两个位后是否为空格
    jz next1;若为空格则代表一个两位数
    inc byte ptr cs:[di+4];若不为空格代表一个三位数100,则score10自增1
    add si,4;si自增4继续进行下一次判断
  	jmp short next2
  next1:
  	mov al,ds:[si+1]
  	sub al,30h;获得两位数的十位数数字
  	call bjbyte;调用bjbyte子程序，判断十位数字为多少
  	add si,3;si自增3继续进行下一次判断
  next2:nop
loop lp

	mov bx,0b800h
	mov es,bx
	mov si,offset score
	mov di,160*12+40*2;es:di指向显示缓冲区，在屏幕中间显示结果
	mov dl,2;设置字体颜色
	mov cx,5;输出显示score6到score10五位数字
xianshi:
	mov al,cs:[si]
	add al,30h
	mov es:[di],al
	mov es:[di+1],dl
	inc si
	add di,4
loop xianshi

    MOV AH,4CH
    INT 21H;程序返回
    ;bjbyte子程序
bjbyte:
	cmp al,6;判断十位数字是否为6
	jz s
  	jmp short s1
  s:;若为6则score6自增1
	inc byte ptr cs:[di]
	jmp short done
  s1:;若不为6继续判断是否为7
  	cmp al,7
  	jz s2
  	jmp short s3
  s2:;若为7则score7自增1
  	inc byte ptr cs:[di+1]
  	jmp short done
  s3:;若不为7则继续判断是否为8
    cmp al,8
    jz s4
    jmp short s5
  s4: ;若为8则score8自增1
    inc byte ptr cs:[di+2]
    jmp short done
  s5:;若不为8则必为数字9，score9自增1
  	inc byte ptr cs:[di+3]
  done:nop
  ret;子程序返回
  
CODES ENDS
    END START









