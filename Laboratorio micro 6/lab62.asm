.MODEL small
.STACK
.DATA
    msjcadena   DB  'Cadena1: $'
    msjcadena2  DB  'Cadena2: $'
    igual DB  'Las palabras son iguales$'
    diferente DB  'Las palabras son diferentes$'
    vec db 50 dup(' '), '$'  
    vec2 db 50 dup(' '), '$'  
.CODE
PROGRAMAR:
  MOV AX,@data
  MOV DS,AX
  MOV ah,09
  MOV DX,offset msjcadena  
  INT 21h
 
  LEA SI,vec  
  p_cadena1:
  MOV AH,01h  
  INT 21h
  MOV [si],AL  
  INC si
  CMP AL,0DH  ;ENTER
  JA p_cadena1;SI ES MAYOR
  JB p_cadena1;SI ES MENOR
  MOV DL, 10    ;salto de linea
  MOV AH, 02
  INT 21h
  MOV DL, 13
  INT 21H
  MOV ah,09  
  MOV DX,offset msjcadena2 
  INT 21h
  
  LEA SI,vec2  
  p_cadena2:    
  MOV ah,01h
  INT 21h
  MOV [si],AL
  INC si
  CMP AL,0DH    ;ENTER
  JA p_cadena2
  JB p_cadena2
  
  MOV cx,50   ;CICLO 50
  MOV AX,DS  
  MOV ES,AX  

  comparar: 
  LEA si,vec  
  LEA di,vec2 
  REPE CMPSB 
  JNE diferentes ;DIFERENTES
  jE iguales ;IGUALES
 
  iguales:
  MOV DL, 10    ;salto de linea
  MOV AH, 02
  INT 21h
  MOV DL, 13
  INT 21H
  MOV ah,09 
  MOV ah,09
  MOV dx,offset igual
  INT 21h
  MOV ah,04ch
  INT 21h
  JMP finalizar

  diferentes:
  MOV DL, 10    ;salto de linea
  MOV AH, 02
  INT 21h
  MOV DL, 13
  INT 21H
  MOV ah,09 
  MOV ah,09
  MOV dx,offset diferente
  INT 21h
  MOV ah,04ch
  INT 21h
  JMP finalizar
     
  FINALIZAR:
  MOV AH, 4CH
  INT 21H

END PROGRAMAR