.MODEL small
.STACK
.DATA
    cadena  DB  ?
.CODE
PROGRAMAR:
    MOV AX,@DATA
    MOV DS,AX
    
    XOR SI, SI  ;limpiar indice
    LEA SI, cadena 
    CALL GUARDARCADENA
    MOV CX,SI ;ciclo que imprima letrar por 
    MOV SI, 0 ;inicialize en la posicion 0
    IMPRIMIRCADENA:
    MOV AL, [SI] ;pasamos el valor del caracter a registro
    MOV AH, 02H
    inc SI  ;incrementamos en 1 la posicion del arreglo
    MOV DL, AL ;imprimimos caracter
    INT 21H
    LOOP IMPRIMIRCADENA ;fin del bucle
    
    FINALIZAR:
    MOV AH, 4CH
    INT 21H
    
    LEERCARACTER PROC NEAR
    XOR AX, AX
    MOV AH, 01h
    INT 21h
    RET
    LEERCARACTER ENDP
    
    GUARDARCADENA PROC NEAR
    LEERCADENA:
    CALL LEERCARACTER    
    CMP AL, 0DH ;compara si fue enter
    JE  TERMINARCADENA
    CMP AL, 5AH ;compara que sea igual o menor al valor de Z
    JLE GUARDARCARACTER
    SUB AL,20H
    GUARDARCARACTER:
    MOV [SI], AL ;Guarda el valor de AL en la posicion
    INC SI ;incrementa la posicion
    JMP LEERCADENA
    
    TERMINARCADENA:
    INC SI
    MOV [SI], 24H ;se agrega el signo $ para significar fin de la cadena
    RET
    GUARDARCADENA ENDP
    
END PROGRAMAR