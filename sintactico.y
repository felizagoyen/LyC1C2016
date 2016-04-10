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
%token GREATER_THAN_OPERATOR GREATER_EQUALS_OPERATOR SMALLER_THAN_OPERATOR SMALLER_EQUALS_OPERATOR EQUALS_OPERATOR OR_OPERATOR AND_OPERATOR NEGATION
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

comparation:
  comparation AND_OPERATOR comparation | comparation OR_OPERATOR comparation  | NEGATION comparation | expression GREATER_EQUALS_OPERATOR expression |
  expression GREATER_THAN_OPERATOR expression | expression SMALLER_EQUALS_OPERATOR expression | expression SMALLER_THAN_OPERATOR expression |
  expression EQUALS_OPERATOR expression
  
if:
  IF_STATEMENT comparation statements END_IF_STATEMENT
  
if_else:
  IF_STATEMENT comparation statements ELSE_STATEMENT statements END_IF_STATEMENT

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