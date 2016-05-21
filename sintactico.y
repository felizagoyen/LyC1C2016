/*
 * TP correspondiente al segundo cuatrimestre del 2016
 * Alumnos:
 * Allegretti, Daniela
 * Elizagoyen, Fernando
 * Escalante, Gonzalo
 */
%{
#include <stdio.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "y.tab.h"

#define SYMBOL_TABLE_FILE "ts.txt"
#define CODE_FILE "intermedia.txt"
#define LOGGER 1

#if LOGGER
  #define LOG_MSG printf
#else
  #define LOG_MSG(...)
#endif

typedef struct Polish {
  struct Polish *next;
  char *element;
} struct_polish;

FILE  *yyin;
char *yytext;
int var_count=0;
int ids_count=-1;
int polish_index=0;
struct_polish *polish;
struct_polish *last_element_polish;

char var_name[30][10];
char var_type[30][10];
char ids_type[30][10];

void add_var_symbol_table();
void validate_var_type(char *, char *);
int valid_type(char *, char *);
void save_type_id(char *);
void validate_assignament_type(char *);
void insert_polish(char *);
void create_intermediate_file();

%}
%union {
    char* str_value;
    float real_value;
    int int_value;
}

%type <str_value> ID ASSIGNMENT_OPERATOR STRING_CTE INT_CTE REAL_CTE
%type <str_value> ADDITION_OPERATOR SUBSTRACTION_OPERATOR MULTIPLICATION_OPERATOR DIVISION_OPERATOR CONCATENATION_OPERATOR
%type <str_value> GREATER_THAN_OPERATOR GREATER_EQUALS_OPERATOR SMALLER_THAN_OPERATOR SMALLER_EQUALS_OPERATOR EQUALS_OPERATOR NOT_EQUALS_OPERATOR

%token ID ASSIGNMENT_OPERATOR STRING_CTE INT_CTE REAL_CTE
%token ADDITION_OPERATOR SUBSTRACTION_OPERATOR MULTIPLICATION_OPERATOR DIVISION_OPERATOR CONCATENATION_OPERATOR
%token DIM OPEN_CLASP CLOSE_CLASP AS STRING_TYPE INTEGER_TYPE REAL_TYPE COMA_SEPARATOR
%token READ WRITE
%token OPEN_PARENTHESIS CLOSE_PARENTHESIS
%token ALL_EQUAL IGUALES
%token GREATER_THAN_OPERATOR GREATER_EQUALS_OPERATOR SMALLER_THAN_OPERATOR SMALLER_EQUALS_OPERATOR EQUALS_OPERATOR NOT_EQUALS_OPERATOR OR_OPERATOR AND_OPERATOR NOT
%token IF ELSE ENDIF WHILE ENDWHILE

%%

program:
      lines
        {
          LOG_MSG("\nCompilación exitosa\n");
        }

lines:
      declarations sentences
    | write_sentences

write_sentences:
      write
    | write_sentences write

sentences:
      sentences sentence
    | sentence

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

sentence:
      assignment
        {
          LOG_MSG("Asinación");
        }
    | if
        {
          LOG_MSG("Sentencia IF");
        }
    | if_else
        {
          LOG_MSG("Sentencia IF ELSE");
        }
    | while
        {
          LOG_MSG("Sentencia WHILE");
        }
    | read
        {
          LOG_MSG("Sentencia READ");
        }
    | write
        {
          LOG_MSG("Sentencia WRITE");
        }
    | iguales
        {
          LOG_MSG("Sentencia #IGUALES");
        }
    | all_equal
        {
          LOG_MSG("Sentencia ALLEQUALS");
        }

assignment:
      ID ASSIGNMENT_OPERATOR string_concatenation
        {
          validate_var_type($1, "STRING");
          insert_polish($1);
          insert_polish($2);
        }
    | ID ASSIGNMENT_OPERATOR expression
        {
          validate_assignament_type($1);
          insert_polish($1);
          insert_polish($2);
        }
    | ID ASSIGNMENT_OPERATOR SUBSTRACTION_OPERATOR factor
        {
          validate_var_type($1, "NUMBER");
          insert_polish($1);
          insert_polish($2);
        }

expressions:
      expression
        {
          LOG_MSG("Expresión");
        }
    | string_concatenation
        {
          LOG_MSG("Concatenacion de strings");
        }

expression:
      expression ADDITION_OPERATOR term
        {
          insert_polish($2);
        }
    | expression SUBSTRACTION_OPERATOR term
        {
          insert_polish($2);
        }
    | term

term:
      term MULTIPLICATION_OPERATOR factor
        {
          insert_polish($2);
        }
    | term DIVISION_OPERATOR factor
        {
          insert_polish($2);
        }
    | factor

