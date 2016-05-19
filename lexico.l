/*
 * TP correspondiente al segundo cuatrimestre del 2016
 * Alumnos:
 * Allegretti, Daniela
 * Elizagoyen, Fernando
 * Escalante, Gonzalo
 */
%{
#include <stdio.h>
#include <math.h>
#include "y.tab.h"

#define LOGGER 0
#define STRING_MAX_LENGTH 32

#if LOGGER
  #define LOG_MSG printf
#else
  #define LOG_MSG(...)
#endif

void string_validation(char *);
void int_range_validation(char *);
void real_range_validation(char *);

%}

%option noyywrap
%option yylineno

DIGIT               [0-9]
CHARACTER           [a-zA-Z]
INT_CTE             {DIGIT}+
REAL_CTE            {DIGIT}*\.{DIGIT}+|{DIGIT}+\.{DIGIT}+|{DIGIT}+\.{DIGIT}*
STRING_CTE          \"(\\.|[^"|\|])*\"
ID                  {CHARACTER}({CHARACTER}|{DIGIT}|_)*
COMMENT             -\/.*\/-

%%

{COMMENT}           { LOG_MSG("COMMENT"); }
"DIM"               { LOG_MSG("DIM"); return DIM; }
"AS"                { LOG_MSG("AS"); return AS; }
"string"            { LOG_MSG("STRING_TYPE"); return STRING_TYPE; }
"integer"           { LOG_MSG("INTEGER_TYPE"); return INTEGER_TYPE; }
"real"              { LOG_MSG("REAL_TYPE"); return REAL_TYPE; }
"AllEqual"          { LOG_MSG("ALL_EQUAL"); return ALL_EQUAL; }
"#Iguales"          { LOG_MSG("IGUALES"); return IGUALES; }
"IF"                { LOG_MSG("IF"); return IF; }
"ENDIF"             { LOG_MSG("ENDIF"); return ENDIF; }
"ELSE"              { LOG_MSG("ELSE"); return ELSE; }
"WHILE"             { LOG_MSG("WHILE"); return WHILE; }
"ENDWHILE"          { LOG_MSG("ENDWHILE"); return ENDWHILE; }
"READ"              { LOG_MSG("READ"); return READ; }
"WRITE"             { LOG_MSG("WRITE"); return WRITE; }
"NOT"               { LOG_MSG("NOT"); return NOT;}
","                 { LOG_MSG("COMA_SEPARATOR"); return COMA_SEPARATOR; }
"["                 { LOG_MSG("OPEN_CLASP"); return OPEN_CLASP; }
"]"                 { LOG_MSG("CLOSE_CLASP"); return CLOSE_CLASP; }
"("                 { LOG_MSG("OPEN_PARENTHESIS"); return OPEN_PARENTHESIS; }
")"                 { LOG_MSG("CLOSE_PARENTHESIS"); return CLOSE_PARENTHESIS; }
":="                { yylval.str_value=strdup(yytext); LOG_MSG("ASSIGNMENT_OPERATOR"); return ASSIGNMENT_OPERATOR; }
"++"                { yylval.str_value=strdup(yytext); LOG_MSG("CONCATENATION_OPERATOR"); return CONCATENATION_OPERATOR; }
"+"                 { yylval.str_value=strdup(yytext); LOG_MSG("ADDITION_OPERATOR"); return ADDITION_OPERATOR; }
"-"                 { yylval.str_value=strdup(yytext); LOG_MSG("SUBSTRACTION_OPERATOR"); return SUBSTRACTION_OPERATOR; }
"*"                 { yylval.str_value=strdup(yytext); LOG_MSG("MULTIPLICATION_OPERATOR"); return MULTIPLICATION_OPERATOR; }
"/"                 { yylval.str_value=strdup(yytext); LOG_MSG("DIVISION_OPERATOR"); return DIVISION_OPERATOR; }
">"                 { yylval.str_value=strdup(yytext); LOG_MSG("GREATER_THAN_OPERATOR"); return GREATER_THAN_OPERATOR; }
"<"                 { yylval.str_value=strdup(yytext); LOG_MSG("SMALLER_THAN_OPERATOR"); return SMALLER_THAN_OPERATOR; }
"=="                { yylval.str_value=strdup(yytext); LOG_MSG("EQUALS_OPERATOR"); return EQUALS_OPERATOR; }
">="                { yylval.str_value=strdup(yytext); LOG_MSG("GREATER_EQUALS_OPERATOR"); return GREATER_EQUALS_OPERATOR; }
"<="                { yylval.str_value=strdup(yytext); LOG_MSG("SMALLER_THAN_OPERATOR"); return SMALLER_EQUALS_OPERATOR; }
"&&"                { yylval.str_value=strdup(yytext); LOG_MSG("AND_OPERATOR"); return AND_OPERATOR; }
"||"                { yylval.str_value=strdup(yytext); LOG_MSG("OR_OPERATOR"); return OR_OPERATOR; }
"!="                { yylval.str_value=strdup(yytext); LOG_MSG("NOT_EQUALS_OPERATOR"); return NOT_EQUALS_OPERATOR; }
{INT_CTE}           { int_range_validation(yytext); yylval.str_value=strdup(yytext); add_symbol_table("INT_CTE"); LOG_MSG("INT_CTE"); return INT_CTE; }
{REAL_CTE}          { real_range_validation(yytext); yylval.str_value=strdup(yytext); add_symbol_table("REAL_CTE"); LOG_MSG("REAL_CTE"); return REAL_CTE; }
{STRING_CTE}        { string_validation(yytext); yylval.str_value=strdup(yytext); add_symbol_table("STRING_CTE"); LOG_MSG("STRING_CTE"); return STRING_CTE; }
{ID}                { yylval.str_value=strdup(yytext); LOG_MSG("ID"); return ID; }

