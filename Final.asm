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
	_real_1_1 	dd 1.100000
	_int_0 	dd 0.000000
	_int_1 	dd 1.000000
	_int_100 	dd 100.000000
	_int_34 	dd 34.000000
	_int_3 	dd 3.000000

.CODE
MAIN:
	MOV 	AX, @DATA
	MOV 	DS,AX
	MOV 	ES,AX

	fld 	_real_1_1
	fstp 	b
	ffree 	st(0)
	fld 	_int_0
	fstp 	a
	ffree 	st(0)
	fld 	a
	fadd 	_int_1
	@aux1 	dq ?
	fstp 	@aux1
	ffree 	st(0)
	fld 	@aux1
	fstp 	a
	ffree 	st(0)
	DisplayFloat 	a,0
	MOV 	DX,OFFSET @NEWLINE
	MOV 	ah,09
	INT 	21h
	fld 	a
	fmul 	_int_100
	@aux2 	dq ?
	fstp 	@aux2
	ffree 	st(0)
	fld 	@aux2
	fstp 	a
	ffree 	st(0)
	DisplayFloat 	a,0
	MOV 	DX,OFFSET @NEWLINE
	MOV 	ah,09
	INT 	21h
	fld 	a
	fsub 	_int_34
	@aux3 	dq ?
	fstp 	@aux3
	ffree 	st(0)
	fld 	@aux3
	fstp 	a
	ffree 	st(0)
	DisplayFloat 	a,0
	MOV 	DX,OFFSET @NEWLINE
	MOV 	ah,09
	INT 	21h
	fld 	a
	fdiv 	_int_3
	@aux4 	dq ?
	fstp 	@aux4
	ffree 	st(0)
	fld 	@aux4
	fstp 	a
	ffree 	st(0)
	DisplayFloat 	a,0
	MOV 	DX,OFFSET @NEWLINE
	MOV 	ah,09
	INT 	21h
	MOV 	AX, 4C00h
	INT 	21h

END MAIN