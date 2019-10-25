.MODEL small
.STACK
.DATA
    valorX  DB  88d
.CODE

Programa:
    MOV AX, @DATA
    MOV DS, AX
    JMP INICIO
    INICIO:
    XOR AX,AX
    MOV AH, 02
    MOV DL, valorX
    INT 21h ;imprimio X
    MOV AH, 01
    INT 21h
    cmp AL,0DH  ;valor de la tecla enter
    jne INICIO  ;Salta si es diferente a enter   
    FINALIZAR:
    MOV AH, 4Ch
    INT 21h
END Programa 