;��������10��ѧ���ɼ����ֱ�ͳ��
;60-69��,70-79��,80-89��,90-99��,100��
;������,�ֱ�����Score6,Score7,Score,Score9,Score10��
;Ȼ��ֱ�������ʾ
;10��ѧ���ɼ�:65,98,78,82,88,95,72,62,90,100
;���建������������10��ѧ���ɼ�,����ʱÿ������֮���һ���ո�
;�ҵ�һ������ǰ�����һ�����ݺ󶼼�һ���ո�
DATAS SEGMENT
    infon db 0dh,0ah,'Please input the scores of ten students:$'  
	buf db 100
		db ?
		db 100 dup(0)
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
    ;����score����ֽ��ڴ浥Ԫ,�ֱ����score6��score10
    score db 0,0,0,0,0
START:
	
    MOV AX,DATAS
    MOV DS,AX
 	
 	mov di,offset score;ȡ��score��ƫ�Ƶ�ַ
 	
	lea dx,infon
 	mov ah,9
 	int 21h;��ʾ������ʾ��Ϣ
	
	lea dx,buf
	mov ah,10
	int 21h;����ʮ��ѧ���ɼ�
	
	lea si,buf+2;ds:siָ�������ַ���
	mov cx,10;ѭ��10�Σ��ж�ʮ�����ݷֱ��Ӧ����
lp:
	mov al,ds:[si+3]
	cmp al,' ';�жϸ�����λ���Ƿ�Ϊ�ո�
    jz next1;��Ϊ�ո������һ����λ��
    inc byte ptr cs:[di+4];����Ϊ�ո����һ����λ��100,��score10����1
    add si,4;si����4����������һ���ж�
  	jmp short next2
  next1:
  	mov al,ds:[si+1]
  	sub al,30h;�����λ����ʮλ������
  	call bjbyte;����bjbyte�ӳ����ж�ʮλ����Ϊ����
  	add si,3;si����3����������һ���ж�
  next2:nop
loop lp

	mov bx,0b800h
	mov es,bx
	mov si,offset score
	mov di,160*12+40*2;es:diָ����ʾ������������Ļ�м���ʾ���
	mov dl,2;����������ɫ
	mov cx,5;�����ʾscore6��score10��λ����
xianshi:
	mov al,cs:[si]
	add al,30h
	mov es:[di],al
	mov es:[di+1],dl
	inc si
	add di,4
loop xianshi

    MOV AH,4CH
    INT 21H;���򷵻�
    ;bjbyte�ӳ���
bjbyte:
	cmp al,6;�ж�ʮλ�����Ƿ�Ϊ6
	jz s
  	jmp short s1
  s:;��Ϊ6��score6����1
	inc byte ptr cs:[di]
	jmp short done
  s1:;����Ϊ6�����ж��Ƿ�Ϊ7
  	cmp al,7
  	jz s2
  	jmp short s3
  s2:;��Ϊ7��score7����1
  	inc byte ptr cs:[di+1]
  	jmp short done
  s3:;����Ϊ7������ж��Ƿ�Ϊ8
    cmp al,8
    jz s4
    jmp short s5
  s4: ;��Ϊ8��score8����1
    inc byte ptr cs:[di+2]
    jmp short done
  s5:;����Ϊ8���Ϊ����9��score9����1
  	inc byte ptr cs:[di+3]
  done:nop
  ret;�ӳ��򷵻�
  
CODES ENDS
    END START









