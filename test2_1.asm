
CODES SEGMENT
    ASSUME CS:CODES
START:
    MOV Al,3eh;��al�Ĵ�����д��һ����λʮ��������
    MOV bl,al ;����al�е�ֵ
    mov dl,al ;��al����д��dl�Ĵ�����
    		  ;֮��ÿλ�������ASCII���Ӧ��ʮ������
    		  ;���ͨ��ִ�г�����ʾ��
    mov cl,4  ;����dl����������λ��
    shr dl,cl ;�Ȳ���al�����ĸ�λ��һλһλ��ʾASCII���ַ�
 
    cmp dl,9  ;�ж�dl�����Ƿ�С�ڵ���9,
    		  ;��������������ֱ�Ӽ�30H���ASCII���Ӧ��ʮ������
    		  ;�����㣬���7֮���ټ�30H���ASCII���Ӧ��ʮ������
    
    jbe next1
    add dl,7
    next1:add dl,30h
    mov ah,2
    int 21h			;��ʾal�и�λ��ASCII��
    mov dl,bl		;�ָ�alֵ
    and dl,0fh		;dl�б����λ�������մ����λ����������ʾ��λ
    cmp dl,9
    jbe next2
    add dl,7
    
    next2:add dl,30h
    mov ah,2
    int 21h			;��ʾal�е�λ��ASCII��
    
    mov ah,4ch
    int 21h
CODES ENDS
    END START

