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
COMMENT          -\/.*\/-

%%

{COMMENT}           { LOG_MSG("COMMENT");}
"DIM"               { LOG_MSG("DIM"); return DIM; }
"AS"                { LOG_MSG("AS"); return AS; }
"string"            { LOG_MSG("STRING_TYPE"); return STRING_TYPE; }
"integer"           { LOG_MSG("INTEGER_TYPE"); return INTEGER_TYPE; }
"real"              { LOG_MSG("REAL_TYPE"); return REAL_TYPE; }
"AllEqual"          { LOG_MSG("ALL_EQUAL"); return ALL_EQUAL; }
"READ"				{ LOG_MSG("READ"); return READ; }
"WRITE"				{ LOG_MSG("WRITE"); return WRITE; }
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
">"					{ LOG_MSG("GREATER_THAN_OPERATOR"); return GREATER_THAN_OPERATOR; }
"<"				    { LOG_MSG("SMALLER_THAN_OPERATOR"); return SMALLER_THAN_OPERATOR; }
"=="        		{ LOG_MSG("EQUALS_OPERATOR"); return EQUALS_OPERATOR; }
">="				{ LOG_MSG("GREATER_EQUALS_OPERATOR"); return GREATER_EQUALS_OPERATOR; }
"<="				{ LOG_MSG("SMALLER_THAN_OPERATOR"); return SMALLER_EQUALS_OPERATOR; }
"!"					{ LOG_MSG("NEGATION"); return NEGATION; }
"&&"				{ LOG_MSG("AND_OPERATOR"); return AND_OPERATOR; }
"||"	        	{ LOG_MSG("OR_OPERATOR"); return OR_OPERATOR; }
"!="	        	{ LOG_MSG("NOT_EQUALS_OPERATOR"); return NOT_EQUALS_OPERATOR; }
"ENDIF"	        	{ LOG_MSG("END_IF_STATEMENT"); return END_IF_STATEMENT; }
"IF"	        	{ LOG_MSG("IF_STATEMENT"); return IF_STATEMENT; }
"ELSE"	        	{ LOG_MSG("ELSE_STATEMENT"); return ELSE_STATEMENT; }
"#Iguales"	        { LOG_MSG("IGUALES"); return IGUALES; }
{INT_CTE}           { LOG_MSG("INT_CTE"); return INT_CTE; }
{REAL_CTE}          { LOG_MSG("REAL_CTE"); return REAL_CTE; }
{STRING_CTE}        { LOG_MSG("STRING_CTE"); return STRING_CTE; }
{ID}                { LOG_MSG("ID"); return ID; }

%%
