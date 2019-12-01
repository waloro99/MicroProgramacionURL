mWrite MACRO text
LOCAL string ;; local label
.data
string BYTE text,0 ;; define the string
.code
push edx
mov edx,OFFSET string
call WriteString
pop edx
ENDM
;--------------------------- FIN MACROS -------------------------------------
.386
.model flat, stdcall
option casemap:none
; Includes
;include \masm32\include\windows.inc
;include \masm32\include\kernel32.inc
;include \masm32\include\user32.inc
include \masm32\include\masm32.inc
;include \masm32\include\masm32rt.inc ;LIB para fecha y hora
; librerias
;includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
;includelib \masm32\lib\user32.lib
INCLUDE Irvine32.inc

BUFFER_SIZE = 501
; Segmento de Datos
.DATA  
msj_SalidaVisualizar DB "Para salir precione Enter-",0
msj_Error1 DB "error archivop",0
opcMenu DB ?,0
;-------------------------------------------
;buffer BYTE BUFFER_SIZE DUP(?)
buffer2 BYTE BUFFER_SIZE DUP(?)
buffer3 BYTE BUFFER_SIZE DUP(?)
filename2 BYTE 80 DUP(0)
fileHandle2 HANDLE ?
filename BYTE "micro.txt",0
fileHandle HANDLE ?
stringLength DWORD ?
;tamaño1 DWORD ?
bytesWritten DWORD ?
str1 BYTE "No se creo el archivo",0dh,0ah,0
str2 BYTE "		Bytes escritos en el archivo [SalidaMicro.txt]:",0
str3 BYTE "Ingrese lo que desea visualizar: "
 BYTE "[Enter]: ",0dh,0ah,0
temp DWORD ?
temp2 DWORD ?
contColor db 1,0
contPalabra db 0,0
contPalabra2 db 0,0
contRpalabra db ?,0
contPalabraXY db 0,0


.DATA?

; codigo	
.CODE 
programa:	
	BuscarPalabra:
	INVOKE ClearScreen
	;_________________________________LEE EL ARCHIVO_____________________
	mWrite <"El archivo debe estar dentro de la solucion (ejemplo: prueba.txt)",0dh,0ah>
	mWrite "Ingresa el nombre del archivo donde desea buscar: "
	mov edx,OFFSET filename2
	mov ecx,SIZEOF filename2
	call ReadString
	; Open the file for input.
	mov edx,OFFSET filename2
	call OpenInputFile
	mov fileHandle2,eax
	; Check for errors.
	cmp eax,INVALID_HANDLE_VALUE ; error al abrir
	jne file_ok2 ; no: skip
	mWrite <"No se encontro el archivo.",0dh,0ah>
	jmp Finalizar ; 
	file_ok2:
	; lee el buffer del archivo
	mov edx,OFFSET buffer2
	mov ecx,BUFFER_SIZE
	call ReadFromFile
	jnc check_buffer_size ; error leyendo?
	mWrite "Error al leer archivo. " ; si
	call WriteWindowsMsg
	jmp close_file
	check_buffer_size:
	cmp eax,BUFFER_SIZE ; buffer tamaño
	jb buf_size_ok ; si
	mWrite <"Error: Buffer pequeño tamaño archivo",0dh,0ah>
	jmp Finalizar ; 
	buf_size_ok:
	mov buffer2[eax],0 
	mWrite "Bites del archivo: "
	call WriteDec 
	call Crlf
	mWrite <"Texto:",0dh,0ah,0dh,0ah> ;salto de lineas 0dh
	mov edx,OFFSET buffer2
	;call COLOR_AMARRILLO
	call WriteString
	call Crlf
	close_file:
	mov eax,fileHandle2
	call CloseFile
	;_________________________________PEDIR PALABRA_____________________
	mWrite <"Ingrese la PALABRA CLAVE: ",0dh,0ah>
	mov edx,OFFSET buffer3
	mov ecx,SIZEOF buffer3
	call ReadString
	JMP IMPRIMIR

	IMPRIMIR:
	XOR ESI, ESI
	XOR EDI, EDI
	XOR EBX, EBX
	XOR EAX, EAX ;limpiando todos los registros
	MOV EDI, OFFSET buffer2 ;guardo en el registro el texto 
	JMP COMPARAR ;inicia proceso de comparar palabras
	
	;----------------------------------- GENERA CARACTER DE TODO EL TEXTO -------------------
	COMPARAR:
	MOVZX EAX, BYTE PTR [EDI]
	MOV temp, EAX ;CMP temp,44 ;encuentra coma ','
	CMP temp,32 ;encuentra espacio ' '
	JE iguales;
	CMP temp,13 ;encuentra enter ' '
	JE Finalizar 
	INC EDI
	INC contPalabra
	JMP COMPARAR

	;---------------------------------PONER PALABRA QUE EL USUARIO INGRESO -------------
	PalabrasComparadas:
	LEA ESI, OFFSET buffer3 ;guardo en el registro las palabras a buscar
	Bucle_PalabrasComparadas:
	MOVZX EBX, BYTE PTR [ESI]
	MOV temp2, EBX
	CMP temp2,32 ;encuentra espacio ' '
	JE CompararCaracterXCaracter
	INC ESI
	INC contPalabra2
	JMP Bucle_PalabrasComparadas
	;PalabrasComparadas:
	;
	;MOVZX EBX, BYTE PTR [ESI]
	;MOV temp2, EBX
	;CMP temp2,32 ;encuentra espacio ' '
	;JE Finalizar
	;ContinuarEnter2:
	;mov edx,OFFSET temp2
	;call WriteString
	;INC ESI
	;JMP PalabrasComparadas
