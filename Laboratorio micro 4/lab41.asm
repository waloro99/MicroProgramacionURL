.MODEL small
.STACK
.DATA
    num db ?
    espar db 'El numero es par$'
    noespar db 'El numero no es par$'
    residuo db ?
.CODE
programa:
    MOV AX,@DATA
    MOV DS,AX
    
    ;leer num 
    XOR AX,AX
    MOv AH, 01h ;queda guardado en AL
    INT 21h
    MOV num,AL
    SUB num,30h ;valor real
    
    ;COMPARAR SI ES PAR
    XOR AX,AX
    MOV AL,num
    MOV CL,2 ;podemos usar cualquier BL por ejemplo o 2h por 2 que es lo mismo en hexa que en deci
    DIV CL
    ;residup en ah
    MOV residuo, AH
    ;comparar
    CMP residuo,0
    JZ imprimirespar;o JE es lo mismo
    
    imprimiresimpar:
    MOV DX, offset noespar
    MOV AH,09h
    INT 21h
    JMP finalizar
    
    
    imprimirespar:
    MOV DX, offset espar
    MOV AH, 09h
    INT 21h

    
    
    finalizar:
    ;finalizar
    MOV AH,4ch
    INT 21h

end programa