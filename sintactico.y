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
#define ASSEMBLER_FILE "Final.asm"
#define LOGGER 1
#define STRING_MAX_LENGTH 31

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

typedef struct Branch {
  struct Branch *next;
  char *element;
  char *label;
} struct_branch;

typedef struct Stack {
  struct_polish *element;
  struct Stack *previous; 
} struct_stack;

typedef struct Sentence {
  struct Sentence *next;
  char *element;
  int index;
} struct_sentence;

FILE *yyin;
extern int yylineno;

struct_ts *ts = NULL;
struct_ts *last_ts = NULL;
int var_count = 0;
int types_validations_count = -1;
int polish_index = 1;
struct_polish *polish = NULL;
struct_polish *last_element_polish = NULL;
struct_stack *top_element_stack = NULL;
struct_polish *polish_stack = NULL;
struct_branch *condition_element = NULL;
struct_branch *last_condition_element = NULL;
struct_sentence *asm_sentence = NULL;
struct_sentence *last_asm_sentence = NULL;
struct_sentence *asm_bi = NULL;
struct_sentence *last_asm_bi = NULL;

char var_name[100][32];
char var_type[100][10];
char types_validations[30][10];

int all_equals_pivote_index = 1;
int all_equals_to_compare_index = 1;
int all_equals_stack = 0;
int comparation_count[100];
int nesting_count = 0;
int if_not = 0;
int iguales_index = 0;
int aux_var_counter = 0;
int string_counter = 1;
int conditional_counter = 0;
int branch_conditional_counter = 0;
int polish_element_evaluated_counter = 1;
int is_else_if = 0;

void validate_var_type(char *, char *, char *);
int valid_type(char *, char *);
void save_type_id(char *, char*);
void validate_assignament_type(char *, char *);
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
char *invert_comparator(char *);
void create_block_condition(char *);
int add_symbol_table(char *, char *, char *);
struct_ts *get_ts_element_by_name(char *);
struct_ts *get_ts_element_by_value(char *);
char *get_type_ts_by_name(char *);
void add_ts_element(char *, char *, char *);
char *replace_dot_with_underscore(char *);
void create_assembler_sentences();
void recognize_element(char *);
struct_polish *pop_polish_stack();
void push_polish_stack(char *);
void operation_asm(char *);
void write_asm();
void conditional_branch_asm(char *);
void create_auxiliar_var(char *);
void add_conditional_label();
void compare_asm();
void assignment_asm();
void inconditional_branch_if_asm(struct_polish *); 
char *get_conditional_label_by_position(char *);
void read_asm();
void concatenation_asm();
void insert_asm_sentence(char *);

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
          LOG_MSG("\n\nCompilación exitosa\n");
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
            int x = 0;
            for(x; x < var_count; x++) {
              int can_add = add_symbol_table(strdup(&var_name[var_count-x-1][0]), strdup(&var_type[x][0]), NULL);
              if(can_add == 0) {
                printf("\n\nLinea %d. La variable %s ya se encuentra declarada\n", yylineno, var_name[var_count-x-1]);
                exit(1);
              }
            }
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
        }
    | if
    | if_else
    | while
    | read
    | write

assignment:
      ID ASSIGNMENT_OPERATOR string_concatenation
        {
          LOG_MSG("\nRegla 10. assignment -> ID ASSIGNMENT_OPERATOR string_concatenation");
          char aux[40] = "_var_";
          strcat(aux, $1);
          validate_var_type(aux, "STRING", $1);
          insert_polish(strdup(&aux[0]));
          insert_polish($2);
        }
    | ID ASSIGNMENT_OPERATOR expression
        {
          LOG_MSG("\nRegla 10. assignment -> ID ASSIGNMENT_OPERATOR expression");
          char aux[40] = "_var_";
          strcat(aux, $1);
          validate_assignament_type(aux, $1);
          insert_polish(strdup(&aux[0]));
          insert_polish($2);
        }
    | ID ASSIGNMENT_OPERATOR SUBSTRACTION_OPERATOR factor
        {
          char aux[40] = "_var_";
          strcat(aux, $1);
          validate_var_type(aux, "NUMBER", $1);
          insert_polish(strdup(&aux[0]));
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
          char aux[40] = "_var_";
          strcat(aux, $1);
          save_type_id(aux, $1);
          insert_polish(strdup(&aux[0]));
        }
    | INT_CTE
        {
          types_validations_count++;
          strcpy(types_validations[types_validations_count], "NUMBER");
          struct_ts *p = get_ts_element_by_value($1);
          insert_polish(p->name);
        }
    | REAL_CTE
        {
          types_validations_count++;
          strcpy(types_validations[types_validations_count], "NUMBER");
          struct_ts *p = get_ts_element_by_value($1);
          insert_polish(p->name);
        }
    | OPEN_PARENTHESIS expression CLOSE_PARENTHESIS
    | iguales

