.MODEL small
.STACK
.DATA
    num         dw 0000 ;65535 ;variable donde se guarda el numero de 16 bits
    txt_ingreso db 'Ingrese el numero que desea invertir(max 16 bits): $'
    txt_res     db 'El resultado es: $'
    res         dw 0 ;variable donde se queda guardado el numero invertido
    sobra       dw 0 ;variable donde se quede guardado lo que sobra de mod
    ;variables que se usara en la division
    diez        dw 10d
.CODE
programa:
    MOV AX,@DATA
    MOV DS,AX
    
    ;imprimir cadena inicio
    XOR AX, AX
    MOV AH, 09
    LEA DX, txt_ingreso
    INT 21h
   ;imprimir un salto de linea 
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H  
    JMP LEER_NUM 
    ;-------------------------Lee numero a invertir---------------------
    LEER_NUM:
    MOV AH,01H
    INT 21H
    CMP AL,'0'
    JB ENTER_NUM
    CMP AL, '9'
    JA LEER_NUM
    SUB AL,48
    MOV BH,0
    MOV BL,AL
    MOV AX,[num]
    MOV CX,10
    MUL CX
    ADD AX,BX
    MOV [num],AX
    JMP LEER_NUM
    ENTER_NUM:
    CMP AL,13
    JNE LEER_NUM
    ;imprimir un salto de linea 
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H  
    JMP MAYOR_CERO
    
    ;--------------------------Inicia procesos para invertir num----------------
    MAYOR_CERO:
    XOR AX,AX
    CMP num,0
    JE MANDAR_IMPRIMIR
    JMP PROCESO_DIV
    
    PROCESO_DIV:
    XOR AX,AX ;division
    XOR CX,CX
    MOV DX, 0
    MOV AX,num
    MOV CX, 0
    MOV CX,diez
    DIV CX
    MOV num,AX
    MOV sobra,DX
    JMP INVERTIR
    
    INVERTIR:
    XOR AX,AX ;  multiplicacion
    MOV AX,res
    MUL diez
    ADD AX,sobra
    MOV res,AX
    JMP MAYOR_CERO
        
    ;-------------------------INICIA IMPRESION DE RESULTADO----------------
    
    MANDAR_IMPRIMIR:
    ;imprimir cadena 
    XOR AX, AX
    MOV AH, 09
    LEA DX, txt_res
    INT 21h
   ;imprimir un salto de linea 
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H  
    JMP IMPRIMIR_RES
    
    ;----------------------Se imprime la variable con el numero invertido-------------
    
    
    IMPRIMIR_RES:
    XOR AX,AX
    MOV DX,0
    MOV AX,[res]
    MOV BP,SP
        
    NUMEROCOMPLETO:
    MOV CX,10
    DIV CX
    MOV CX,DX
    PUSH CX
    MOV [res],AX
    MOV DX,0
    CMP AX,0
    JNE NUMEROCOMPLETO
    
    IMPRIMIR_NUM:
    CMP BP,SP
    JE FINALIZAR
    POP DX
    ADD DX,48
    MOV AH,02H
    INT 21H
    JMP IMPRIMIR_NUM
    
    ;------------------------Finaliza programa----------------------------------
    
    FINALIZAR:
    ;finalizar
    MOV AH,4ch
    INT 21h

end programa