include macros2.asm
include number.asm

.MODEL 	LARGE
.386
.STACK 	200h

.DATA

	STRINGMAXLENGTH 	equ 31
	@read_string 	db 0Dh,0Ah,'$'
	@concat_string 	db STRINGMAXLENGTH dup(?),'$'
	@NEWLINE 	db 0Dh,0Ah,'$'

	_var_a 	db STRINGMAXLENGTH dup(?),'$'
	_var_e 	db STRINGMAXLENGTH dup(?),'$'
	_var_b 	dd ?
	_var_c 	dd ?
	_var_f 	dd ?
	_var_h 	dd ?
	_var_string_var 	db STRINGMAXLENGTH dup(?),'$'
	_var_int_var 	dd ?
	_var_real_var 	dd ?
	_str_1 	db "Ingrese un numero entero",'$',7 dup(?)
	_str_2 	db "El numero ingresado es:",'$',8 dup(?)
	_str_3 	db "Ingrese un numero real",'$',9 dup(?)
	_str_4 	db "El numero ingresado es:",'$',8 dup(?)
	_str_5 	db "123456789012345678901234567890",'$',1 dup(?)
	_str_6 	db "Grupo06",'$',24 dup(?)
	_str_7 	db "Prueba de ",'$',21 dup(?)
	_str_8 	db "Concatenacion",'$',18 dup(?)
	_int_1 	dd 1.000000
	_int_3 	dd 3.000000
	_int_5 	dd 5.000000
	_int_7 	dd 7.000000
	_int_0 	dd 0.000000
	_str_9 	db "Ingrese un numero",'$',14 dup(?)
	_int_8 	dd 8.000000
	_str_10 	db "Ingreso el 5 o el 8",'$',12 dup(?)
	_str_11 	db "No Ingreso ni 5 ni 8",'$',11 dup(?)
	_allEqualsResults 	dd ?
	_allEqualsPivote1 	dd ?
	_int_2 	dd 2.000000
	_allEqualsPivote2 	dd ?
	_int_4 	dd 4.000000
	_allEqualsPivote3 	dd ?
	_int_55 	dd 55.000000
	_str_12 	db "Condicion negada",'$',15 dup(?)
	_equalsCount1 	dd ?
	_equalsPivote1 	dd ?
	_equalsCount2 	dd ?
	_equalsPivote2 	dd ?

.CODE
MAIN:
	MOV 	AX, @DATA
	MOV 	DS,AX
	MOV 	ES,AX

	@aux1 	dq ?
	@aux2 	dq ?
	@aux3 	dq ?
	@aux4 	dq ?
	@aux5 	dq ?
	@aux6 	dq ?
	@aux7 	dq ?
	@aux8 	dq ?
	@aux9 	dq ?
	@aux10 	dq ?
	@aux11 	dq ?
	@aux12 	dq ?
	MOV 	DX, OFFSET _str_1
	MOV 	ah, 09
	INT 	21h
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h
	GetFloat 	_var_int_var
	MOV 	DX, OFFSET _str_2
	MOV 	ah, 09
	INT 	21h
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h
	DisplayFloat 	_var_int_var, 0
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h
	MOV 	DX, OFFSET _str_3
	MOV 	ah, 09
	INT 	21h
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h
	GetFloat 	_var_c
	MOV 	DX, OFFSET _str_2
	MOV 	ah, 09
	INT 	21h
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h
	DisplayFloat 	_var_c, 2
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h
	MOV 	SI,OFFSET _str_5
	MOV 	DI,OFFSET _var_string_var
	STRCPY
	MOV 	DX, OFFSET _var_string_var
	MOV 	ah, 09
	INT 	21h
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h
	MOV 	SI,OFFSET _str_6
	MOV 	DI,OFFSET _var_string_var
	STRCPY
	MOV 	DX, OFFSET _var_string_var
	MOV 	ah, 09
	INT 	21h
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h
	MOV SI, OFFSET _str_7
	MOV DI, OFFSET @concat_string
	STRCPY
	MOV SI, OFFSET _str_8
	MOV DI, OFFSET @concat_string
	STRCAT
	MOV 	DX, OFFSET @concat_string
	MOV 	ah, 09
	INT 	21h
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h
	FLD 	_var_b
	FLD 	_int_1
	FSUB
	FSTP 	@aux1
	FFREE 	st(0)
	FLD 	@aux1
	FLD 	_int_3
	FDIV
	FSTP 	@aux2
	FFREE 	st(0)
	FLD 	@aux2
	FLD 	_int_5
	FADD
	FSTP 	@aux3
	FFREE 	st(0)
	FLD 	@aux3
	FLD 	_int_7
	FMUL
	FSTP 	@aux4
	FFREE 	st(0)
	FLD 	@aux4
	FSTP 	_var_b
	FFREE 	st(0)
	DisplayFloat 	_var_b, 0
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h
	FLD 	_int_0
	FSTP 	_var_int_var
	FFREE 	st(0)

start_while1:

	FLD 	_var_int_var
	FLD 	_int_5
	FCOMP
	FSTSW 	ax
	SAHF
	JB 	conditional_branch1

	DisplayFloat 	_var_int_var, 0
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h
	FLD 	_var_int_var
	FLD 	_int_1
	FADD
	FSTP 	@aux5
	FFREE 	st(0)
	FLD 	@aux5
	FSTP 	_var_int_var
	FFREE 	st(0)
	JMP 	start_while1