string_concatenation:
      STRING_CTE
        {
          LOG_MSG("\nRegla 14. string_concatenation -> STRING_CTE");
          types_validations_count++;
          strcpy(types_validations[types_validations_count], "STRING");
          struct_ts *p = get_ts_element_by_value($1);
          insert_polish(strdup(p->name));
        }
    | STRING_CTE CONCATENATION_OPERATOR STRING_CTE
        {
          LOG_MSG("\nRegla 14. string_concatenation -> STRING_CTE CONCATENATION_OPERATOR STRING_CTE");
          struct_ts *p = get_ts_element_by_value($1);
          insert_polish(strdup(p->name));
          p = get_ts_element_by_value($3);
          insert_polish(strdup(p->name));
          insert_polish($2);
        }
    | STRING_CTE CONCATENATION_OPERATOR ID
        {
          LOG_MSG("\nRegla 14. string_concatenation -> STRING_CTE CONCATENATION_OPERATOR ID");
          char aux[40] = "_var_";
          strcat(aux, $3);
          validate_var_type(aux, "STRING", $3);
          struct_ts *p = get_ts_element_by_value($1);
          insert_polish(strdup(p->name));
          insert_polish(strdup(&aux[0]));
          insert_polish($2);
        }
    | ID CONCATENATION_OPERATOR STRING_CTE
        {
          LOG_MSG("\nRegla 14. string_concatenation -> ID CONCATENATION_OPERATOR STRING_CTE");
          char aux[40] = "_var_";
          strcat(aux, $1);
          validate_var_type(aux, "STRING", $1);
          insert_polish(strdup(&aux[0]));
          struct_ts *p = get_ts_element_by_value($3);
          insert_polish(strdup(p->name));
          insert_polish($2);
        }
    | ID CONCATENATION_OPERATOR ID
        {
          LOG_MSG("\nRegla 14. string_concatenation -> ID CONCATENATION_OPERATOR ID");
          char aux[40] = "_var_";
          strcat(aux, $1);
          validate_var_type(aux, "STRING", $1);
          char aux2[40] = "_var_";
          strcat(aux2, $3);
          validate_var_type(aux2, "STRING", $3);
          insert_polish(strdup(&aux[0]));
          insert_polish(strdup(&aux2[0]));
          insert_polish($2);
        }

if:
      IF OPEN_PARENTHESIS condition CLOSE_PARENTHESIS sentences ENDIF 
        {
          LOG_MSG("\nRegla 15. if -> IF OPEN_PARENTHESIS condition CLOSE_PARENTHESIS sentences ENDIF");
          char aux[10];
          int x = 0;
          nesting_count--;
          for(x; x < comparation_count[nesting_count]; x++) {
            struct_polish *p = pop_stack();
            sprintf(aux, "%d", polish_index);
            p->element = strdup(&aux[0]);
          }
        } 
 
if_else:
      IF OPEN_PARENTHESIS condition CLOSE_PARENTHESIS sentences 
        {
          char aux[10];
          int x = 0;
          nesting_count--;
          for(x; x < comparation_count[nesting_count]; x++) {
            struct_polish *p = pop_stack();
            sprintf(aux, "%d", polish_index + 2);
            p->element = strdup(&aux[0]);
          }
          insert_polish("");
          push_stack(last_element_polish);
          insert_polish("BI");
        } 
      ELSE sentences ENDIF
        {
          LOG_MSG("\nRegla 16. if_elsee -> IF OPEN_PARENTHESIS condition CLOSE_PARENTHESIS sentences ELSE sentences ENDIF");          
          char aux[10];
          struct_polish *p = pop_stack();
          sprintf(aux, "%d", polish_index);
          p->element = strdup(&aux[0]);
        } 
  
while:
      WHILE 
        {
          char aux[10];
          struct_polish *p = malloc(sizeof(struct_polish)); 
          sprintf(aux, "%d", polish_index);
          p->element = strdup(&aux[0]);
          push_stack(p);
        }
       OPEN_PARENTHESIS condition 
        {
          validate_condition_type();
        }
      CLOSE_PARENTHESIS sentences ENDWHILE 
        {
          LOG_MSG("\nRegla 17. while -> WHILE OPEN_PARENTHESIS condition CLOSE_PARENTHESIS sentences ENDWHILE");
          char aux[10];
          int x = 0;
          nesting_count--;
          for(x; x < comparation_count[nesting_count]; x++) {
            struct_polish *p = pop_stack();
            sprintf(aux, "%d", (polish_index+2));
            p->element = strdup(&aux[0]); //escribe pos de salto condicional
          }
          struct_polish *a = pop_stack();
          insert_polish(strdup(a->element));
          insert_polish("BI");
        } 

condition:
      comparation
        {
          comparation_count[nesting_count] = 1;
          nesting_count++;
        }
    | comparation AND_OPERATOR comparation
        {
          comparation_count[nesting_count] = 2;
          nesting_count++;
        }
    | comparation OR_OPERATOR comparation
        {
          char aux[10];
          struct_polish *pa = pop_stack();
          struct_polish *p = pop_stack();
          push_stack(pa);
          sprintf(aux, "%d", polish_index);
          p->element = strdup(&aux[0]);
          p->next->element = strdup(invert_comparator(p->next->element));
          comparation_count[nesting_count] = 1;
          nesting_count++;
        }
    | NOT 
        {
          if_not = 1;
        }
    comparation
        {
          comparation_count[nesting_count] = 1;
          nesting_count++;
          if_not = 0;
        }

