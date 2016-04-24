%{
#include <stdio.h>
#include "y.tab.h"

#define LOGGER 0
#define STRING_MAX_LENGTH 64

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
"IF"                { LOG_MSG("IF_STATEMENT"); return IF_STATEMENT; }
"ENDIF"             { LOG_MSG("END_IF_STATEMENT"); return END_IF_STATEMENT; }
"ELSE"              { LOG_MSG("ELSE_STATEMENT"); return ELSE_STATEMENT; }
"WHILE"             { LOG_MSG("WHILE_STATEMENT"); return WHILE_STATEMENT; }
"ENDWHILE"          { LOG_MSG("END_WHILE_STATEMENT"); return END_WHILE_STATEMENT; }
"READ"              { LOG_MSG("READ"); return READ; }
"WRITE"             { LOG_MSG("WRITE"); return WRITE; }
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
">"                 { LOG_MSG("GREATER_THAN_OPERATOR"); return GREATER_THAN_OPERATOR; }
"<"                 { LOG_MSG("SMALLER_THAN_OPERATOR"); return SMALLER_THAN_OPERATOR; }
"=="                { LOG_MSG("EQUALS_OPERATOR"); return EQUALS_OPERATOR; }
">="                { LOG_MSG("GREATER_EQUALS_OPERATOR"); return GREATER_EQUALS_OPERATOR; }
"<="                { LOG_MSG("SMALLER_THAN_OPERATOR"); return SMALLER_EQUALS_OPERATOR; }
"!"                 { LOG_MSG("NEGATION"); return NEGATION; }
"&&"                { LOG_MSG("AND_OPERATOR"); return AND_OPERATOR; }
"||"                { LOG_MSG("OR_OPERATOR"); return OR_OPERATOR; }
"!="                { LOG_MSG("NOT_EQUALS_OPERATOR"); return NOT_EQUALS_OPERATOR; }
{INT_CTE}           { add_symbol_table("INT_CTE"); LOG_MSG("INT_CTE"); return INT_CTE; }
{REAL_CTE}          { add_symbol_table("REAL_CTE"); LOG_MSG("REAL_CTE"); return REAL_CTE; }
{STRING_CTE}        { add_symbol_table("STRING_CTE"); LOG_MSG("STRING_CTE"); return STRING_CTE; }
{ID}                { yylval.str_value=strdup(yytext); LOG_MSG("ID"); return ID; }

%%

int stringValidation(char * string) {
	 if(string[0]=='"') {
		  int count=1;
		  while(string[count]!='"' && string[count]!='\n' && count<=STRING_MAX_LENGTH) {
		   count++;
		  }
		  if(string[count]=='"') {
			printf("String OK");
			return 0;
		  }
		  else if(count > STRING_MAX_LENGTH){
				printf("String index out of bounds\n");
				exit(1);
			  }
	 }
	 else{
		printf("Invalid format\n");
		exit(1);
	 }
	}

		//-32768 to 32767
	int intRangeValidation(char * number) {
		int count=0, i=1;
		long n=0;
		if(number[0]=='-') {
			count++;
		}
		while(number[count]!='\0') {
			count++;
		}
		if(count<6) {
				printf("int OK");
				return 0;
			}
		else if(count==6) {
				for(i=1; i<=10000; i=i*10) {
					count--;
					n+=number[count]*i;
				}
				if(n<=32767 && n>=-32768) {
					printf("int OK");
					return 0;
				}
			}
			
		printf("Number out of range\n");
		exit(-1);
		
	}
	
		//-2147483648 to 2147483647
		int realRangeValidation(char * number) {
			
		}
