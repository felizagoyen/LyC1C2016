;macros2.asm
;These are macros for Assembly Language Programming
;Myron Berg
;Dickinson State University
;4/5/99


;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
getString                    macro  string        ;read string from keyboard
local  label1, label2, label3, label4, label5, label6, label7, label8

                        pushad
                        push    di
                        push    si
                      

                        lea    si, string
                        mov    bx, si

label1:                mov    ah, 1
                        int    21h
                        cmp    al, 0Dh
                        je      label2

                        cmp    al, 8
                        je      label8
                        jmp    label7

label8:                dec    si
                        cmp    si, bx
                        jl      label6
                      jmp    label1

label6:                mov    si, bx
                        jmp    label1
                        

label7:                mov    [si], al
                        inc    si
                        jmp    label1
label2:                mov    byte ptr [si], '$'

                        pop    si
                        pop    di
                        popad

endm    

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
displayString                  macro  string          ;write string on screen

                        push    dx
                        push    ax

                        lea    dx, string
                        mov    ah, 9
                        int    21h

                        pop    ax
                        pop    dx

endm

STRCPY MACRO
LOCAL @@OK
      STRLEN
      CMP BX, 31
      JLE @@OK
      MOV BX, 31
@@OK:
      MOV CX, BX
      CLD
      REP MOVSB
      MOV AL, '$'
      MOV BYTE PTR[DI], AL
ENDM

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

STRLEN MACRO
LOCAL @@STRL01, @@STREND
      ;DEJA EN BX LA CANTIDAD DE CARACTERES DE UNA CADENA
      MOV BX, 0
@@STRL01:
      CMP BYTE PTR[SI + BX], '$'
      JE @@STREND
      INC BX
      JMP @@STRL01
@@STREND:
      NOP
ENDM  
  
STRCAT MACRO
LOCAL @@CONCATSIZEMAL, @@CONCATSIZEOK, @@CONCATSIGO
      PUSH DS
      PUSH SI
      STRLEN
      MOV DX, BX
      MOV SI, DI
      PUSH ES
      POP DS
      STRLEN
      ADD DI, BX
      ADD BX, DX
      CMP BX, 31
      JG @@CONCATSIZEMAL
@@CONCATSIZEOK:
      MOV CX, DX
      JMP @@CONCATSIGO
@@CONCATSIZEMAL:
      SUB BX, 31
      SUB DX, BX
      MOV CX, DX
@@CONCATSIGO:
      PUSH DS
      POP ES
      POP SI
      POP DS
      CLD
      REP MOVSB
      MOV AL,'$'
      MOV BYTE PTR [DI], AL
ENDM
 
STRCMP MACRO
LOCAL @@CICLO, @@NOTEQUAL, @@BYE
    DEC DI

@@CICLO:
    INC DI              ;DS:DI -> SIGUIENTE CHAR EN CAD2
    LODSB               ;CARGA AL CON EL SIGUIENTE CHAR DE CAD1
    CMP [DI], AL  ;COMPARA CHARS
    JNE @@NOTEQUAL      ;SALTA DEL LOOP SI NO SON LOS MISMOS
    CMP AL, '$'   ;SON LOS MISMOS, VERIFICA EOF
    JNE @@CICLO         ;NO ES EOF, PASA A LOS SIGUIENTES

    MOV BL, 0
      TEST BL, BL
    JMP @@BYE           ;LOS STRING SON IGUALES (ZF = 1)
@@NOTEQUAL:
    MOV BL, 1           ;LOS STRING NO SON IGUALES (ZF = 0)
      TEST BL, BL
@@BYE:
      NOP
ENDM   