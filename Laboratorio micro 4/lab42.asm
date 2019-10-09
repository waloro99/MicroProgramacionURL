.MODEL small
.STACK
.DATA
    num1 db ?
    num2 db ?
    mayorprimero db 'El primer numero es mayor$'
    mayorsegundo db 'El segundo numero es mayor$'
    iguales db  'Los numeros son iguales$'
    resta db ?
.CODE
programa:
    MOV AX,@DATA
    MOV DS,AX
    ;leer num1
    XOR AX,AX
    MOv AH, 01h ;queda guardado en AL
    INT 21h
    MOV num1,AL
    SUB num1,30h ;valor real
    ;leer num2 
    XOR AX,AX
    MOv AH, 01h ;queda guardado en AL
    INT 21h
    MOV num2,AL
    SUB num2,30h ;valor real
    ;resta
    XOR AX, AX          ; limpiar los registros
    MOV AL,num1
    SUB AL,num2
    ; Guardar los valores en variables antes de imprimir
    MOV resta, AL 
   
    ;comparar
    CMP resta,0
    JG imprimirmayor1
    JE imprimiriguales
    
    imprimirmayor2:
    MOV DX, offset mayorsegundo
    MOV AH,09h
    INT 21h
    JMP finalizar
    
    imprimiriguales:
    MOV DX, offset iguales
    MOV AH,09h
    INT 21h
    JMP finalizar
    
    imprimirmayor1:
    MOV DX, offset mayorprimero
    MOV AH, 09h
    INT 21h

    
    
    finalizar:
    ;finalizar
    MOV AH,4ch
    INT 21h

end programa