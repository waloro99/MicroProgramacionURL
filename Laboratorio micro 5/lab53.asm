.MODEL small
.STACK
.DATA
    mult10  DB  10d
    unidad  DB  ?
    decena  DB  ?
    unidad2  DB  ?
    decena2  DB  ?
    numero  DB  ?
    cont    DB  0h
.CODE

Programa:
    MOV AX, @DATA
    MOV DS, AX
    ;leer numeros
    XOR AX, AX
    MOV AH, 01h
    INT 21h
    MOV decena, AL
    INT 21h
    MOV unidad, AL
    ;convertirlos al valor real
    SUB decena, 30h
    SUB unidad, 30h
    XOR AX, AX          ; limpiar los registros
    MOV AL,decena
    MOV BL,mult10
    MUL BL ;AL = AL * BL
    MOV numero, AL 
    XOR AX, AX          ; limpiar los registros
    MOV AL,numero
    ADD AL,unidad
    MOV numero, AL 
    JMP FACTORES    
    
    FACTORES:
    MOV CL, numero
    CICLO:
    XOR AX,AX
    MOV AL,numero
    ADD AL,cont
    MOV cont, AL 
    CICLO2:
    XOR AX, AX          ; limpiar los registros
    MOV AL,cont
    MOV BL,CL
    MUL BL ;AL = AL * BL
    SUB AL,numero
    CMP AL,0
    JE IMPRIMIR
    CONT_CICLO2:   
    XOR AX,AX   ;segundo for
    MOV AL,cont
    SUB AL,1H
    MOV cont, AL
    CMP cont,0
    JG  CICLO2 
    LOOP CICLO  ;Fin del primer for
    JMP FINALIZAR;termina programa
    
    Imprimir:      
    MOV DL, 10 ; imprimir un salto de linea antes de mostrar un resultado
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
     ;Hacer una division
    XOR AX, AX          ; limpiar los registros
    MOV AL, cont
    DIV mult10
    ; Guardar los valores en variables antes de imprimir
    MOV decena2,AL
    MOV unidad2,AH
    ADD decena2,30h
    ADD unidad2,30h
    ; Imprimir decena
    XOR AX,AX
    MOV AH, 02
    MOV DL, decena2
    INT 21h
    ; Imprimir unidad
    XOR AX,AX
    MOV AH, 02
    MOV DL, unidad2
    INT 21h    
    JMP CONT_CICLO2
    ;finalizar
    finalizar:
    MOV AH, 4Ch
    INT 21h
END Programa 