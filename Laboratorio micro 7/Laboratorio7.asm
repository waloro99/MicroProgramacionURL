.386
.model flat, stdcall
option casemap:none
; Includes
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\masm32rt.inc 
; librerias
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
; Segmento de Datos
.DATA  
mNum1 DB "Ingrese primer Numero: ",0
mNum2 DB "Ingrese segundo Numero: ",0
suma DB "Suma: ",0
resta DB "	Resta: ",0
mayor DB "	El primer numero es mayor ",0
menor DB "	El Segundo numero es mayor ",0
igual DB "	Son numeros iguales ",0
num1 DB ?,0
num2 DB ?,0
res DB ?,0
unidad DB ?,0
decena DB ?,0
div10 DB 10d,0
menos DB 45d,0

; codigo
.CODE 
 
programa:
main PROC
	; imprimir cadena
	INVOKE StdOut, addr mNum1
	; leer num1
	INVOKE StdIn, addr num1,16
	SUB num1,30h
	; imprimir cadena2
	INVOKE StdOut, addr mNum2
	; leer num2
	INVOKE StdIn, addr num2,16
	SUB num2,30h
	; imprimir Suma
	INVOKE StdOut, addr suma
	MOV AL,num1
	MOV res,AL
	MOV BL,num2
	ADD res,BL
	XOR AX,AX ;poner numero de dos cifras
	MOV AL,res
	DIV div10
	MOV unidad,AH
	MOV decena,AL
	ADD unidad,30h
	ADD decena,30h
	; imprimir num
	INVOKE StdOut, addr decena
	INVOKE StdOut, addr unidad
	; imprimir Resta
	INVOKE StdOut, addr resta
	XOR AX,AX
	MOV AL,num1
	MOV res,AL
	MOV BL,num2
	SUB res,BL
	CMP res,0
	JL NEGATIVO
	ADD res,30h
	; imprimir num
	INVOKE StdOut, addr res
	JMP COMPARAR
	NEGATIVO:
	;imprimir numero negativo resta
	XOR AX,AX
	MOV AL,num2
	MOV res,AL
	MOV BL,num1
	SUB res,BL
	ADD res,30h
	INVOKE StdOut, addr menos
	INVOKE StdOut, addr res
	COMPARAR:
	;------comparar numeros
	XOR AX,AX
	MOV AL,num2
	SUB num1,AL
	CMP num1,0
	JG MAYOR;Salta si es mayor
	JL MENOR;Salta si es menor
	JE IGUAL;Salta si es igual

	MENOR:
	; imprimir Menor
	INVOKE StdOut, addr menor
	JMP FINALIZAR
	MAYOR:
	; imprimir mayor
	INVOKE StdOut, addr mayor
	JMP FINALIZAR
	IGUAL:
	; imprimir igual
	INVOKE StdOut, addr igual
	JMP FINALIZAR
	
	FINALIZAR:
	; finalizar
	INVOKE ExitProcess,0
	main ENDP
END programa