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
#include <string.h>
#include "y.tab.h"

#define TS_FILE "ts.txt"
#define CODE_FILE "intermedia.txt"
#define ASSEMBLER_FILE "Final.txt"
#define LOGGER 1

#if LOGGER
  #define LOG_MSG printf
#else
  #define LOG_MSG(...)
#endif

typedef struct Ts {
  struct Ts *next;
  char *name;
  char *type;
  char *value; 
  int length;
} struct_ts;

typedef struct Polish {
  struct Polish *next;
  char *element;
} struct_polish;

typedef struct Stack {
	struct_polish *element;
	struct Stack *previous; 
} struct_stack;

FILE  *yyin;
char *yytext;

struct_ts *ts = NULL;
struct_ts *last_ts = NULL;
int var_count = 0;
int types_validations_count = -1;
int polish_index = 1;
struct_polish *polish = NULL;
struct_polish *last_element_polish = NULL;
struct_stack *top_element_stack = NULL;

char var_name[30][10];
char var_type[30][10];
char types_validations[30][10];

int all_equals_pivote_index = 1;
int all_equals_to_compare_index = 1;
int all_equals_stack = 0;

void add_var_symbol_table();
void validate_var_type(char *, char *);
int valid_type(char *, char *);
void save_type_id(char *);
void validate_assignament_type(char *);
void insert_polish(char *);
void create_intermediate_file();
void create_equals_condition();
void create_all_equals_pivote();
void create_all_equals_condition();
void push_stack(struct_polish *); 
struct_polish *pop_stack();
void create_assembler_header();
void create_ts_file();  
void validate_condition_type();
%}
%union {
    char* str_value;
    float real_value;
    int int_value;
}

%type <str_value> ID ASSIGNMENT_OPERATOR STRING_CTE INT_CTE REAL_CTE STRING_TYPE INTEGER_TYPE REAL_TYPE
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
            strcpy(var_type[var_count], $1);
          }
    | INTEGER_TYPE
          {
            strcpy(var_type[var_count], $1);
          }
    | REAL_TYPE
          {
            strcpy(var_type[var_count], $1);
          }

