.MODEL small
.STACK
.DATA
    mult10  DB  10d
    div2    DB  2d
    unidad  DB  ?
    decena  DB  ?
    numero  DB  ?
    cero    DB  48d
    uno     DB  49d
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
    MOV DL, 10 ; imprimir un salto de linea antes de mostrar un resultado
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H ;---
    XOR AX, AX          ; limpiar los registros
    MOV AL,decena
    MOV BL,mult10
    MUL BL ;AL = AL * BL
    MOV numero, AL 
    XOR AX, AX          ; limpiar los registros
    MOV AL,numero
    ADD AL,unidad
    MOV numero, AL 
    CMP numero,0
    JE  CASO_ESPECIAL ;si es igual a cero lo envia a finalizar
    WHILE_ASM:
    XOR AX, AX          ; limpiar los registros
    MOV AL, numero
    DIV div2            ;hacemos %2
    CMP AH,0
    JE  IMPRIMIR_CERO
    JMP IMPRIMIR_UNO
    CONDICION_WHILE:
    XOR AX, AX          ; limpiar los registros
    MOV AL, numero
    DIV div2
    MOV numero,AL       ;para finalizar el ciclo se hace la division
    CMP numero,0
    JG WHILE_ASM ;si es mayor a cero
    JMP FINALIZAR ;finaliza el programa
    CASO_ESPECIAL:
    XOR AX,AX
    MOV AH, 02
    MOV DL, cero
    INT 21h
    JMP FINALIZAR
    IMPRIMIR_CERO:
    XOR AX,AX
    MOV AH, 02
    MOV DL, cero
    INT 21h
    JMP CONDICION_WHILE
    IMPRIMIR_UNO:
    XOR AX,AX
    MOV AH, 02
    MOV DL, uno
    INT 21h
    JMP CONDICION_WHILE
    ;finalizar
    finalizar:
    MOV AH, 4Ch
    INT 21h
END Programa 