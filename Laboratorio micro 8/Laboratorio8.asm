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

;segemento de datos
.DATA
mNum1 DB "Ingresar el numero para hacer el factorial: ",0
num1 DB ?,0
res DB ?,0
unidad DB ?,0
decena DB ?,0
centena DB ?,0
div100 DB 100d,0
div10 DB 10d,0
.CODE
programa:
	INVOKE StdOut, addr mNum1	; imprimir cadena
	INVOKE StdIn, addr num1,16	; leer num1
	SUB num1,30h
	CMP num1,0
	JE CasoCero ;si el numero ingresado es cero
	JMP FactorialTotal ;si es cualquier otro numero distinto de cero

	FactorialTotal:
	MOV AL,num1
	MOV res,AL
	SUB num1,AL
	ADD num1,1h
	ciclo:
	XOR AX,AX ;limpiar registros
	MOV AL,num1
	MOV BL,res
	MUL BL; AL = AL * BL
	MOV num1, AL ;Guarda el resultado
	SUB res,1h
	CMP res,0
	JE Imprimir
	JMP ciclo

	Imprimir:
	XOR AX,AX ;limpiar los registros
	MOV AL,num1
	DIV div100
	MOV decena,AH
	MOV centena,AL
	XOR AX,AX ;limpiar los registros
	MOV AL,decena
	DIV div10
	MOV unidad,AH
	MOV decena,AL
	ADD unidad,30h
	ADD decena,30h
	ADD centena,30h
	INVOKE StdOut, addr centena ;invocacmos el numero a mostrar
	INVOKE StdOut, addr decena ;invocacmos el numero a mostrar
	INVOKE StdOut, addr unidad ;invocacmos el numero a mostrar
	JMP Finalizar ;salta para finalizar el programa


	CasoCero:
	; imprimir cadena
	ADD num1,31h ;se le muestra al usuario el num 1
	INVOKE StdOut, addr num1 ;invocacmos el numero a mostrar


	Finalizar:
	; finalizar
	INVOKE ExitProcess,0

END programa