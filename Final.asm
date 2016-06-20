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

	_var_MUL 	dd ?
	_var_b 	dd ?
	_var_c 	db STRINGMAXLENGTH dup(?),'$'
	_int_0 	dd 0.000000
	_int_1 	dd 1.000000
	_int_3 	dd 3.000000
	_int_2 	dd 2.000000
	_str_1 	db "NOSE",'$',26 dup(?)

.CODE
MAIN:
	MOV 	AX, @DATA
	MOV 	DS,AX
	MOV 	ES,AX

	@aux1 	dq ?
	@aux2 	dq ?
	@aux3 	dq ?
	@aux4 	dq ?
	FLD 	_int_0
	FSTP 	_var_MUL
	FFREE 	st(0)

start_while2:

	FLD 	_var_MUL
	FLD 	_int_1
	FADD
	FSTP 	@aux1
	FFREE 	st(0)
	FLD 	_int_1
	FLD 	_int_3
	FADD
	FSTP 	@aux2
	FFREE 	st(0)
	FLD 	@aux1
	FLD 	@aux2
	FCOMP
	FSTSW 	ax
	SAHF
	JBE 	conditional_branch1

	DisplayFloat 	_var_MUL, 0
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h
	FLD 	_var_MUL
	FLD 	_int_2
	FCOMP
	FSTSW 	ax
	SAHF
	JNE 	conditional_branch2


start_while1:

	FLD 	_var_b
	FLD 	_int_2
	FCOMP
	FSTSW 	ax
	SAHF
	JBE 	conditional_branch3

	FLD 	_var_b
	FLD 	_int_1
	FADD
	FSTP 	@aux3
	FFREE 	st(0)
	FLD 	@aux3
	FSTP 	_var_b
	FFREE 	st(0)
	DisplayFloat 	_var_b, 2
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h
	JMP 	start_while1

conditional_branch3:


	JMP 	conditional_branch4

conditional_branch2:

	MOV 	DX, OFFSET _str_1
	MOV 	ah, 09
	INT 	21h
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h

conditional_branch4:

	FLD 	_int_0
	FSTP 	_var_b
	FFREE 	st(0)
	FLD 	_var_MUL
	FLD 	_int_1
	FADD
	FSTP 	@aux4
	FFREE 	st(0)
	FLD 	@aux4
	FSTP 	_var_MUL
	FFREE 	st(0)
	JMP 	start_while2

conditional_branch1:


	MOV 	AX, 4C00h
	INT 	21h

END MAIN