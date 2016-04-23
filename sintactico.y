%{
#include <stdio.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define SYMBOL_TABLE_FILE "ts.txt"
#define LOGGER 1

#if LOGGER
  #define LOG_MSG printf
#else
  #define LOG_MSG(...)
#endif

FILE  *yyin;
char *yytext;
%}

%token ID ASSIGNMENT_OPERATOR STRING_CTE INT_CTE REAL_CTE
%token ADDITION_OPERATOR SUBSTRACTION_OPERATOR MULTIPLICATION_OPERATOR DIVISION_OPERATOR CONCATENATION_OPERATOR
%token DIM OPEN_CLASP CLOSE_CLASP AS STRING_TYPE INTEGER_TYPE REAL_TYPE COMA_SEPARATOR
%token READ WRITE
%token OPEN_PARENTHESIS CLOSE_PARENTHESIS
%token ALL_EQUAL IGUALES
%token GREATER_THAN_OPERATOR GREATER_EQUALS_OPERATOR SMALLER_THAN_OPERATOR SMALLER_EQUALS_OPERATOR EQUALS_OPERATOR NOT_EQUALS_OPERATOR OR_OPERATOR AND_OPERATOR NEGATION
%token IF_STATEMENT ELSE_STATEMENT END_IF_STATEMENT WHILE_STATEMENT END_WHILE_STATEMENT

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
    | ID COMA_SEPARATOR declaration_list COMA_SEPARATOR variable_type

variable_type:
      STRING_TYPE
    | INTEGER_TYPE
    | REAL_TYPE

statement:
      assignment
    | if
    | if_else
    | while
    | read
    | write
    | iguales
    | all_equal

assignment:
      ID ASSIGNMENT_OPERATOR string_concatenation
    | ID ASSIGNMENT_OPERATOR expression
    | ID ASSIGNMENT_OPERATOR SUBSTRACTION_OPERATOR factor

expression:
     // OPEN_PARENTHESIS expression CLOSE_PARENTHESIS //esto tira shift reduce
     expression ADDITION_OPERATOR term
    | expression SUBSTRACTION_OPERATOR term
    | term

term:
    //  OPEN_PARENTHESIS term CLOSE_PARENTHESIS //y esto tmb creo
     term MULTIPLICATION_OPERATOR factor
    | term DIVISION_OPERATOR factor
    | factor

factor:
      OPEN_PARENTHESIS factor CLOSE_PARENTHESIS
    | OPEN_PARENTHESIS SUBSTRACTION_OPERATOR factor CLOSE_PARENTHESIS
    | ID
    | INT_CTE
    | REAL_CTE 

string_concatenation:
      STRING_CTE
    | STRING_CTE CONCATENATION_OPERATOR STRING_CTE
    | STRING_CTE CONCATENATION_OPERATOR ID
    | ID CONCATENATION_OPERATOR STRING_CTE
    | ID CONCATENATION_OPERATOR ID

comparation:
      expression GREATER_EQUALS_OPERATOR expression
    | expression GREATER_THAN_OPERATOR expression
    | expression SMALLER_EQUALS_OPERATOR expression
    | expression SMALLER_THAN_OPERATOR expression
    | expression EQUALS_OPERATOR expression
    | expression NOT_EQUALS_OPERATOR expression
  
condition:
      comparation
    | comparation AND_OPERATOR comparation
    | comparation OR_OPERATOR comparation
    | NEGATION comparation
  
if:
      IF_STATEMENT OPEN_PARENTHESIS condition CLOSE_PARENTHESIS statements END_IF_STATEMENT
  
if_else:
      IF_STATEMENT OPEN_PARENTHESIS condition CLOSE_PARENTHESIS statements ELSE_STATEMENT statements END_IF_STATEMENT

while:
      WHILE_STATEMENT condition statements END_WHILE_STATEMENT
  
all_equal:
      ALL_EQUAL OPEN_PARENTHESIS expression_lists CLOSE_PARENTHESIS

iguales:
      IGUALES OPEN_PARENTHESIS expression COMA_SEPARATOR OPEN_CLASP expression_list CLOSE_CLASP CLOSE_PARENTHESIS

expression_lists:
      OPEN_CLASP expression_list CLOSE_CLASP COMA_SEPARATOR OPEN_CLASP expression_list CLOSE_CLASP
    | expression_lists COMA_SEPARATOR OPEN_CLASP expression_list CLOSE_CLASP

expression_list:
    | expression_list COMA_SEPARATOR expression
    | expression 
    
read:
      READ ID

write:
      WRITE string_concatenation
    | WRITE expression
%%

int main( int argc,char *argv[] ) {
  if ( ( yyin = fopen( argv[1], "rt" ) ) == NULL ) {
    printf( "Error al abrir %s\n", argv[1] );
    return -1;
  }

  yyparse();
  fclose( yyin );
}

int yyerror( void ) {
  printf( "\n\nSyntax Error\n" );
  exit(1);
}

void add_symbol_table( const char* token ) {
  FILE *ts_file;
  char temp[512];
  char string_token[512] = "\0";

  //Open ts file to add register
  if( ( ts_file = fopen( SYMBOL_TABLE_FILE, "a+" ) ) == NULL ) {
    printf( "Error al abrir tabla de simbolos %s\n", SYMBOL_TABLE_FILE );
    exit(1);
  }

  if( strcmp("ID", token) != 0 ) {
    strcpy( string_token, "_" );
  }
  if( strcmp("STRING_CTE", token) != 0 ) {
    strcpy( string_token, "_" );
  }
  strcat( string_token, yytext ); 
  
  //If the token is in the table, finish the function
  while( fgets(temp, 512, ts_file) != NULL ) {
    if( ( strcmp( strtok ( temp, "|" ), string_token ) ) == 0 ) {
      return;
    }
  }

  // saves the record in [name|type|value] format
  if( strcmp("ID", token) == 0 ) {
    fprintf( ts_file, "%s||\n", string_token);
  } else {
    if( strcmp("REAL_CTE", token) == 0) {
      fprintf( ts_file, "%s|%s|%f\n", string_token, token, atof(yytext) );
    } else {
      fprintf( ts_file, "%s|%s|%s\n", string_token, token, yytext );
    }
  }

  // closes file
  fclose( ts_file ); 
}