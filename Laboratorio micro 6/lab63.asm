.MODEL small
.STACK
.DATA
    vec    DB   50 dup(' '), '$' 
    vec2   DB   50 dup(' '), '$' 
    msjsi  DB  'Si es palindromo $'
    msjno  DB  'No es palindromo $'
    cadena DB   'Palabra: $'
    cont   DB 0
.CODE
PROGRAMAR:
  MOV AX,@data
  MOV DS,AX
  MOV ah,09
  MOV DX,offset cadena  
  INT 21h
  LEA SI,vec  ;cadena
  p_cadena1:
  XOR AX,AX
  MOV AL,cont
  ADD AL,1d
  MOV cont,AL
  XOR AX,AX
  MOV AH,01h  
  INT 21h
  MOV [si],AL 
  MOV AH,AL
  PUSH AX
  INC si
  CMP AH,0DH  ;ENTER
  JA p_cadena1;SI ES MAYOR
  JB p_cadena1;SI ES MENOR
  MOV DL, 10    ;salto de linea
  MOV AH, 02
  INT 21h
  MOV DL, 13
  INT 21H
  CALL LLENAR2
  CALL  PALINDROMO
  
  PALINDROMO PROC NEAR
  MOV cx,50   ;CICLO 50
  MOV AX,DS  
  MOV ES,AX  

  comparar: 
  LEA si,vec  
  LEA di,vec2 
  REPE CMPSB 
  JNE NO_PALINDROMO ;DIFERENTES
  jE SI_PALINDROMO ;IGUALES
  
  RET
  PALINDROMO ENDP
  
  LLENAR2 PROC NEAR
  MOV CL,cont
  LEA SI,vec2 
  p_cadena2:    
  POP BX
  MOV [si],BH
  INC SI
  DEC DI
  loop p_cadena2 
  RET
  LLENAR2 ENDP
  
  SI_PALINDROMO:
  MOV ah,09
  MOV DX,offset msjsi
  INT 21h
  JMP finalizar
  
  NO_PALINDROMO:
  MOV ah,09
  MOV DX,offset msjno
  INT 21h
  JMP finalizar
  
  FINALIZAR:
  MOV AH, 4CH
  INT 21H
END PROGRAMAR