%{
#include <stdio.h>
#include <stdlib.h>

#define LOGGER 1

#if LOGGER
  #define LOG_MSG printf
#else
  #define LOG_MSG(...)
#endif

FILE  *yyin;
%}

%token ID ASSIGNMENT_OPERATOR STRING_CTE INT_CTE REAL_CTE
%token ADDITION_OPERATOR SUBSTRACTION_OPERATOR MULTIPLICATION_OPERATOR DIVISION_OPERATOR CONCATENATION_OPERATOR
%token DIM OPEN_CLASP CLOSE_CLASP AS STRING_TYPE INTEGER_TYPE REAL_TYPE DECLARATION_SEPARATOR

%%

program:
      lines { LOG_MSG("\nSuccessful Compilation\n"); }

lines:
      declarations statements

statements:
      statements statement 
    | statement

declarations:
      declarations declaration 
    | declaration

declaration:
      DIM OPEN_CLASP declaration_list CLOSE_CLASP 

declaration_list:
      ID CLOSE_CLASP AS OPEN_CLASP variable_type
    | ID DECLARATION_SEPARATOR declaration_list DECLARATION_SEPARATOR variable_type

variable_type:
      STRING_TYPE
    | INTEGER_TYPE
    | REAL_TYPE

statement:
      assignment 

assignment:
      ID ASSIGNMENT_OPERATOR string_concatenation
    | ID ASSIGNMENT_OPERATOR expression 

expression:
      expression ADDITION_OPERATOR term
    | expression SUBSTRACTION_OPERATOR term
    | term

term:
      term MULTIPLICATION_OPERATOR factor
    | term DIVISION_OPERATOR factor
    | factor

factor:
      ID
    | INT_CTE
    | REAL_CTE

string_concatenation:
      STRING_CTE
    | STRING_CTE CONCATENATION_OPERATOR STRING_CTE
    | STRING_CTE CONCATENATION_OPERATOR ID
    | ID CONCATENATION_OPERATOR STRING_CTE
    | ID CONCATENATION_OPERATOR ID

%%

int main( int argc,char *argv[] ) 
{
  if ( ( yyin = fopen( argv[1], "rt" ) ) == NULL ) 
  {
    printf( "Error al abrir %s\n", argv[1] );
    return -1;
  }

  yyparse();
  fclose( yyin );
}

int yyerror( void ) 
{
  printf( "\n\nSyntax Error\n" );
  exit(1);
}