factor:
      OPEN_PARENTHESIS SUBSTRACTION_OPERATOR factor CLOSE_PARENTHESIS
    | ID
        {
          save_type_id($1);
          insert_polish($1);
        }
    | INT_CTE
        {
          insert_polish($1);
        }
    | REAL_CTE
        {
          insert_polish($1);
        }
    | OPEN_PARENTHESIS expression CLOSE_PARENTHESIS

string_concatenation:
      STRING_CTE
        {
          insert_polish($1);
        }
    | STRING_CTE CONCATENATION_OPERATOR STRING_CTE
        {
          insert_polish($1);
          insert_polish($3);
          insert_polish($2);
        }
    | STRING_CTE CONCATENATION_OPERATOR ID
        {
          validate_var_type($3, "STRING");
          insert_polish($1);
          insert_polish($3);
          insert_polish($2);
        }
    | ID CONCATENATION_OPERATOR STRING_CTE
        {
          validate_var_type($1, "STRING");
          insert_polish($1);
          insert_polish($3);
          insert_polish($2);
        }
    | ID CONCATENATION_OPERATOR ID
        {
          validate_var_type($1, "STRING");
          validate_var_type($3, "STRING");
          insert_polish($1);
          insert_polish($3);
          insert_polish($2);
        }

comparation:
      expressions GREATER_EQUALS_OPERATOR expressions
        { 
          insert_polish("CMP");
          insert_polish("BLT");
        }
    | expressions GREATER_THAN_OPERATOR expressions
        { 
          insert_polish("CMP");
          insert_polish("BLE");
        }
    | expressions SMALLER_EQUALS_OPERATOR expressions
        { 
          insert_polish("CMP");
          insert_polish("BGT");
        }
    | expressions SMALLER_THAN_OPERATOR expressions
        { 
          insert_polish("CMP");
          insert_polish("BGE");
        }
    | expressions EQUALS_OPERATOR expressions
        { 
          insert_polish("CMP");
          insert_polish("BNE");
        }
    | expressions NOT_EQUALS_OPERATOR expressions
        { 
          insert_polish("CMP");
          insert_polish("BEQ");
        }
  
condition:
      comparation
    | comparation AND_OPERATOR comparation
    | comparation OR_OPERATOR comparation
    | NOT comparation
  
if:
      IF OPEN_PARENTHESIS condition CLOSE_PARENTHESIS sentences ENDIF
  
if_else:
      IF OPEN_PARENTHESIS condition CLOSE_PARENTHESIS sentences ELSE sentences ENDIF

while:
      WHILE OPEN_PARENTHESIS condition CLOSE_PARENTHESIS sentences ENDWHILE
  
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
    | WRITE ID
        {
          validate_var_type($2, "STRING");
        }

%%

int main(int argc,char *argv[]) {
  //Abro el archivo de entrada que se desea compilar
  if((yyin = fopen( argv[1], "rt")) == NULL) {
    printf("\nError al abrir %s\n", argv[1]);
    return -1;
  }

  //Borro la tabla de simbolos si existe 
  remove(SYMBOL_TABLE_FILE);
  
  //Metodo que recorre el archivo de entrada
  yyparse();

  //Genero el archivo intermedio
  create_intermediate_file();

  //Cierro el archivo
  fclose(yyin);
}

/*
 * Si hay un error de sintaxis, el analizador llamara a esta funcion
 * para generar una salida en pantalla mostrando el error  
 */
int yyerror(void) {
  printf("\n\nError de sintaxis\n");
  fclose(yyin);
  exit(1);
}

 /*
  * Agrega a la tabla de simbolos constantes enteras reales y strings
  */
