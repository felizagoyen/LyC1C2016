#!/bin/bash

if [[ -f ts.txt ]]; then
  rm ts.txt
fi
flex lexico.l
bison -dyvt sintactico.y
gcc lex.yy.c y.tab.c -o TPFinal
pause
rm lex.yy.c y.tab.c y.tab.h
