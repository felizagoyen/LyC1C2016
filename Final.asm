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
	_real_5_9 	dd 5.900000
	_str_1 	db "Hola",'$',27 dup(?)

.CODE
MAIN:
	MOV 	AX, @DATA
	MOV 	DS,AX
	MOV 	ES,AX

	fld 	_int_1
	fstp 	a
	ffree 	st(0)
	fld 	_real_5_9
	fstp 	b
	ffree 	st(0)
	MOV 	DX,OFFSET _str_1
	MOV 	ah,09
	INT 	21h
	MOV 	DX,OFFSET @NEWLINE
	MOV 	ah,09
	INT 	21h
	DisplayFloat 	a,0
	MOV 	DX,OFFSET @NEWLINE
	MOV 	ah,09
	INT 	21h
	DisplayFloat 	b,2
	MOV 	DX,OFFSET @NEWLINE
	MOV 	ah,09
	INT 	21h
	MOV 	AX, 4C00h
	INT 	21h

END MAIN