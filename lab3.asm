.MODEL small
.STACK 
.DATA
    num1 db ?
    num2 db ?
    suma db ?
    sumad db ?
    resta db ?
    producto db ?
    productod db ?
    cociente db ?
    residuo db ?
    numdece db ?
.CODE
programa:
    ; Inicializar el registro de datos
    MOV AX, @DATA
    MOV DX, AX
    
    XOR AX, AX
    ; Leer num1
    MOV AH, 01h
    INT 21h           ;El resultado queda en AL
    MOV num1, AL
    ; Leer num2 ya tenemos ah, con 01
    INT 21h
    MOV num2, AL
    
    ; Convertir numeros leidos en su representacion real
    SUB num1, 30h
    SUB num2, 30h
    
    ; imprimir un salto de linea antes de mostrar un resultado
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
    XOR AX, AX          ; limpiar los registros
    MOV AL,5
    MOV BL,2
    MUL BL ;AL = AL * BL
    MOV numdece, AL ;obtenemos valor 10
     ;---------------------------------------------SUMA-------------------------------------------
    XOR AX, AX          ; limpiar los registros
    MOV AL,num1
    ADD AL,num2
    ; Guardar los valores en variables antes de imprimir
    MOV suma, AL 
    ; Hacer una division
    XOR AX, AX          ; limpiar los registros
    MOV AL, suma
    DIV numdece
    ; Guardar los valores en variables antes de imprimir
    MOV sumad, al 
    MOV suma, ah
    ADD suma,30h
    ADD sumad,30h
    ; Imprimir  decena
    XOR AX, AX
    MOV AH, 02
    MOV DL, sumad
    INT 21h
    ; Imprimir unidad
    XOR AX, AX
    MOV AH, 02
    MOV DL, suma
    INT 21h
      ; imprimir un salto de linea antes de mostrar un resultado
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
     ;---------------------------------------------RESTA-------------------------------------------
    XOR AX, AX          ; limpiar los registros
    MOV AL,num1
    SUB AL,num2
    ; Guardar los valores en variables antes de imprimir
    MOV resta, AL 
    ADD resta,30h

    ; Imprimir unidad
    XOR AX, AX
    MOV AH, 02
    MOV DL, resta
    INT 21h
      ; imprimir un salto de linea antes de mostrar un resultado
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
       ;---------------------------------------------MULTIPLICACION-------------------------------------------
    XOR AX, AX          ; limpiar los registros
    MOV AL,num1
    MOV BL,num2
    MUL BL ;AL = AL * BL
    ; Guardar los valores en variables antes de imprimir
    MOV producto, AL 
    ; Hacer una division
    XOR AX, AX          ; limpiar los registros
    MOV AL, producto
    DIV numdece
    ; Guardar los valores en variables antes de imprimir
    MOV productod, al 
    MOV producto, ah
    ADD productod,30h
    ADD producto,30h
    ; Imprimir decena
    XOR AX, AX
    MOV AH, 02
    MOV DL, productod
    INT 21h
    ; Imprimir 
    XOR AX, AX
    MOV AH, 02
    MOV DL, producto
    INT 21h
      ; imprimir un salto de linea antes de mostrar un resultado
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
    ;---------------------------------------------DIVISION-------------------------------------------
    ; Hacer una division
    XOR AX, AX          ; limpiar los registros
    MOV AL, num1
    DIV num2
    ; Guardar los valores en variables antes de imprimir
    MOV cociente, al 
    MOV residuo, ah
    ; Agregar 30h para mostrar el numero real
    ADD cociente, 30h
    ADD residuo, 30h
    ; Imprimir 
    XOR AX, AX
    MOV AH, 02h
    MOV DL, cociente
    INT 21h
    ; imprimir un salto de linea antes de mostrar un resultado
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H
    ; imprimir residuo
    MOV DL, residuo
    INT 21h
    

    ; finalizar programa
    MOV AH, 4CH
    INT 21h
    ;------------------------------------------Walter OROZCO 1170917-----------------------------
END programa