comparation:
      expression GREATER_EQUALS_OPERATOR expression
        { 
          LOG_MSG("\nRegla 19. comparation -> expression GREATER_EQUALS_OPERATOR expression");
          validate_condition_type();
          create_block_condition("BLT");
        }
    | expression GREATER_THAN_OPERATOR expression
        { 
          LOG_MSG("\nRegla 19. comparation -> expression GREATER_THAN_OPERATOR expression");
          validate_condition_type();
          create_block_condition("BLE");
        }
    | expression SMALLER_EQUALS_OPERATOR expression
        { 
          LOG_MSG("\nRegla 19. comparation -> expression SMALLER_EQUALS_OPERATOR expression");
          validate_condition_type();
          create_block_condition("BGT");
        }
    | expression SMALLER_THAN_OPERATOR expression
        { 
          LOG_MSG("\nRegla 19. comparation -> expression SMALLER_THAN_OPERATOR expression");
          validate_condition_type();
          create_block_condition("BGE");
        }
    | expression EQUALS_OPERATOR expression
        { 
          LOG_MSG("\nRegla 19. comparation -> expression EQUALS_OPERATOR expression");
          validate_condition_type();
          create_block_condition("BNE");
        }
    | expression NOT_EQUALS_OPERATOR expression
        { 
          LOG_MSG("\nRegla 19. comparation -> expression NOT_EQUALS_OPERATOR expression");
          validate_condition_type();
          create_block_condition("BEQ");
        }
    | all_equal
        {
          LOG_MSG("\nRegla 19. comparation -> all_equal");
          add_symbol_table("1", "INT_CTE", "1");
          insert_polish("_int_1");
          create_block_condition("BNE");
          all_equals_pivote_index = 1;
        }
	  
all_equal:
      ALL_EQUAL
        {
          add_symbol_table("0", "INT_CTE", "0");
          insert_polish("_int_0");
          insert_polish("_allEqualsResults");
          insert_polish(":=");
          add_symbol_table("_allEqualsResults", "integer", NULL);
        }
      OPEN_PARENTHESIS OPEN_CLASP expression_list_all_equals_pivote CLOSE_CLASP COMA_SEPARATOR OPEN_CLASP expressions_list_all_equals_to_compare CLOSE_CLASP CLOSE_PARENTHESIS
        {
          LOG_MSG("\nRegla 20. all_equal -> ALL_EQUAL OPEN_PARENTHESIS OPEN_CLASP expression_list_all_equals_pivote CLOSE_CLASP COMA_SEPARATOR OPEN_CLASP expressions_list_all_equals_to_compare CLOSE_CLASP CLOSE_PARENTHESIS");
          char aux[10];
          int i = 0;
          for(i; i < all_equals_stack; i++) {
            struct_polish *p = pop_stack();
            sprintf(aux, "%d", (polish_index + 3));
            p->element = strdup(&aux[0]);
          }
          add_symbol_table("1", "INT_CTE", "1");
          insert_polish("_int_1");
          insert_polish("_allEqualsResults");
          insert_polish(":=");
          insert_polish("_allEqualsResults");
          all_equals_stack = 0;
        }

