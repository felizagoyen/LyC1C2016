%{
#include <stdio.h>
#include "y.tab.h"

#define LOGGER 1

#if LOGGER
  #define LOG_MSG printf
#else
  #define LOG_MSG(...)
#endif

%}

%option noyywrap
%option yylineno

DIGIT               [0-9]
CHARACTER           [a-zA-Z]
INT_CTE             {DIGIT}+
REAL_CTE            {DIGIT}*\.{DIGIT}+|{DIGIT}+\.{DIGIT}+|{DIGIT}+\.{DIGIT}*
STRING_CTE          \"(\\.|[^"|\|])*\"
ID                  {CHARACTER}({CHARACTER}|{DIGIT}|_)*

%%

"DIM"               { LOG_MSG("DIM"); return DIM; }
"AS"                { LOG_MSG("AS"); return AS; }
"string"            { LOG_MSG("STRING_TYPE"); return STRING_TYPE; }
"integer"           { LOG_MSG("INTEGER_TYPE"); return INTEGER_TYPE; }
"real"              { LOG_MSG("REAL_TYPE"); return REAL_TYPE; }
","                 { LOG_MSG("COMA_SEPARATOR"); return COMA_SEPARATOR; }
"["                 { LOG_MSG("OPEN_CLASP"); return OPEN_CLASP; }
"]"                 { LOG_MSG("CLOSE_CLASP"); return CLOSE_CLASP; }
"("                 { LOG_MSG("OPEN_PARENTHESIS"); return OPEN_PARENTHESIS; }
")"                 { LOG_MSG("CLOSE_PARENTHESIS"); return CLOSE_PARENTHESIS; }
":="                { LOG_MSG("ASSIGNMENT_OPERATOR"); return ASSIGNMENT_OPERATOR; }
"++"                { LOG_MSG("CONCATENATION_OPERATOR"); return CONCATENATION_OPERATOR; }
"+"                 { LOG_MSG("ADDITION_OPERATOR"); return ADDITION_OPERATOR; }
"-"                 { LOG_MSG("SUBSTRACTION_OPERATOR"); return SUBSTRACTION_OPERATOR; }
"*"                 { LOG_MSG("MULTIPLICATION_OPERATOR"); return MULTIPLICATION_OPERATOR; }
"/"                 { LOG_MSG("DIVISION_OPERATOR"); return DIVISION_OPERATOR; }
"AllEqual"          { LOG_MSG("ALL_EQUAL"); return ALL_EQUAL; }
{INT_CTE}           { LOG_MSG("INT_CTE"); return INT_CTE; }
{REAL_CTE}          { LOG_MSG("REAL_CTE"); return REAL_CTE; }
{STRING_CTE}        { LOG_MSG("STRING_CTE"); return STRING_CTE; }
{ID}                { LOG_MSG("ID"); return ID; }

%%