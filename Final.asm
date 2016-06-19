include macros2.asm
include number.asm

.MODEL 	LARGE
.386
.STACK 	200h

.DATA

	STRINGMAXLENGTH 	equ 31
	@NEWLINE 	db 0Dh,0Ah,'$'

	a 	dd ?
	b 	dd ?
	c 	db STRINGMAXLENGTH dup(?),'$'
	_int_1 	dd 1.000000
	_str_1 	db "Hola",'$',27 dup(?)
	_str_2 	db "CHAU",'$',27 dup(?)

.CODE
MAIN:
	MOV 	AX, @DATA
	MOV 	DS,AX
	MOV 	ES,AX


conditional1:

	FLD 	_int_1
	FLD 	_int_1
	FCOMP
	FSTSW 	ax
	SAHF
	JNE 	false_conditional1

	MOV 	DX,OFFSET _str_1
	MOV 	ah,09
	INT 	21h
	MOV 	DX,OFFSET @NEWLINE
	MOV 	ah,09
	INT 	21h
	JMP 	end_conditional1

false_conditional1:

	MOV 	DX,OFFSET _str_2
	MOV 	ah,09
	INT 	21h
	MOV 	DX,OFFSET @NEWLINE
	MOV 	ah,09
	INT 	21h

end_conditional1:


	MOV 	AX, 4C00h
	INT 	21h

END MAIN