expressions_list_all_equals_to_compare:
      expressions_list_all_equals_to_compare CLOSE_CLASP COMA_SEPARATOR OPEN_CLASP
      expression_list_all_equals_to_compare
        {
          if(all_equals_to_compare_index < all_equals_pivote_index) {
            printf("\n\nLinea %d. La lista tiene menor cantidad de elementos que el pivote en all equals\n", yylineno);
            exit(1);
          }
          all_equals_to_compare_index = 1;
        }
    | expression_list_all_equals_to_compare
        {
          if(all_equals_to_compare_index < all_equals_pivote_index) {
            printf("\n\nLinea %d. La lista tiene menor cantidad de elementos que el pivote en all equals\n", yylineno);
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
            char aux[10], counter_name[15] = "_equalsCount";
            iguales_index++;
            sprintf(aux, "%d", iguales_index);
            strcat(counter_name, aux);
            insert_polish("_int_0");
            insert_polish(strdup(&counter_name[0]));
            insert_polish(":=");  
            add_symbol_table(&counter_name[0], "integer", NULL);
            add_symbol_table("0", "INT_CTE", "0");
            add_symbol_table("1", "INT_CTE", "1");
          }
      OPEN_PARENTHESIS expression
          {
            char aux[10], pivote_name[15] = "_equalsPivote";
            sprintf(aux, "%d", iguales_index);
            strcat(pivote_name, aux);
            insert_polish(strdup(&pivote_name[0]));
            insert_polish(":=");
            add_symbol_table(&pivote_name[0], "integer", NULL);
          } 
      COMA_SEPARATOR OPEN_CLASP expression_list_equals CLOSE_CLASP CLOSE_PARENTHESIS
          {
            LOG_MSG("\nRegla 24. iguales -> IGUALES OPEN_PARENTHESIS expression COMA_SEPARATOR OPEN_CLASP expression_list_equals CLOSE_CLASP CLOSE_PARENTHESIS");
            char aux[10], counter_name[15] = "_equalsCount";
            sprintf(aux, "%d", iguales_index);
            strcat(counter_name, aux);
            insert_polish(strdup(&counter_name[0]));
            iguales_index--;
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
          LOG_MSG("\nRegla 26. read -> READ ID");
          char aux[40] = "_var_";
          strcat(aux, $2);
          insert_polish(strdup(&aux[0]));
          insert_polish("READ");
          types_validations_count = -1;
        }

write:
      WRITE string_concatenation
        {
          LOG_MSG("\nRegla 27. write -> WRITE string_concatenation");
          insert_polish("WRITE");
          types_validations_count = -1;
        }
    | WRITE ID
        {
          LOG_MSG("\nRegla 27. write -> WRITE ID");
          char aux[40] = "_var_";
          strcat(aux, $2);
          insert_polish(strdup(&aux[0]));
          insert_polish("WRITE");
          types_validations_count = -1;
        }

%%

int main(int argc,char *argv[]) {
  //Abro el archivo de entrada que se desea compilar
  if((yyin = fopen( argv[1], "rt")) == NULL) {
    printf("\n\nError al abrir %s\n", argv[1]);
    return -1;
  }

  //Metodo que recorre el archivo de entrada
  yyparse();

  //Genero archivo assembler
  create_assembler_header();

  //Genero sentencias assembler
  create_assembler_sentences();

  //Genero el archivo de la tabla de simbolos
  create_ts_file();

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
  printf("\n\nLinea %d. Error de sintaxis.\n", yylineno);
  fclose(yyin);
  exit(1);
}

 /*
  * Valida que el tipo de asignacion sea correcto
  */
void validate_var_type(char * name, char * type, char *real_name) {
  struct_ts *p = get_ts_element_by_name(name);
  
  if(p == NULL) {
    printf("\n\nLinea %d. La variable %s no se encuentra declarada\n", yylineno, real_name);
    exit(1);
  } else if(valid_type(type, p->type) != 0) {
    printf("\n\nLinea %d. No coinciden los tipos de datos.\n", yylineno);
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

void save_type_id(char *var_name, char *real_name) {
  //Busco la variable en la tabla de simbolos
  struct_ts *p = get_ts_element_by_name(var_name);

  if(p == NULL) {
    printf("\n\nLinea %d. La variable %s no se encuentra declarada\n", yylineno, real_name);
    exit(1);
  }

  types_validations_count++;
  if(strcmp(p->type, "string") == 0) {
    strcpy(types_validations[types_validations_count], "STRING");
  } else {
    strcpy(types_validations[types_validations_count], "NUMBER");
  }
}

void create_ts_file() {
  FILE *ts_file;

  //Abre el archivo de tabl de simbolo
  if((ts_file = fopen(TS_FILE, "wt")) == NULL) {
    printf("\n\nError al abrir el archivo de tabla de simbolos %s\n", TS_FILE);
    exit(1);
  }  

  fprintf(ts_file, "             %-30s|       %-10s|                ", "Nombre", "Tipo");
  fprintf(ts_file, "%-19s|  %s\n", "Valor", "Longitud");
  fprintf(ts_file, "--------------------------------------------------------");
  fprintf(ts_file, "--------------------------------------------------------\n");
  while(ts) {
    if(ts->value) {
      fprintf(ts_file, "%-43s|  %-15s|  %-33s|  %d\n", ts->name, ts->type, ts->value, ts->length);
    } else {
      fprintf(ts_file, "%-43s|  %-15s|  %-33s|  %d\n", ts->name, ts->type, "", ts->length);
    }
    struct_ts *p = ts;
    ts = ts->next;
    free(p);
  }

  fclose(ts_file);
}

void validate_assignament_type(char *name, char *real_name) {
  char type[10];
  char is_valid_type = 1; //0 valido, 1 no se encuentra declarada
  int x = 0;

  //Busco la variable en la tabla de simbolos
  struct_ts *p = get_ts_element_by_name(name);

  if(p != NULL) {
    if(strcmp(p->type, "string") == 0) {
      strcpy(type, "STRING");
    } else {
      strcpy(type, "NUMBER");
    }
    for(x; x <= types_validations_count; x++) {
      if(strcmp(type, types_validations[x]) != 0) {
        printf("\n\nLinea %d. No coinciden los tipos de datos\n", yylineno);
        exit(1);
      }
    }
  } else {
    printf("\n\nLinea %d. La variable %s no se encuentra declarada\n", yylineno, real_name);
    exit(1);
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
  int pos = 1;
  //Abre el archivo de codigo intermedio
  if((code_file = fopen(CODE_FILE, "wt")) == NULL) {
    printf("\n\nError al abrir el archivo de codigo intermedio %s\n", CODE_FILE);
    exit(1);
  }

  next = polish;
  fprintf(code_file, "Posicion  |   Elemento\n");
  fprintf(code_file, "--------------------------\n");
  while(next) {
    fprintf(code_file, "%-10d|  %s\n", pos, next->element);
    pos++;
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
  char aux[10], pivote_name[15] = "_equalsPivote", counter_name[15] = "_equalsCount";
  sprintf(aux, "%d", iguales_index);
  strcat(pivote_name, aux);  
  strcat(counter_name, aux);  
  insert_polish(strdup(&pivote_name[0]));
  insert_polish("CMP");
  sprintf(aux, "%d", (polish_index + 7));
  insert_polish(strdup(&aux[0]));
  insert_polish("BNE");
  insert_polish("_int_1");
  insert_polish(strdup(&counter_name[0]));
  insert_polish("+");
  insert_polish(strdup(&counter_name[0]));
  insert_polish(":=");
}

void create_all_equals_pivote() {
  char str[10], aux[20] = "_allEqualsPivote";
  sprintf(str, "%d", all_equals_pivote_index);
  strcat(aux, str);
  insert_polish(strdup(&aux[0]));
  insert_polish(":=");
  add_symbol_table(&aux[0], "integer", NULL);
  all_equals_pivote_index++;
}

void create_all_equals_condition() {
  if(all_equals_to_compare_index >= all_equals_pivote_index) {
    printf("\n\nLinea %d. La lista tiene mayor cantidad de elementos que el pivote en all equals\n", yylineno);
    exit(1);
  }
  char str[10], aux[20] = "_allEqualsPivote";
  sprintf(str, "%d", all_equals_to_compare_index);
  strcat(aux, str);
  insert_polish(strdup(&aux[0]));
  insert_polish("CMP");
  insert_polish("");
  push_stack(last_element_polish);
  all_equals_stack++;
  insert_polish("BNE");
  add_symbol_table(&aux[0], "integer", NULL);
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

void validate_condition_type() {
  int x = 0;
  char type[10] = "NUMBER";
  for(x; x <= types_validations_count; x++) {
    if(strcmp(type, types_validations[x]) != 0) {
      printf("\n\nLinea %d. No es posible comparar datos del tipo string\n", yylineno);
      exit(1);
    }
  }
  
  types_validations_count = -1;
}

char * invert_comparator(char *comparator) {
  if(strcmp(comparator, "BEQ") == 0) return "BNE";
  if(strcmp(comparator, "BNE") == 0) return "BEQ";
  if(strcmp(comparator, "BGT") == 0) return "BLE";
  if(strcmp(comparator, "BGE") == 0) return "BLT";
  if(strcmp(comparator, "BLT") == 0) return "BGE";
  if(strcmp(comparator, "BLE") == 0) return "BGT"; 
}

void create_block_condition(char *comparator) {
  insert_polish("CMP");
  insert_polish("");
  push_stack(last_element_polish);
  if(if_not == 1) {
    insert_polish(strdup(invert_comparator(comparator)));
  } else {
    insert_polish(strdup(comparator));
  }
}

struct_ts *get_ts_element_by_name(char *name) {
  struct_ts *p = ts;
  while(p) {
    if(strcmp(p->name, name) == 0) {
      return p;
    }
    p = p->next;
  } 
  return NULL;
}

struct_ts *get_ts_element_by_value(char *value) {
  struct_ts *p = ts;
  while(p) {
    if(p->value != NULL && strcmp(p->value, value) == 0) {
      return p;
    }
    p = p->next;
  } 
  return NULL;
}

void add_ts_element(char * name, char *type, char *value) {
  struct_ts *aux = malloc(sizeof(struct_ts));
  aux->name = strdup(name);
  aux->type = strdup(type);

  if(value != NULL) {
    aux->value = strdup(value); 
  } else {
    aux->value = NULL;
  }
  if(strcmp("STRING_CTE", type) == 0) {
    aux->length = strlen(value);
    string_counter++;
  } else {
    aux->length = 0;
  }

  aux->next = NULL;

  if(ts) {
    last_ts->next = aux;
  } else {
    ts = aux;
  }

  last_ts = aux; 
}

int add_symbol_table(char *name, char* type, char *value) {
  char string_name[512] = "\0";
  char *name_aux;

  //Si no es un ID le coloco guion bajo con identificador
  if(strcmp("INT_CTE", type) == 0) {
    strcat(string_name, "_int_");
    strcat(string_name, name);
    name_aux = string_name;
  } else if(strcmp("REAL_CTE", type) == 0) {
    strcat(string_name, "_real_");
    strcat(string_name, name);
    name_aux = replace_dot_with_underscore(string_name);
  } else if(strcmp("STRING_CTE", type) == 0) {
    strcat(string_name, "_str_");
    sprintf(string_name, "%s%d", string_name, string_counter);
    name_aux = string_name;
  } else if(*(name+0) != '_' && *(name+0) != '@') {
    strcat(string_name, "_var_");
    strcat(string_name, name);
    name_aux = string_name;
  } else {
    strcat(string_name, name);
    name_aux = string_name;
  }

  if(get_ts_element_by_name(name_aux) == NULL) {
    add_ts_element(name_aux, type, value);
    return 1;
  } else {
    return 0;
  }
}

char *replace_dot_with_underscore(char * string) {
  int x = 0;
  for(x; x < strlen(string); x++) {
    if(string[x] == '.'){
      string[x] = '_';
    }
  } 
  return string;
}

void create_assembler_header() {
  FILE *assembler_file;
  char value[32];
  //Abre el archivo de assembler
  if((assembler_file = fopen(ASSEMBLER_FILE, "wt")) == NULL) {
    printf("\n\nError al abrir el archivo de assembler %s\n", ASSEMBLER_FILE);
    exit(1);
  }
  fprintf(assembler_file, "include macros2.asm\n");
  fprintf(assembler_file, "include number.asm\n\n");
  fprintf(assembler_file, ".MODEL \tLARGE\n");
  fprintf(assembler_file, ".386\n");
  fprintf(assembler_file, ".STACK \t200h\n\n");
  fprintf(assembler_file, ".DATA\n\n");
  fprintf(assembler_file, "\tSTRINGMAXLENGTH \tequ %d\n", STRING_MAX_LENGTH);
  fprintf(assembler_file, "\t@read_string \tdb 0Dh,0Ah,'$'\n");
  fprintf(assembler_file, "\t@concat_string \tdb STRINGMAXLENGTH dup(?),'$'\n");
  fprintf(assembler_file, "\t@NEWLINE \tdb 0Dh,0Ah,'$'\n\n");
  struct_ts *p = ts;

  while(p) {
    if(strcmp(p->type, "integer") == 0 || strcmp(p->type, "real") == 0 || strcmp(p->type, "string") == 0) {
      strcpy(value, "?");
    } else {
      strcpy(value, p->value);
    }
    if(strcmp(p->type, "integer") == 0 || strcmp(p->type, "INT_CTE") == 0
      || strcmp(p->type, "real") == 0 || strcmp(p->type, "REAL_CTE") == 0) {
      if(strcmp(value,"?") == 0) {
        fprintf(assembler_file, "\t%s \tdd %s\n", p->name, value);
      } else {
        fprintf(assembler_file, "\t%s \tdd %f\n", p->name, atof(value));
      }
    } else {
      if(strcmp(value,"?") == 0) {
        fprintf(assembler_file, "\t%s \tdb STRINGMAXLENGTH dup(?),'$'\n", p->name);
      } else {
        fprintf(assembler_file, "\t%s \tdb \"%s\",'$',%d dup(?)\n", p->name, value, (STRING_MAX_LENGTH - p->length));
      }
    }
    p = p->next;
  }

  fprintf(assembler_file, "\n");
  fclose(assembler_file);
}

void create_assembler_sentences() {
  struct_polish *p = polish;
  FILE *assembler_file;

  //Abre el archivo de assembler
  if((assembler_file = fopen(ASSEMBLER_FILE, "a")) == NULL) {
    printf("\n\nError al abrir el archivo de assembler %s\n", ASSEMBLER_FILE);
    exit(1);
  }

  fprintf(assembler_file, ".CODE\n");
  fprintf(assembler_file, "MAIN:\n");
  fprintf(assembler_file, "\tMOV \tAX, @DATA\n");
  fprintf(assembler_file, "\tMOV \tDS,AX\n");
  fprintf(assembler_file, "\tMOV \tES,AX\n\n");
  while(p) {
    recognize_element(p->element);
    polish_element_evaluated_counter++;
    p = p->next;
  }

  add_conditional_label();

  int x = 1;
  for(x; x <= aux_var_counter; x++) {
    fprintf(assembler_file, "\t@aux%d \tdq ?\n", x);
  }

  struct_sentence *s = asm_sentence;
  int last_element_evaluated = 0;
  while(s) {
    struct_sentence *sbi = asm_bi; 
    while(sbi) {
      if(asm_bi != NULL && last_element_evaluated != s->index && s->index == sbi->index) {
        fprintf(assembler_file, "%s", sbi->element);
        last_element_evaluated = s->index;
        break;
      }
      sbi = sbi->next;
    }
    if(s->element != NULL) {
      fprintf(assembler_file, "%s", s->element);
    }
    s = s->next;
  }

  fprintf(assembler_file, "\n\tMOV \tAX, 4C00h\n");
  fprintf(assembler_file, "\tINT \t21h\n\n");
  fprintf(assembler_file, "END MAIN");
  fclose(assembler_file);
}

void recognize_element(char *element) {
  add_conditional_label();

  if(strcmp(element, "+") == 0) {
    operation_asm("FADD");
  } else if(strcmp(element, "-") == 0) {
    operation_asm("FSUB");
  } else if(strcmp(element, "*") == 0) {
    operation_asm("FMUL");
  } else if(strcmp(element, "/") == 0) {
    operation_asm("FDIV");
  } else if(strcmp(element, ":=") == 0) {
    assignment_asm();
  } else if(strcmp(element, "++") == 0) {
    concatenation_asm();
  } else if(strcmp(element, "WRITE") == 0) {
    write_asm();
  } else if(strcmp(element, "READ") == 0) {
    read_asm();
  } else if(strcmp(element, "CMP") == 0) {
    compare_asm();
  } else if(strcmp(element, "BEQ") == 0) {
    conditional_branch_asm("JE");
  } else if(strcmp(element, "BNE") == 0) {
    conditional_branch_asm("JNE");
  } else if(strcmp(element, "BGT") == 0) {
    conditional_branch_asm("JB");
  } else if(strcmp(element, "BGE") == 0) {
    conditional_branch_asm("JBE");
  } else if(strcmp(element, "BLT") == 0) {
    conditional_branch_asm("JA");
  } else if(strcmp(element, "BLE") == 0) {
    conditional_branch_asm("JAE");
  } else if(strcmp(element, "BI") == 0) {
    struct_polish *aux = pop_polish_stack();
    if(atoi(aux->element) > polish_element_evaluated_counter) {
      inconditional_branch_if_asm(aux);
    } else {
      char lbl[20];
      struct_sentence *p = malloc(sizeof(struct_sentence)); 
      
      conditional_counter++;
      
      sprintf(lbl, "\nstart_while%d:\n\n", conditional_counter);
      p->element = strdup(&lbl[0]);
      p->index = atoi(aux->element);
      p->next = NULL;
      
      if(asm_bi) {
        last_asm_bi->next = p;
      } else {
        asm_bi = p;
      }

      last_asm_bi = p;
      
      char sentence[100];
      sprintf(sentence, "\tJMP \tstart_while%d\n", conditional_counter);
      insert_asm_sentence(strdup(&sentence[0]));
    }
    free(aux);
  } else {
    insert_asm_sentence(NULL);
    push_polish_stack(element);
  }
}

void push_polish_stack(char *element) {
  struct_polish *p = malloc(sizeof(struct_polish)); //new element
  p->element = element;
  if(polish_stack) {
    p->next = polish_stack;   
  } else {
    p->next = NULL;
  }
  polish_stack = p;  
}

struct_polish *pop_polish_stack() {
  struct_polish *p = polish_stack;
  polish_stack = polish_stack->next ;
  return p; 
}

void operation_asm(char *operator) {
  struct_polish *aux1 = pop_polish_stack();
  struct_polish *aux2 = pop_polish_stack();
  char sentence[100];

  sprintf(sentence, "\tFLD \t%s\n", aux2->element);
  insert_asm_sentence(strdup(&sentence[0]));
  sprintf(sentence, "\tFLD \t%s\n", aux1->element);
  insert_asm_sentence(strdup(&sentence[0]));
  sprintf(sentence, "\t%s\n", operator);
  insert_asm_sentence(strdup(&sentence[0]));
  char av[10];
  create_auxiliar_var(av);
  char *aux_var = strdup(&av[0]); 
  sprintf(sentence, "\tFSTP \t%s\n", aux_var);
  insert_asm_sentence(strdup(&sentence[0]));
  insert_asm_sentence("\tFFREE \tst(0)\n");
  free(aux1);
  free(aux2);
  push_polish_stack(aux_var);
}

void write_asm() {
  struct_polish *aux = pop_polish_stack();
  char *type = get_type_ts_by_name(aux->element);
  char sentence[100];
  if(strcmp(type, "INT") == 0) {
    sprintf(sentence, "\tDisplayFloat \t%s, 0\n", aux->element);
    insert_asm_sentence(strdup(&sentence[0]));
  } else if(strcmp(type, "REAL") == 0) {
    sprintf(sentence, "\tDisplayFloat \t%s, 2\n", aux->element);
    insert_asm_sentence(strdup(&sentence[0]));
  } else {
    sprintf(sentence, "\tMOV \tDX, OFFSET %s\n", aux->element);
    insert_asm_sentence(strdup(&sentence[0]));
    insert_asm_sentence("\tMOV \tah, 09\n");
    insert_asm_sentence("\tINT \t21h\n");
  }
  insert_asm_sentence("\tMOV \tDX, OFFSET @NEWLINE\n");
  insert_asm_sentence("\tMOV \tah, 09\n");
  insert_asm_sentence("\tINT \t21h\n");
}

void compare_asm() {
  char sentence[100];
  struct_polish *aux1 = pop_polish_stack();
  struct_polish *aux2 = pop_polish_stack();

  sprintf(sentence,"\tFLD \t%s\n", aux2->element);
  insert_asm_sentence(strdup(&sentence[0]));
  sprintf(sentence,"\tFLD \t%s\n", aux1->element);
  insert_asm_sentence(strdup(&sentence[0]));
  
  insert_asm_sentence("\tFCOMP\n");
  insert_asm_sentence("\tFSTSW \tax\n");
  insert_asm_sentence("\tSAHF\n");
}

void conditional_branch_asm(char *jump_type) {
  char sentence[100];
  struct_polish *aux = pop_polish_stack();
  char *lbl = get_conditional_label_by_position(aux->element);

  if(lbl != NULL) {
    sprintf(sentence,"\t%s \t%s\n\n", jump_type, lbl);
    insert_asm_sentence(strdup(&sentence[0]));
  } else {
    char label[40];
    branch_conditional_counter++;
    sprintf(label,"conditional_branch%d", branch_conditional_counter);
    sprintf(sentence,"\t%s \t%s\n\n", jump_type, label);
    insert_asm_sentence(strdup(&sentence[0]));

    struct_branch *p = malloc(sizeof(struct_branch));
    p->element = aux->element;
    p->label = strdup(&label[0]);
    if(condition_element) {
      last_condition_element->next = p;    
    } else {
      condition_element = p;
    }
    last_condition_element = p;
  }
}

void create_auxiliar_var(char * av) {
  char aux[10] = "@aux", aux_number[6];
  aux_var_counter++;
  sprintf(aux_number, "%d", aux_var_counter);
  strcat(aux, aux_number);
  strcpy(av, aux);
}

char *get_type_ts_by_name(char *element) {
  struct_ts *ts_element = get_ts_element_by_name(element);
  if(ts_element == NULL) return "STRING";
  if(strcmp(ts_element->type, "integer") == 0 || strcmp(ts_element->type, "INT_CTE") == 0) return "INT";
  if(strcmp(ts_element->type, "real") == 0 || strcmp(ts_element->type, "REAL_CTE") == 0) return "REAL";
  return "STRING";
}

void add_conditional_label() {
  struct_branch *p = condition_element;
  while(p) {
    if(atoi(p->element) == polish_element_evaluated_counter) {
      char sentence[100];
      sprintf(sentence, "\n%s:\n\n", p->label);
      insert_asm_sentence(strdup(&sentence[0]));
    }
    p = p->next;
  } 
}

char *get_conditional_label_by_position(char * element) {
  struct_branch *p = condition_element;
  while(p) {
    if(strcmp(p->element, element) == 0) {
      return p->label;
    }
    p = p->next;
  }  
  return NULL;
}

void assignment_asm() {
  struct_polish *aux1 = pop_polish_stack();
  struct_polish *aux2 = pop_polish_stack();
  char *type = get_type_ts_by_name(aux1->element);
  char sentence[100];

  if(strcmp(type, "STRING") == 0) {
    sprintf(sentence,"\tMOV \tSI,OFFSET %s\n", aux2->element);
    insert_asm_sentence(strdup(&sentence[0]));
    sprintf(sentence,"\tMOV \tDI,OFFSET %s\n", aux1->element);
    insert_asm_sentence(strdup(&sentence[0]));
    insert_asm_sentence("\tSTRCPY\n");
  } else {
    sprintf(sentence, "\tFLD \t%s\n", aux2->element);
    insert_asm_sentence(strdup(&sentence[0]));
    sprintf(sentence, "\tFSTP \t%s\n", aux1->element);
    insert_asm_sentence(strdup(&sentence[0]));
    insert_asm_sentence("\tFFREE \tst(0)\n");
  }
  
  free(aux1);
  free(aux2);
}

void inconditional_branch_if_asm(struct_polish *aux) {
  char label[40];
  struct_branch *p = malloc(sizeof(struct_branch));
  char sentence[100];

  branch_conditional_counter++;
  sprintf(label,"conditional_branch%d", branch_conditional_counter);
  sprintf(sentence,"\n\tJMP \t%s\n", label);
  insert_asm_sentence(strdup(&sentence[0]));

  p->element = aux->element;
  p->label = strdup(&label[0]);
  p->next = NULL;

  last_condition_element->next = p;    
  last_condition_element = p;
}

void read_asm() {
  struct_polish *aux = pop_polish_stack();
  char *type = get_type_ts_by_name(aux->element);
  char sentence[100];

  if(strcmp(type, "INT") == 0) {
    sprintf(sentence, "\tGetFloat \t%s\n", aux->element);
    insert_asm_sentence(strdup(&sentence[0]));
  } else if(strcmp(type, "REAL") == 0) {
    sprintf(sentence, "\tGetFloat \t%s\n", aux->element);
    insert_asm_sentence(strdup(&sentence[0]));
  } else if(strcmp(type, "STRING") == 0) {
      insert_asm_sentence("\tMOV byte ptr @read_string, 21\n");
      insert_asm_sentence("\tMOV DX, OFFSET @read_string\n");
      insert_asm_sentence("\tMOV ah, 0ah\n");
      insert_asm_sentence("\tINT 21h\n");
      insert_asm_sentence("\tMOV SI, 0002\n");
      insert_asm_sentence("\tLEA DX, @read_string[SI]\n");
      insert_asm_sentence("\tMOV SI, DX\n");
      sprintf(sentence, "\tMOV DI,OFFSET %s\n", aux->element);
      insert_asm_sentence(strdup(&sentence[0]));
      insert_asm_sentence("\tSTRCPY\n\n");
  }
}

void concatenation_asm() {
  struct_polish *aux1 = pop_polish_stack();
  struct_polish *aux2 = pop_polish_stack();
  char sentence[100];

  sprintf(sentence, "\tMOV SI, OFFSET %s\n", aux2->element);
  insert_asm_sentence(strdup(&sentence[0]));
  insert_asm_sentence("\tMOV DI, OFFSET @concat_string\n");
  insert_asm_sentence("\tSTRCPY\n");
  sprintf(sentence, "\tMOV SI, OFFSET %s\n", aux1->element);
  insert_asm_sentence(strdup(&sentence[0]));
  insert_asm_sentence("\tMOV DI, OFFSET @concat_string\n");
  insert_asm_sentence("\tSTRCAT\n");

  free(aux1);
  free(aux2);
  push_polish_stack("@concat_string");
}

void insert_asm_sentence(char * element) {
  struct_sentence *p = malloc(sizeof(struct_sentence)); 
  p->element = element;
  p->index = polish_element_evaluated_counter;
  p->next = NULL;
  
  if(asm_sentence) {
    last_asm_sentence->next = p;
  } else {
    asm_sentence = p;
  }

  last_asm_sentence = p;
}

//http://www2.dsu.nodak.edu/users/mberg/assembly/numbers/Numbers.html
//http://moisesrbb.tripod.com/unidad5.htm#u512