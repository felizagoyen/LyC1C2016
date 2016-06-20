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
	_int_5 	dd 5.000000
	_int_2 	dd 2.000000
	_int_4 	dd 4.000000
	_str_1 	db "BIEN",'$',26 dup(?)
	_int_1 	dd 1.000000
	_int_0 	dd 0.000000

.CODE
MAIN:
	MOV 	AX, @DATA
	MOV 	DS,AX
	MOV 	ES,AX

	@aux1 	dq ?
	@aux2 	dq ?
	@aux3 	dq ?

start_conditional1:

	FLD 	a
	FLD 	_int_5
	FCOMP
	FSTSW 	ax
	SAHF
	JBE 	conditional_branch1


start_conditional2:

	FLD 	a
	FLD 	_int_2
	FCOMP
	FSTSW 	ax
	SAHF
	JE 	conditional_branch2


start_conditional3:

	FLD 	a
	FLD 	_int_4
	FCOMP
	FSTSW 	ax
	SAHF
	JNE 	conditional_branch3


conditional_branch2:

	MOV 	DX, OFFSET _str_1
	MOV 	ah, 09
	INT 	21h
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h

conditional_branch3:

	DisplayFloat 	a, 0
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h
	FLD 	a
	FLD 	_int_1
	FADD
	FSTP 	@aux1
	FFREE 	st(0)
	FLD 	@aux1
	FSTP 	a
	FFREE 	st(0)
	JMP 	start_conditional1

conditional_branch1:

	FLD 	_int_0
	FSTP 	a
	FFREE 	st(0)

start_conditional4:

	FLD 	a
	FLD 	_int_5
	FCOMP
	FSTSW 	ax
	SAHF
	JBE 	conditional_branch4


start_conditional5:

	FLD 	b
	FLD 	_int_5
	FCOMP
	FSTSW 	ax
	SAHF
	JBE 	conditional_branch5

	FLD 	b
	FLD 	_int_1
	FADD
	FSTP 	@aux2
	FFREE 	st(0)
	FLD 	@aux2
	FSTP 	b
	FFREE 	st(0)
	DisplayFloat 	b, 2
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h
	JMP 	start_conditional5

conditional_branch5:

	FLD 	_int_0
	FSTP 	b
	FFREE 	st(0)
	FLD 	a
	FLD 	_int_1
	FADD
	FSTP 	@aux3
	FFREE 	st(0)
	FLD 	@aux3
	FSTP 	a
	FFREE 	st(0)
	DisplayFloat 	a, 0
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h
	JMP 	start_conditional4

conditional_branch4:


	MOV 	AX, 4C00h
	INT 	21h

END MAIN