sentence:
      assignment
        {
          types_validations_count = -1;
          LOG_MSG("Asignación");
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
    | all_equal
        {
          all_equals_pivote_index = 1;
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
    | ID ASSIGNMENT_OPERATOR iguales
        {
          validate_var_type($1, "NUMBER");
          LOG_MSG("Sentencia #IGUALES");
          insert_polish($1);
          insert_polish($2);
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
          types_validations_count++;
          strcpy(types_validations[types_validations_count], "NUMBER");
          insert_polish($1);
        }
    | REAL_CTE
        {
          types_validations_count++;
          strcpy(types_validations[types_validations_count], "NUMBER");
          insert_polish($1);
        }
    | OPEN_PARENTHESIS expression CLOSE_PARENTHESIS

string_concatenation:
      STRING_CTE
        {
          types_validations_count++;
          strcpy(types_validations[types_validations_count], "STRING");
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
      expression GREATER_EQUALS_OPERATOR expression
        { 
          insert_polish("CMP");
          insert_polish("");
          push_stack(last_element_polish);
          insert_polish("BLT");
        }
    | expression GREATER_THAN_OPERATOR expression
        { 
          insert_polish("CMP");
          insert_polish("");
          push_stack(last_element_polish);
          insert_polish("BLE");
        }
    | expression SMALLER_EQUALS_OPERATOR expression
        { 
          insert_polish("CMP");
          insert_polish("");
          push_stack(last_element_polish);
          insert_polish("BGT");
        }
    | expression SMALLER_THAN_OPERATOR expression
        { 
          insert_polish("CMP");
          insert_polish("");
          push_stack(last_element_polish);
          insert_polish("BGE");
        }
    | expression EQUALS_OPERATOR expression
        { 
          insert_polish("CMP");
          insert_polish("");
          push_stack(last_element_polish);
          insert_polish("BNE");
        }
    | expression NOT_EQUALS_OPERATOR expression
        { 
          insert_polish("CMP");
          insert_polish("");
          push_stack(last_element_polish);
          insert_polish("BEQ");
        }
  
condition:
      comparation
    | comparation AND_OPERATOR comparation
    | comparation OR_OPERATOR comparation
    | NOT comparation
 
if:
      IF OPEN_PARENTHESIS condition CLOSE_PARENTHESIS sentences {
		  char aux[10];
		  insert_polish("");
		  struct_polish *p = pop_stack();
          sprintf(aux, "%d", (polish_index));
		  p->element = strdup(&aux[0]);
		  push_stack(last_element_polish);	
	  } ENDIF
 
if_else:
      IF OPEN_PARENTHESIS condition CLOSE_PARENTHESIS sentences {
		  char aux[10];
		  insert_polish("");
		  struct_polish *p = pop_stack();
          sprintf(aux, "%d", (polish_index + 2));
		  p->element = strdup(&aux[0]);
		  push_stack(last_element_polish);
		  insert_polish("BI");
	  } ELSE sentences {
		  char aux[10];
		  insert_polish("");
		  struct_polish *p = pop_stack();
          sprintf(aux, "%d", (polish_index));
		  p->element = strdup(&aux[0]);
		  push_stack(last_element_polish);		  
	  } ENDIF
  
while:
      {
		  insert_polish("");
		  push_stack(last_element_polish);
	  } WHILE OPEN_PARENTHESIS condition CLOSE_PARENTHESIS sentences {
		  char aux[10];
		  insert_polish("");
		  struct_polish *p = pop_stack();
          sprintf(aux, "%d", (polish_index+2));
		  p->element = strdup(&aux[0]);
		  p = pop_stack();
          sprintf(aux, "%d", (polish_index));
		  p->element = strdup(&aux[0]);
		  insert_polish(p->element);
		  insert_polish("BI");
	  } ENDWHILE 

all_equal:
      ALL_EQUAL OPEN_PARENTHESIS OPEN_CLASP expression_list_all_equals_pivote CLOSE_CLASP COMA_SEPARATOR OPEN_CLASP expressions_list_all_equals_to_compare CLOSE_CLASP CLOSE_PARENTHESIS
        {
          char aux[10];
          int i = 0;
          for(i; i < all_equals_stack; i++) {
            struct_polish *p = pop_stack();
            sprintf(aux, "%d", (polish_index + 3));
            p->element = strdup(&aux[0]);
          }
          insert_polish("True");
          sprintf(aux, "%d", (polish_index + 3));
          insert_polish(strdup(&aux[0]));
          insert_polish("BI");
          insert_polish("False");
          all_equals_stack = 0;
        }

expressions_list_all_equals_to_compare:
      expressions_list_all_equals_to_compare CLOSE_CLASP COMA_SEPARATOR OPEN_CLASP
      expression_list_all_equals_to_compare
        {
          if(all_equals_to_compare_index < all_equals_pivote_index) {
            LOG_MSG("La lista tiene menor cantidad de elementos que el pivote en all equals\n");
            exit(1);
          }
          all_equals_to_compare_index = 1;
        }
    | expression_list_all_equals_to_compare
        {
          if(all_equals_to_compare_index < all_equals_pivote_index) {
            LOG_MSG("La lista tiene menor cantidad de elementos que el pivote en all equals\n");
            exit(1);
          }
          all_equals_to_compare_index = 1;
        }

expression_list_all_equals_to_compare:
      expression_list_all_equals_to_compare COMA_SEPARATOR expression
        {
          create_all_equals_condition();
        }
    | expression
        {
          create_all_equals_condition();
        }

expression_list_all_equals_pivote:
      expression_list_all_equals_pivote COMA_SEPARATOR expression
        {
          create_all_equals_pivote();
        }
    | expression
        {
          create_all_equals_pivote();
        }

iguales:
      IGUALES
          {
            insert_polish("0");
            insert_polish("_equalsCount");
            insert_polish(":=");  
          }
      OPEN_PARENTHESIS expression
          {
            insert_polish("_equalsPivot");
            insert_polish(":=");
          } 
      COMA_SEPARATOR OPEN_CLASP expression_list_equals CLOSE_CLASP CLOSE_PARENTHESIS
          {
            insert_polish("_equalsCount");
          }

expression_list_equals:
    | expression_list_equals COMA_SEPARATOR expression
        {
          create_equals_condition();
        }
    | expression
        {
          create_equals_condition();
        }
        
    
read:
      READ ID
        {
          insert_polish($2);
          insert_polish("READ");
          types_validations_count = -1;
        }

write:
      WRITE string_concatenation
        {
          insert_polish("WRITE");
          types_validations_count = -1;
        }
    | WRITE ID
        {
          insert_polish($2);
          insert_polish("WRITE");
          validate_var_type($2, "STRING");
          types_validations_count = -1;
        }

%%

int main(int argc,char *argv[]) {
  //Abro el archivo de entrada que se desea compilar
  if((yyin = fopen( argv[1], "rt")) == NULL) {
    printf("\nError al abrir %s\n", argv[1]);
    return -1;
  }

  //Metodo que recorre el archivo de entrada
  yyparse();

  //Genero el archivo de la tabla de simbolos
  create_ts_file();

  //Genero el archivo intermedio
  create_intermediate_file();

  create_assembler_header();
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
void add_symbol_table(char* token) {
  char string_token[512] = "\0";
  
  //Si no es un string, le coloco guion bajo delante
  if(strcmp("STRING_CTE", token) == 0) {
      yytext[strlen(yytext)-1] = '\0';
      yytext++;
  }
  strcpy(string_token, "_");

  //yytext tiene el lexema de la constante, lo concateno al guion bajo
  strcat(string_token, yytext);

  //Recorro el archivo para ver si ya fue ingresada la constante para no generar duplicados
  struct_ts *p = ts;
  while(p) {
    if(strcmp(p->name, string_token) == 0) {
      return;
    }
    p = p->next;
  }

  struct_ts *aux = malloc(sizeof(struct_ts));
  aux->name = strdup(&string_token[0]);
  aux->type = strdup(token);
  aux->value = strdup(yytext); 
  aux->length = 0;
  aux->next = NULL;

  if(ts) {
    last_ts->next = aux;
  } else {
    ts = aux;
  }

  last_ts = aux;
}

 /*
  * Agrega a la tabla de simbolos las variables con sus tipos
  */
void add_var_symbol_table() {
  int x = 0;

  for(x; x < var_count; x++) {
    //Si ya existe en la tabla de simbolos, lanzo un error
    struct_ts *p = ts;
    while(p != NULL) {
      if(strcmp(p->name, var_name[var_count-x-1]) == 0) {
        printf("\nLa variable %s ya se encuentra declarada\n", var_name[var_count-x-1]);
        exit(1);
      }
      p = p->next;
    }

    //Genero el registro en la tabla de simbolos
    struct_ts *aux = malloc(sizeof(struct_ts));
    aux->name = strdup(var_name[var_count-x-1]);
    aux->type = strdup(var_type[x]);
    aux->value = NULL;
    aux->length = 0; 
    aux->next = NULL;
    if(ts != NULL) {
      last_ts->next = aux;
    } else {
      ts = aux;
    }
    last_ts = aux;
  }
}

 /*
  * Valida que el tipo de asignacion sea correcto
  */
void validate_var_type(char * var_name, char * type) {
  char is_valid_type = 2; //0 valido, 1 invalido, 2 no se encuentra declarada

  //Busco la variable en la tabla de simbolos
  struct_ts *p = ts;
  while(p) {
    if(strcmp(p->name, var_name) == 0) {
      if(valid_type(type, p->type) == 0) {
        is_valid_type = 0; // Tipo valido
      } else {
        is_valid_type = 1; // Tipo no valido
      }
      break;
    }
    p = p->next;
  }

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
  char is_valid_type = 1; //0 valido, 1 no se encuentra declarada

  //Busco la variable en la tabla de simbolos
  struct_ts *p = ts;
  while(p) {
    if(strcmp(p->name, var_name) == 0) {
      types_validations_count++;
      if(strcmp(p->type, "string") == 0) {
        strcpy(types_validations[types_validations_count], "STRING");
      } else {
        strcpy(types_validations[types_validations_count], "NUMBER");
      }
      is_valid_type = 0; // Tipo valido
      break;
    }
    p = p->next;
  }

  //Si no es valido lanzo el mensaje de error correspondiente
  if(is_valid_type == 1) {
    printf("\nLa variable %s no se encuentra declarada\n", var_name);
    exit(1);
  }
}

void create_ts_file() {
  FILE *ts_file;

  //Abre el archivo de tabl de simbolo
  if((ts_file = fopen(TS_FILE, "wt")) == NULL) {
    printf("\nError al abrir el archivo de tabla de simbolos %s\n", TS_FILE);
    exit(1);
  }  

  fprintf(ts_file, "             %-20s|       %-10s|                ", "Nombre", "Tipo");
  fprintf(ts_file, "%-19s|  %s\n", "Valor", "Longitud");
  fprintf(ts_file, "----------------------------------------------------");
  fprintf(ts_file, "---------------------------------------------------\n");
  while(ts) {
    if(ts->value) {
      fprintf(ts_file, "%-33s|  %-15s|  %-33s|  %d\n", ts->name, ts->type, ts->value, ts->length);
    } else {
      fprintf(ts_file, "%-33s|  %-15s|  %-33s|  %d\n", ts->name, ts->type, "", ts->length);
    }
    struct_ts *p = ts;
    ts = ts->next;
    free(p);
  }

  fclose(ts_file);
}

void validate_assignament_type(char *var_name) {
  char type[10];
  char is_valid_type = 1; //0 valido, 1 no se encuentra declarada
  int x = 0;

  //Busco la variable en la tabla de simbolos
  struct_ts *p = ts;
  while(p) {
    if(strcmp(p->name, var_name) == 0) {
      if(strcmp(p->type, "string") == 0) {
        strcpy(type, "STRING");
      } else {
        strcpy(type, "NUMBER");
      }
      for(x; x <= types_validations_count; x++) {
        printf("%s - %s", type, types_validations[x]); 
        if(strcmp(type, types_validations[x]) != 0) {
          printf("\nNo coincide el tipo de datos con la variable en la asignación\n");
          exit(1);
        }
      }
      break;
    }
    p = p->next;
  }

  types_validations_count = -1;
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
  struct_polish *p, *next;
  //Abre el archivo de codigo intermedio
  if((code_file = fopen(CODE_FILE, "wt")) == NULL) {
    printf("\nError al abrir el archivo de codigo intermedio %s\n", CODE_FILE);
    exit(1);
  }

  next = polish;
  while(next) {
    fprintf(code_file, "%s\n", next->element);
    p = next;
    next = next->next;
    free(p);
  }

  polish = NULL;
  last_element_polish = NULL;

  // closes file
  fclose(code_file); 
}

void create_equals_condition() {
  char aux[10];
  insert_polish("_igualesPivot");
  insert_polish("CMP");
  sprintf(aux, "%d", (polish_index + 7));
  insert_polish(strdup(&aux[0]));
  insert_polish("BNE");
  insert_polish("1");
  insert_polish("+");
  insert_polish("_equalsCount");
  insert_polish("_equalsCount");
  insert_polish(":=");
}

void create_all_equals_pivote() {
  char str[10], aux[20] = "_allEqualsPivot";
  sprintf(str, "%d", all_equals_pivote_index);
  strcat(aux, str);
  insert_polish(strdup(&aux[0]));
  insert_polish(":=");
  all_equals_pivote_index++;
}

void create_all_equals_condition() {
  if(all_equals_to_compare_index >= all_equals_pivote_index) {
    LOG_MSG("La lista tiene mayor cantidad de elementos que el pivote en all equals\n");
    exit(1);
  }
  char str[10], aux[20] = "_allEqualsPivot";
  sprintf(str, "%d", all_equals_to_compare_index);
  strcat(aux, str);
  insert_polish(strdup(&aux[0]));
  insert_polish("CMP");
  insert_polish("");
  push_stack(last_element_polish);
  all_equals_stack++;
  insert_polish("BNE");
  all_equals_to_compare_index++;  
}

void push_stack(struct_polish *element) {
  struct_stack *ne = malloc(sizeof(struct_stack)); //new element
  ne->element = element;
  if(top_element_stack) {
    ne->previous = top_element_stack;		
  } else {
    ne->previous = NULL;
  }
  top_element_stack = ne;
}

struct_polish *pop_stack() {
  struct_stack * aux;
  struct_polish * top = top_element_stack->element;
  aux = top_element_stack;
  top_element_stack = top_element_stack->previous;
  free(aux);
  return top;
}

void create_assembler_header() {
  FILE *assembler_file;
 
  //Abre el archivo de assembler
  if((assembler_file = fopen(ASSEMBLER_FILE, "wt")) == NULL) {
    printf("\nError al abrir el archivo de assembler %s\n", ASSEMBLER_FILE);
    exit(1);
  }
  
  fprintf(assembler_file, ".MODEL LARGE\n");
  fprintf(assembler_file, ".386\n");
  fprintf(assembler_file, ".STACK 200h\n\n");
  fprintf(assembler_file, ".DATA\n");

  struct_ts *p = ts;

}

void validate_conditions_types() {
  int x = 0;
  char type[10] = "NUMBER";
  for(x; x <= types_validations_count; x++) {
    printf("%s - %s", type, types_validations[x]); 
    if(strcmp(type, types_validations[x]) != 0) {
      printf("\nNo coincide el tipo de datos con la variable en la asignación\n");
      exit(1);
    }
  }
  
  types_validations_count = -1;
}