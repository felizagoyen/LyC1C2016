extrn atoi:proc, itoa:proc, atof:proc, ftoa:proc

.MODEL LARGE
.386
.STACK 200h

.DATA

STRINGMAXLENGTH equ 30

a dd ?
_int_0 dd 0.000000
_int_1 dd 1.000000

.CODE
.startup
mov ax, @data
mov ds,ax

fld _int_0
fstp a
ffree st(0)
fld a
fld _int_1
fadd _int_1
@aux dq ?
fstp @aux
ffree st(0)
fld @aux
fstp a
ffree st(0)
mov ax, 4C00h
int 21h

END