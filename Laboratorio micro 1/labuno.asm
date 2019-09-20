.MODEL small
.DATA
nombre DB 'Nombre: Walter fuentes$'
carnet DB 'Carnet: 1170917$'
msn DB 'El símbolo escogido es:”$'
.STACK
.CODE
Programa:

MOV AX, @Data 
MOV DS, AX

;imprimir cadena
MOV DX, OFFSET nombre
MOV AH, 09h		; decimos que se imprima una cadena
INT 21h	
MOV DX, OFFSET carnet
MOV AH, 09h
INT 21h			; ejecuta la interrupcion 
MOV DX, OFFSET msn
MOV AH, 09h
INT 21h			; ejecuta la interrupcion 
mov AH,0eh 		;imprimir un caracter
mov AL,40		;caracter en codigo ascii pero numero hexadecimal
int 21h			; ejecuta la interrupcion

;finalizar programa 
MOV AH, 4ch
INT 21h  ;ejecutar la interrupcion
END Programa 