conditional_branch1:

	MOV 	DX, OFFSET _str_9
	MOV 	ah, 09
	INT 	21h
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h
	GetFloat 	_var_int_var
	FLD 	_var_int_var
	FLD 	_int_5
	FCOMP
	FSTSW 	ax
	SAHF
	JE 	conditional_branch2

	FLD 	_var_int_var
	FLD 	_int_8
	FCOMP
	FSTSW 	ax
	SAHF
	JNE 	conditional_branch3


conditional_branch2:

	MOV 	DX, OFFSET _str_10
	MOV 	ah, 09
	INT 	21h
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h

	JMP 	conditional_branch4

conditional_branch3:

	MOV 	DX, OFFSET _str_11
	MOV 	ah, 09
	INT 	21h
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h

conditional_branch4:

	FLD 	_int_0
	FSTP 	_allEqualsResults
	FFREE 	st(0)
	FLD 	_int_1
	FSTP 	_allEqualsPivote1
	FFREE 	st(0)
	FLD 	_int_2
	FSTP 	_allEqualsPivote2
	FFREE 	st(0)
	FLD 	_int_4
	FSTP 	_allEqualsPivote3
	FFREE 	st(0)
	FLD 	_int_1
	FLD 	_allEqualsPivote1
	FCOMP
	FSTSW 	ax
	SAHF
	JNE 	conditional_branch5

	FLD 	_int_2
	FLD 	_allEqualsPivote2
	FCOMP
	FSTSW 	ax
	SAHF
	JNE 	conditional_branch5

	FLD 	_int_3
	FLD 	_allEqualsPivote3
	FCOMP
	FSTSW 	ax
	SAHF
	JNE 	conditional_branch5

	FLD 	_int_1
	FLD 	_int_5
	FDIV
	FSTP 	@aux6
	FFREE 	st(0)
	FLD 	@aux6
	FLD 	_allEqualsPivote1
	FCOMP
	FSTSW 	ax
	SAHF
	JNE 	conditional_branch5

	FLD 	_int_55
	FLD 	_allEqualsPivote2
	FCOMP
	FSTSW 	ax
	SAHF
	JNE 	conditional_branch5

	FLD 	_int_3
	FLD 	_int_4
	FMUL
	FSTP 	@aux7
	FFREE 	st(0)
	FLD 	_int_2
	FLD 	@aux7
	FADD
	FSTP 	@aux8
	FFREE 	st(0)
	FLD 	@aux8
	FLD 	_allEqualsPivote3
	FCOMP
	FSTSW 	ax
	SAHF
	JNE 	conditional_branch5

	FLD 	_int_1
	FSTP 	_allEqualsResults
	FFREE 	st(0)

conditional_branch5:

	FLD 	_allEqualsResults
	FLD 	_int_1
	FCOMP
	FSTSW 	ax
	SAHF
	JE 	conditional_branch6

	MOV 	DX, OFFSET _str_12
	MOV 	ah, 09
	INT 	21h
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h

conditional_branch6:

	FLD 	_int_0
	FSTP 	_equalsCount1
	FFREE 	st(0)
	FLD 	_int_1
	FSTP 	_equalsPivote1
	FFREE 	st(0)
	FLD 	_int_0
	FSTP 	_equalsCount2
	FFREE 	st(0)
	FLD 	_int_1
	FSTP 	_equalsPivote2
	FFREE 	st(0)
	FLD 	_int_1
	FLD 	_equalsPivote2
	FCOMP
	FSTSW 	ax
	SAHF
	JNE 	conditional_branch7

	FLD 	_int_1
	FLD 	_equalsCount2
	FADD
	FSTP 	@aux9
	FFREE 	st(0)
	FLD 	@aux9
	FSTP 	_equalsCount2
	FFREE 	st(0)

conditional_branch7:

	FLD 	_equalsCount2
	FLD 	_equalsPivote1
	FCOMP
	FSTSW 	ax
	SAHF
	JNE 	conditional_branch8

	FLD 	_int_1
	FLD 	_equalsCount1
	FADD
	FSTP 	@aux10
	FFREE 	st(0)
	FLD 	@aux10
	FSTP 	_equalsCount1
	FFREE 	st(0)

conditional_branch8:

	FLD 	_int_3
	FLD 	_equalsPivote1
	FCOMP
	FSTSW 	ax
	SAHF
	JNE 	conditional_branch9

	FLD 	_int_1
	FLD 	_equalsCount1
	FADD
	FSTP 	@aux11
	FFREE 	st(0)
	FLD 	@aux11
	FSTP 	_equalsCount1
	FFREE 	st(0)

conditional_branch9:

	FLD 	_int_1
	FLD 	_equalsPivote1
	FCOMP
	FSTSW 	ax
	SAHF
	JNE 	conditional_branch10

	FLD 	_int_1
	FLD 	_equalsCount1
	FADD
	FSTP 	@aux12
	FFREE 	st(0)
	FLD 	@aux12
	FSTP 	_equalsCount1
	FFREE 	st(0)

conditional_branch10:

	FLD 	_equalsCount1
	FSTP 	_var_h
	FFREE 	st(0)
	DisplayFloat 	_var_h, 0
	MOV 	DX, OFFSET @NEWLINE
	MOV 	ah, 09
	INT 	21h

	MOV 	AX, 4C00h
	INT 	21h

END MAIN