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

%%

program:
      statements { LOG_MSG("\nSuccessful Compilation\n"); }

statements:
      statements statement | statement

statement:
      assignment

assignment:
      ID ASSIGNMENT_OPERATOR value

value:
      ID
    | STRING
    | INT
    | REAL

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