void add_symbol_table(const char* token) {
  FILE *ts_file;
  char temp[512];
  char string_token[512] = "\0";

  //Abro el archivo de la tabla de simbolos
  if((ts_file = fopen(SYMBOL_TABLE_FILE, "a+")) == NULL) {
    printf("\nError al abrir tabla de simbolos %s\n", SYMBOL_TABLE_FILE);
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
  * Agrega a la tabla de simbolos las variables con sus tipos
  */
void add_var_symbol_table() {
  FILE *ts_file;
  char temp[512];
  int x = 0;

  //Abre la tabla de simbolos
  if((ts_file = fopen(SYMBOL_TABLE_FILE, "a+")) == NULL) {
    printf("\nError al abrir tabla de simbolos %s\n", SYMBOL_TABLE_FILE);
    exit(1);
  }


  for(x; x < var_count; x++) {
    //Si ya existe en la tabla de simbolos, lanzo un error
    while(fgets(temp, 512, ts_file) != NULL) {
      if((strcmp(strtok(temp, "|"), var_name[var_count-x-1])) == 0) {
        printf("\nLa variable %s ya se encuentra declarada\n", var_name[var_count-x-1]);
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

 /*
  * Valida que el tipo de asignacion sea correcto
  */
void validate_var_type(char * var_name, char * type) {
  FILE *ts_file;
  char temp[512];
  char is_valid_type = 2; //0 valido, 1 invalido, 2 no se encuentra declarada

  //Abre la tabla de simbolos
  if((ts_file = fopen(SYMBOL_TABLE_FILE, "rt")) == NULL) {
    printf("\nError al abrir tabla de simbolos %s\n", SYMBOL_TABLE_FILE);
    exit(1);
  }

  //Busco la variable en la tabla de simbolos
  while(fgets(temp, 512, ts_file) != NULL) {
    if((strcmp(strtok(temp, "|"), var_name)) == 0) {
      if(valid_type(type, strtok(NULL,"|")) == 0) {
        is_valid_type = 0; // Tipo valido
      } else {
        is_valid_type = 1; // Tipo no valido
      }
      break;
    }
  }

  // closes file
  fclose(ts_file); 

  //Si no es valido lanzo el mensaje de error correspondiente
  if(is_valid_type == 1) {
    printf("\nNo coinciden los tipos de datos\n");
    exit(1);
  } else if(is_valid_type == 2) {
    printf("\nLa variable %s no se encuentra declarada\n", var_name);
    exit(1);
  }

}

int valid_type(char * type, char * type_ts) {
  if( (strcmp(type, "STRING") == 0 && strcmp(type_ts, "string") == 0) 
     || (strcmp(type, "NUMBER") == 0 && strcmp(type_ts, "integer") == 0)
     || (strcmp(type, "NUMBER") == 0 && strcmp(type_ts, "real") == 0) ) {
    return 0;
  } else {
    return 1;
  }
}

void save_type_id(char *var_name) {
  FILE *ts_file;
  char temp[512];
  char is_valid_type = 1; //0 valido, 1 no se encuentra declarada

  //Abre la tabla de simbolos
  if((ts_file = fopen(SYMBOL_TABLE_FILE, "rt")) == NULL) {
    printf("\nError al abrir tabla de simbolos %s\n", SYMBOL_TABLE_FILE);
    exit(1);
  }

  //Busco la variable en la tabla de simbolos
  while(fgets(temp, 512, ts_file) != NULL) {
    if((strcmp(strtok(temp, "|"), var_name)) == 0) {
      ids_count++;
      if(strcmp(strtok(NULL,"|"), "string") == 0) {
        strcpy(ids_type[ids_count], "STRING");
      } else {
        strcpy(ids_type[ids_count], "NUMBER");
      }
      is_valid_type = 0; // Tipo valido
      break;
    }
  }

  // closes file
  fclose(ts_file); 

  //Si no es valido lanzo el mensaje de error correspondiente
  if(is_valid_type == 1) {
    printf("\nLa variable %s no se encuentra declarada\n", var_name);
    exit(1);
  }
}

void validate_assignament_type(char *var_name) {
  FILE *ts_file;
  char temp[512];
  char type[10];
  char is_valid_type = 1; //0 valido, 1 no se encuentra declarada
  int x = 0;

  //Abre la tabla de simbolos
  if((ts_file = fopen(SYMBOL_TABLE_FILE, "rt")) == NULL) {
    printf("\nError al abrir tabla de simbolos %s\n", SYMBOL_TABLE_FILE);
    exit(1);
  }

  //Busco la variable en la tabla de simbolos
  while(fgets(temp, 512, ts_file) != NULL) {
    if((strcmp(strtok(temp, "|"), var_name)) == 0) {
      if(strcmp(strtok(NULL,"|"), "string") == 0) {
        strcpy(type, "STRING");
      } else {
        strcpy(type, "NUMBER");
      }
      for(x; x <= ids_count; x++) {
        if(strcmp(type, ids_type[x]) != 0) {
          printf("\nNo coincide el tipo de datos con la variable en la asignación\n");
          exit(1);
        }
      }
      break;
    }
  }

  // closes file
  fclose(ts_file); 

  ids_count=-1;
}

void insert_polish(char * element) {
  struct_polish *p = malloc(sizeof(struct_polish)); 
  p->element = element;
  p->next = NULL;
  
  if(polish) {
    last_element_polish->next = p;
  } else {
    polish = p;
  }
    last_element_polish = p;
    polish_index++;
}

void create_intermediate_file() {
  FILE *code_file;
  struct_polish *p;
  //Abre el archivo de codigo intermedio
  if((code_file = fopen(CODE_FILE, "a+")) == NULL) {
    printf("\nError al abrir el archivo de codigo intermedio %s\n", CODE_FILE);
    exit(1);
  }

  p = polish;
  while(p) {
    fprintf(code_file, "%s\n", p->element);
    p = p->next;
  }

  // closes file
  fclose(code_file); 
}