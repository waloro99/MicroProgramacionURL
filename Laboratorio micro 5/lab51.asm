.MODEL small
.STACK
.DATA
    num1 DB ?
    num2 DB ?
    div10 DB 10d
    unidad DB ?
    decena DB ?
.CODE

Programa:
    MOV AX, @DATA
    MOV DS, AX
    ;leer numeros
    XOR AX, AX
    MOV AH, 01h
    INT 21h
    MOV num1, AL
    INT 21h
    MOV num2, AL
    ;convertirlos al valor real
    SUB num1, 30h
    SUB num2, 30h
    ;preparar valores para el ciclo
    MOV CL, num2
    
    Multiplicar:
        ADD BL , num1
        LOOP multiplicar
     ; Hacer una division
    XOR AX, AX          ; limpiar los registros
    MOV AL, BL
    DIV div10
    ; Guardar los valores en variables antes de imprimir
    MOV decena,AL
    MOV unidad,AH
    ADD decena,30h
    ADD unidad,30h
    ; imprimir un salto de linea antes de mostrar un resultado
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
    ; Imprimir decena
    XOR AX,AX
    MOV AH, 02
    MOV DL, decena
    INT 21h
    ; Imprimir unidad
    XOR AX,AX
    MOV AH, 02
    MOV DL, unidad
    INT 21h    
    ;finalizar
    finalizar:
    MOV AH, 4Ch
    INT 21h
END Programa 