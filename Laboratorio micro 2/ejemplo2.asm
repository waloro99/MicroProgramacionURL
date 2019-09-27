.model small
.STACK
.CODE
programa:
	MOV AX, @DATA
	MOV DS, AX
	MOV AX, 0000h
	MOV BX, 0000h
	MOV AL, 15h
	MOV BL, 15h
	ADD AL,BL
	MOV CL,30h
	ADD AL,CL
	MOV DL,AL
	MOV AH,02
	INT 21h
	MOV AH,4CH
	INT 21h
END Programa