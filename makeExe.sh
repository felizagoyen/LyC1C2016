#!/bin/bash

if [[ -f ts.txt ]]; then
  rm ts.txt
fi
if [[ -f intermedia.txt ]]; then
  rm intermedia.txt
fi
flex lexico.l
bison -dyvt sintactico.y
gcc lex.yy.c y.tab.c -o TPFinal
rm lex.yy.c y.tab.c y.tab.h

./TPFinal p
cp Final.asm tasm/BIN/Final.asm
dosbox /home/fernandoelizagoyen/Personal/Unlam/Lenguajes\ y\ Compiladores/TP\ 2016/tasm/BIN/