;
	;SumaEnter2:
	;ADD contEnter,1
	;CMP contEnter,1
	;JA Finalizar ;salta si hay mas de un enter
	;JMP ContinuarEnter2 ;sino continua normal termino una palabra

	;-----------------------------------COMPARAR TODAS LAS PALABRAS ---------------------

	CompararCaracterXCaracter:
	CALL RegresarCaracteres
	LEA ESI, OFFSET buffer3 
	MOV BL,contPalabra2
	JMP comparando_cadenas
	comparando_cadenas2:
	INC EDI
	INC ESI
	comparando_cadenas:
	MOVZX EAX, BYTE PTR [EDI]
	MOV temp, EAX
	MOVZX EBX, BYTE PTR [ESI]
	MOV temp2, EBX
	CMP temp,EBX
	JE resto_var
	JMP EliminarResiduo
	resto_var:
	SUB BL,1
	CMP BL,0
	JE EliminarResiduoIguales
	JMP comparando_cadenas2
	EliminarResiduoIguales:
	CMP contPalabra2,BL
	JE iguales
	DEC EDI
	DEC contPalabra2
	JMP EliminarResiduoIguales
	EliminarResiduo:
	CMP contPalabra2,BL
	JE CicloNoPalabraEncontrada
	DEC EDI
	DEC contPalabra2
	JMP EliminarResiduo

	;CompararCaracterXCaracter:
	;CALL ValorPalabraBuscada	
	;CALL RegresarCaracteres
	;
	;MOV CL, contPalabra
	;JMP COMPARANDO_CARACTERES2
	;incrementar_Var:
	;INC EDI
	;jmp finloop
	;COMPARANDO_CARACTERES: 
	;INC EDI
	;INC contPalabraXY
	;INC ESI
	;dec contPalabra2
	;COMPARANDO_CARACTERES2:
	;MOVZX EAX, BYTE PTR [EDI]
	;MOV temp, EAX
	;MOVZX EBX, BYTE PTR [ESI]
	;MOV temp2, EBX
	;CMP temp,EBX
	;JE COMPARANDO_CARACTERES
	;finloop:
	;loop incrementar_Var
	;CMP contPalabra2,0
	;JE iguales
	;JMP CicloNoPalabraEncontrada

	iguales:
	CALL RegresarCaracteres;CALL RegresarCaracteresComparados
	INC contColor
	IMPRIMIR_ENCONTRADO2:
	MOVZX EAX, BYTE PTR [EDI]
	MOV temp, EAX
	mov edx,OFFSET temp	
	call DECIDIR_COLOR
	call WriteString
	INC EDI
	DEC contPalabra
	CMP contPalabra,0
	JA IMPRIMIR_ENCONTRADO2 ;repite el ciclo hasta terminar la palabra
	mWrite " "
	INC EDI
	JMP COMPARAR ;regresa a leer letra

	;---------------------------------- SE ENCONTRO UNA PALABRA SE VUELVE A CARGAR-------

	CicloNoPalabraEncontrada:
	;CALL RegresarCaracteres;CALL RegresarCaracteres
	IMPRIMIR_ENCONTRADO:
	MOVZX EAX, BYTE PTR [EDI]
	MOV temp, EAX
	mov edx,OFFSET temp
	caLL COLOR_BLANCO
	call WriteString
	INC EDI
	DEC contPalabra
	CMP contPalabra,0
	JA IMPRIMIR_ENCONTRADO ;repite el ciclo hasta terminar la palabra
	mWrite " "
	INC EDI
	JMP COMPARAR ;regresa a leer letra

	

	;------------------------------ PROCEDIMIENTOS ---------------------------------

	COLOR_BLANCO PROC NEAR ;0
	mov eax,white +(black*16)
	call SetTextColor
	RET
	COLOR_BLANCO ENDP

	COLOR_AMARRILLO PROC NEAR ;1
	mov eax,yellow +(black*16)
	call SetTextColor
	RET
	COLOR_AMARRILLO ENDP

	COLOR_CAFE PROC NEAR ;2
	mov eax,brown +(black*16)
	call SetTextColor
	RET
	COLOR_CAFE ENDP

	COLOR_AZUL PROC NEAR ;3
	mov eax,blue +(black*16)
	call SetTextColor
	RET
	COLOR_AZUL ENDP

	COLOR_VERDE PROC NEAR ;4
	mov eax,green +(black*16)
	call SetTextColor
	RET
	COLOR_VERDE ENDP

	COLOR_ROJO PROC NEAR ;5
	mov eax,red +(black*16)
	call SetTextColor
	RET
	COLOR_ROJO ENDP

	COLOR_MORADO PROC NEAR ;6
	mov eax,magenta +(black*16)
	call SetTextColor
	RET
	COLOR_MORADO ENDP

	DECIDIR_COLOR PROC NEAR
	MOV AL,contColor
	CMP AL,0
	JE AMARRILLO
	CMP AL,1
	JE CAFE
	CMP AL,2
	JE AZUL
	CMP AL,3
	JE VERDE
	CMP AL,4
	JE ROJO
	CMP AL,6
	JE REINICIARCONTCOLOR
	JMP MORADO
	BLANCO:
	CALL COLOR_BLANCO
	JMP FIN_DECIDIR
	AMARRILLO:
	CALL COLOR_AMARRILLO
	JMP FIN_DECIDIR
	CAFE:
	CALL COLOR_CAFE
	JMP FIN_DECIDIR
	AZUL:
	CALL COLOR_AZUL
	JMP FIN_DECIDIR
	VERDE:
	CALL COLOR_VERDE
	JMP FIN_DECIDIR
	ROJO:
	CALL COLOR_ROJO
	JMP FIN_DECIDIR
	MORADO:
	CALL COLOR_MORADO
	JMP FIN_DECIDIR
	REINICIARCONTCOLOR:
	MOV contColor,0
	JMP DECIDIR_COLOR

	FIN_DECIDIR:
	RET
	DECIDIR_COLOR ENDP

	RegresarCaracteres PROC NEAR
	MOV BL,contPalabra
	MOV contRpalabra,BL
	ciclo_retorno:
	DEC EDI
	SUB contRpalabra,1
	CMP contRpalabra,0
	JA ciclo_retorno
	RET
	RegresarCaracteres ENDP

	ValorPalabraBuscada PROC NEAR
	LEA ESI, OFFSET buffer3 ;guardo en el registro las palabras a buscar
	CONTINUAR_VIENDO:
	MOVZX EBX, BYTE PTR [ESI]
	MOV temp2, EBX
	CMP temp2,32 ;encuentra espacio ' '
	JE Finalizar
	ADD contPalabra2,1
	RET
	ValorPalabraBuscada ENDP

	RegresarCaracteresComparados PROC NEAR
	ciclo_retorno2:
	DEC EDI
	SUB contPalabraXY,1
	CMP contPalabraXY,0
	JA ciclo_retorno2
	RET
	RegresarCaracteresComparados ENDP

	;--------------------------- Finalizar programa ---------------------------

	Finalizar:
	; finalizar
	call COLOR_BLANCO
	INVOKE ExitProcess,0

END programa

;xor edi,edi
	;mov edx,OFFSET buffer3
	;call COLOR_CAFE
	;call WriteString