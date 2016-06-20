include macros2.asm
include number.asm

.MODEL 	LARGE
.386
.STACK 	200h

.DATA

	STRINGMAXLENGTH 	equ 30
	@read_string 	db 0Dh,0Ah,'$'
	@concat_string 	db STRINGMAXLENGTH dup(?),'$'
	@NEWLINE 	db 0Dh,0Ah,'$'

	a 	dd ?
	b 	dd ?
	c 	db STRINGMAXLENGTH dup(?),'$'
	_str_1 	db "holaholaholahoolahola",'$',9 dup(?)
	_str_2 	db "13214",'$',25 dup(?)
	_real_123_234 	dd 123.234000

.CODE
MAIN:
	MOV 	AX, @DATA
	MOV 	DS,AX
	MOV 	ES,AX

	MOV SI, OFFSET _str_1
	MOV DI, OFFSET @concat_string
	STRCPY
	MOV SI, OFFSET _str_2
	MOV DI, OFFSET @concat_string
	STRCAT
	MOV 	DX, OFFSET @concat_string
	MOV 	ah, 09
	INT 	21h
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h
	FLD 	a
	FADD 	_real_123_234
	@aux1 	dq ?
	FSTP 	@aux1
	FLD 	@aux1
	FSTP 	a
	FFREE 	st(0)
	DisplayFloat 	a, 0
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h

	MOV 	AX, 4C00h
	INT 	21h

END MAIN