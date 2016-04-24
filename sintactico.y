%{
#include <stdio.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "y.tab.h"

#define SYMBOL_TABLE_FILE "ts.txt"
#define LOGGER 1

#if LOGGER
  #define LOG_MSG printf
#else
  #define LOG_MSG(...)
#endif

FILE  *yyin;
char *yytext;
int var_count=0;

char var_name[30][10];
char var_type[30][10];

void add_var_symbol_table();

%}
%union {
    char* str_value;
    float real_value;
    int int_value;
}
%type <str_value> ID

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
          {
            add_var_symbol_table();
            var_count=0;
          }

declaration_list:
      ID CLOSE_CLASP AS OPEN_CLASP variable_type
          {
            strcpy(var_name[var_count], $1);
            var_count++;
          }
    | ID COMA_SEPARATOR declaration_list COMA_SEPARATOR variable_type
          {
            strcpy(var_name[var_count], $1);
            var_count++;
          }

variable_type:
      STRING_TYPE
          {
            strcpy(var_type[var_count], yytext);
          }
    | INTEGER_TYPE
          {
            strcpy(var_type[var_count], yytext);
          }
    | REAL_TYPE
          {
            strcpy(var_type[var_count], yytext);
          }

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

int main(int argc,char *argv[]) {
  //Abro el archivo de entrada que se desea compilar
  if((yyin = fopen( argv[1], "rt")) == NULL) {
    printf("Error al abrir %s\n", argv[1]);
    return -1;
  }

  //Metodo que recorre el archivo de entrada
  yyparse();

  //Cierro el archivo
  fclose(yyin);
}

/*
Si hay un error de sintaxis, el analizador llamara a esta funcion
para generar una salida en pantalla mostrando el error  
*/
int yyerror(void) {
  printf("\n\nSyntax Error\n");
  fclose(yyin);
  exit(1);
}

/*
Agrega a la tabla de simbolos constantes enteras reales y strings
*/
void add_symbol_table(const char* token) {
  FILE *ts_file;
  char temp[512];
  char string_token[512] = "\0";

  //Abro el archivo de la tabla de simbolos
  if((ts_file = fopen(SYMBOL_TABLE_FILE, "a+")) == NULL) {
    printf("Error al abrir tabla de simbolos %s\n", SYMBOL_TABLE_FILE);
    exit(1);
  }

  //Si no es un string, le coloco guion bajo delante
  if(strcmp("STRING_CTE", token) != 0) {
    strcpy(string_token, "_");
  }

  //yytext tiene el lexema de la constante, lo concateno al guion bajo
  strcat(string_token, yytext); 
  
  //Recorro el archivo para ver si ya fue ingresada la constante para no generar duplicados
  while(fgets(temp, 512, ts_file) != NULL) {
    if((strcmp(strtok(temp, "|" ), string_token)) == 0) {
      fclose(ts_file); 
      return;
    }
  }

  //Genero un nuevo registro con el formato name|type|value
  if(strcmp("REAL_CTE", token) == 0) {
    fprintf(ts_file, "%s|%s|%f\n", string_token, token, atof(yytext));
  } else {
    fprintf(ts_file, "%s|%s|%s\n", string_token, token, yytext);
  }

  //Cierro el archivo de la tabla de simbolos
  fclose(ts_file); 
}

/*
Agrega a la tabla de simbolos las variables con sus tipos
*/
void add_var_symbol_table() {
  FILE *ts_file;
  char temp[512];
  int x = 0;

  //Abre la tabla de simbolos
  if((ts_file = fopen(SYMBOL_TABLE_FILE, "a+")) == NULL) {
    printf("Error al abrir tabla de simbolos %s\n", SYMBOL_TABLE_FILE);
    exit(1);
  }


  for(x; x < var_count; x++) {
    //Si ya existe en la tabla de simbolos, lanzo un error
    while(fgets(temp, 512, ts_file) != NULL) {
      if((strcmp(strtok(temp, "|"), var_name[var_count-x-1])) == 0) {
        printf("La variable %s ya se encuentra declarada\n", var_name[var_count-x-1]);
        fclose(ts_file); 
        exit(1);
      }
    }

    //Genero el registro en la tabla de simbolos
    fprintf(ts_file, "%s|%s|\n", var_name[var_count-x-1], var_type[x]);
    rewind(ts_file);
  }

  // closes file
  fclose(ts_file); 
}