%%

/*
 * Valida la cantidad de caracteres de los strings
 */
void string_validation(char * string) {
  int count=1;
  while(string[count]!='"' && string[count]!='\n' && count<=STRING_MAX_LENGTH) {
    count++;
  }
  if(string[count]=='"') {
    return;
  } else if(count > STRING_MAX_LENGTH){
    printf("String index out of bounds\n");
    exit(1);
  }
}

/*
 * Valida el rango de los numeros enteros
 */
void int_range_validation(char * number) {
  int count=0, i=1;
  long n=0;
  while(number[count]!='\0') {
    count++;
  }
  if(count<5) {
    return;
  } else if(count==5) {
    for(i=1; i<=10000; i=i*10) {
      count--;
      n+=(number[count]-'0')*i;
    }
    if(n<=32767 && n>=-32768) {
      return;
    }
  }
  printf("Number out of range\n");
  exit(-1);
}

/*
 * Valida el rango de los numeros reales
 */
void real_range_validation(char * number) {
  int count=0, m=1, i=0, number_of_decimals=0;
  long integer_part=0;
  while(number[count]!='\0' && number[count]!='.') {	//busca el .
    count++;
  }
  if(number[count]!='\0') {
    count --; //se posiciona en la unidad de la parte entera
    i=count;
    for(i; i>0; i--) {  //arma el numero de atras hacia adelante
      integer_part+=(number[i]-'0')*m;
      m*=10;
    }
  }
  if(integer_part>(3.402823466*pow(10,38))) { //verifica que la parte entera se encuentre dentro del rango correspondiente
    printf("Number out of range\n");
    exit(1);
  }
  count+=2;
  while(number[count]!='\0') {  //cuenta digitos decimales
    number_of_decimals++;
    count++;
  }
  if(number_of_decimals>6) {  //verifica que no se exceda de la cantidad de decimales permitidos
    printf("Number out of range\n");
    exit(1);
  }
} 