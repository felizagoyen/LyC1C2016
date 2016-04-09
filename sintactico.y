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

%token ID ASSIGNMENT_OPERATOR STRING INT REAL
%token ADDITION_OPERATOR SUBSTRACTION_OPERATOR MULTIPLICATION_OPERATOR DIVISION_OPERATOR CONCATENATION_OPERATOR

%%

program:
      statements { LOG_MSG("\nSuccessful Compilation\n"); }

statements:
      statements statement 
    | statement

statement:
      assignment

assignment:
      ID ASSIGNMENT_OPERATOR expression
    | ID ASSIGNMENT_OPERATOR string_concatenation

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
    | INT
    | REAL

string_concatenation:
      STRING
    | STRING CONCATENATION_OPERATOR STRING
    | STRING CONCATENATION_OPERATOR ID
    | ID CONCATENATION_OPERATOR STRING
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