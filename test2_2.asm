
CODES SEGMENT
    ASSUME CS:CODES
START:
    MOV ah,1
    int 21h		;�˴��������������ַ��洢��AL��
 
    cmp al,0dh
    je done		;�ж�AL�������ַ��Ƿ�Ϊ�س�
    			;������Զ���ת����ţ�done������ִ�У�done��ֱ�ӽ�������
    cmp al,'0'  ;�ж������ַ��Ƿ��ڡ�0������9��֮��			
    jb start	;����ȡ�0�����򷵻صȴ���һ���ַ�����
    cmp al,'9'	;����ȡ�0��С������͡�9���Ƚ�
    ja zimuxx	;����ȡ�9��������ת��zimuxx���ж��Ƿ���
    			;Сд��ĸ��a���͡�z'֮��
    			;�����'9'С����AL���ַ�ֱ����ʾ
    mov dl,al
    mov ah,2
    int 21h
    jmp start
    
    zimuxx: cmp al,41h;��������ַ��ȡ�a��С��
    jb start		  ;�򷵻صȴ���һ�ַ�����
    cmp al,5ah		  ;��������ַ��ȡ�a'�󣬼����롮z'�Ƚ�
    ja zimudx		  ;����ȡ�z'������ת��zimudx
    				  ;�ж��Ƿ��ڴ�д��ĸ��A���͡�Z��֮��
    				  ;����ȡ�z��С���򽫡�c���洢��dl����ʾ
    display:mov dl,'c'
    mov ah,2
    int 21h     
    
    jmp start		  ;ʵ��ѭ������ʾһ���ַ����صȴ���һ�ַ�����
    
    zimudx:cmp al,61h ;��������ַ��ȡ�A��С
    jb start		  ;�򷵻صȴ���һ�ַ�����
    cmp al,7ah		  ;����ȡ�A����������롮Z���Ƚ�
    ja start		  ;�����'Z'���򷵻صȴ���һ�ַ�����
    jmp display		  ;�����'Z'С������ת��display����ʾ
    
    done:MOV AH,4CH
    INT 21H
CODES ENDS
    END START

