c:\GnuWin32\bin\flex.exe lexico.l
pause
c:\GnuWin32\bin\bison.exe -dyv sintactico.y
pause
c:\MinGW\bin\gcc.exe lex.yy.c y.tab.c -o TPFinal.exe
pause
pause
TPfinal.exe prueba.txt
del lex.yy.c
del y.tab.c
del y.output
del y.tab.h
del TPFinal.exe
pause
