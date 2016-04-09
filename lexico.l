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
INT                 {DIGIT}+
REAL                {DIGIT}*\.{DIGIT}+|{DIGIT}+\.{DIGIT}+|{DIGIT}+\.{DIGIT}*
STRING              \"(\\.|[^"|\|])*\"
ID                  {CHARACTER}({CHARACTER}|{DIGIT}|_)*

%%

":="                { LOG_MSG("ASSIGNMENT_OPERATOR"); return ASSIGNMENT_OPERATOR; }
"+"                 { LOG_MSG("ADDITION_OPERATOR"); return ADDITION_OPERATOR; }
"-"                 { LOG_MSG("SUBSTRACTION_OPERATOR"); return SUBSTRACTION_OPERATOR; }
"*"                 { LOG_MSG("MULTIPLICATION_OPERATOR"); return MULTIPLICATION_OPERATOR; }
"/"                 { LOG_MSG("DIVISION_OPERATOR"); return DIVISION_OPERATOR; }
"++"                { LOG_MSG("CONCATENATION_OPERATOR"); return CONCATENATION_OPERATOR; }
{INT}               { LOG_MSG("INT"); return INT; }
{REAL}              { LOG_MSG("REAL"); return REAL; }
{STRING}            { LOG_MSG("STRING"); return STRING; }
{ID}                { LOG_MSG("ID"); return ID; }

%%