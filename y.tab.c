
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.4.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Copy the first part of user declarations.  */

/* Line 189 of yacc.c  */
#line 8 "sintactico.y"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"

#define TS_FILE "ts.txt"
#define CODE_FILE "intermedia.txt"
#define ASSEMBLER_FILE "Final.txt"
#define LOGGER 1
#define STRING_MAX_LENGTH 30

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
extern int yylineno;

struct_ts *ts = NULL;
struct_ts *last_ts = NULL;
int var_count = 0;
int types_validations_count = -1;
int polish_index = 1;
struct_polish *polish = NULL;
struct_polish *last_element_polish = NULL;
struct_stack *top_element_stack = NULL;

char var_name[100][32];
char var_type[100][10];
char types_validations[30][10];

int all_equals_pivote_index = 1;
int all_equals_to_compare_index = 1;
int all_equals_stack = 0;
char while_start[10];
int comparation_number;
int lines = 1;

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


/* Line 189 of yacc.c  */
#line 151 "y.tab.c"

/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     ID = 258,
     ASSIGNMENT_OPERATOR = 259,
     STRING_CTE = 260,
     INT_CTE = 261,
     REAL_CTE = 262,
     ADDITION_OPERATOR = 263,
     SUBSTRACTION_OPERATOR = 264,
     MULTIPLICATION_OPERATOR = 265,
     DIVISION_OPERATOR = 266,
     CONCATENATION_OPERATOR = 267,
     DIM = 268,
     OPEN_CLASP = 269,
     CLOSE_CLASP = 270,
     AS = 271,
     STRING_TYPE = 272,
     INTEGER_TYPE = 273,
     REAL_TYPE = 274,
     COMA_SEPARATOR = 275,
     READ = 276,
     WRITE = 277,
     OPEN_PARENTHESIS = 278,
     CLOSE_PARENTHESIS = 279,
     ALL_EQUAL = 280,
     IGUALES = 281,
     GREATER_THAN_OPERATOR = 282,
     GREATER_EQUALS_OPERATOR = 283,
     SMALLER_THAN_OPERATOR = 284,
     SMALLER_EQUALS_OPERATOR = 285,
     EQUALS_OPERATOR = 286,
     NOT_EQUALS_OPERATOR = 287,
     OR_OPERATOR = 288,
     AND_OPERATOR = 289,
     NOT = 290,
     IF = 291,
     ELSE = 292,
     ENDIF = 293,
     WHILE = 294,
     ENDWHILE = 295
   };
#endif
/* Tokens.  */
#define ID 258
#define ASSIGNMENT_OPERATOR 259
#define STRING_CTE 260
#define INT_CTE 261
#define REAL_CTE 262
#define ADDITION_OPERATOR 263
#define SUBSTRACTION_OPERATOR 264
#define MULTIPLICATION_OPERATOR 265
#define DIVISION_OPERATOR 266
#define CONCATENATION_OPERATOR 267
#define DIM 268
#define OPEN_CLASP 269
#define CLOSE_CLASP 270
#define AS 271
#define STRING_TYPE 272
#define INTEGER_TYPE 273
#define REAL_TYPE 274
#define COMA_SEPARATOR 275
#define READ 276
#define WRITE 277
#define OPEN_PARENTHESIS 278
#define CLOSE_PARENTHESIS 279
#define ALL_EQUAL 280
#define IGUALES 281
#define GREATER_THAN_OPERATOR 282
#define GREATER_EQUALS_OPERATOR 283
#define SMALLER_THAN_OPERATOR 284
#define SMALLER_EQUALS_OPERATOR 285
#define EQUALS_OPERATOR 286
#define NOT_EQUALS_OPERATOR 287
#define OR_OPERATOR 288
#define AND_OPERATOR 289
#define NOT 290
#define IF 291
#define ELSE 292
#define ENDIF 293
#define WHILE 294
#define ENDWHILE 295




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 214 of yacc.c  */
#line 84 "sintactico.y"

    char* str_value;
    float real_value;
    int int_value;



/* Line 214 of yacc.c  */
#line 275 "y.tab.c"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif


/* Copy the second part of user declarations.  */


/* Line 264 of yacc.c  */
#line 287 "y.tab.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int yyi)
#else
static int
YYID (yyi)
    int yyi;
#endif
{
  return yyi;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)				\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack_alloc, Stack, yysize);			\
	Stack = &yyptr->Stack_alloc;					\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  13
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   161

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  41
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  36
/* YYNRULES -- Number of rules.  */
#define YYNRULES  78
/* YYNRULES -- Number of states.  */
#define YYNSTATES  149

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   295

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint16 yyprhs[] =
{
       0,     0,     3,     5,     8,    10,    12,    15,    18,    20,
      23,    25,    30,    36,    42,    44,    46,    48,    50,    52,
      54,    56,    58,    60,    62,    66,    70,    75,    79,    83,
      87,    89,    93,    97,    99,   104,   106,   108,   110,   114,
     116,   120,   124,   128,   132,   136,   140,   144,   148,   152,
     156,   158,   162,   166,   169,   170,   178,   179,   180,   191,
     192,   193,   194,   204,   215,   221,   223,   227,   229,   233,
     235,   236,   237,   248,   249,   253,   255,   258,   261
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      42,     0,    -1,    43,    -1,    46,    45,    -1,    44,    -1,
      76,    -1,    44,    76,    -1,    45,    50,    -1,    50,    -1,
      46,    47,    -1,    47,    -1,    13,    14,    48,    15,    -1,
       3,    15,    16,    14,    49,    -1,     3,    20,    48,    20,
      49,    -1,    17,    -1,    18,    -1,    19,    -1,    51,    -1,
      58,    -1,    60,    -1,    63,    -1,    75,    -1,    76,    -1,
      67,    -1,     3,     4,    55,    -1,     3,     4,    52,    -1,
       3,     4,     9,    54,    -1,     3,     4,    71,    -1,    52,
       8,    53,    -1,    52,     9,    53,    -1,    53,    -1,    53,
      10,    54,    -1,    53,    11,    54,    -1,    54,    -1,    23,
       9,    54,    24,    -1,     3,    -1,     6,    -1,     7,    -1,
      23,    52,    24,    -1,     5,    -1,     5,    12,     5,    -1,
       5,    12,     3,    -1,     3,    12,     5,    -1,     3,    12,
       3,    -1,    52,    28,    52,    -1,    52,    27,    52,    -1,
      52,    30,    52,    -1,    52,    29,    52,    -1,    52,    31,
      52,    -1,    52,    32,    52,    -1,    56,    -1,    56,    34,
      56,    -1,    56,    33,    56,    -1,    35,    56,    -1,    -1,
      36,    23,    57,    24,    45,    59,    38,    -1,    -1,    -1,
      36,    23,    57,    24,    45,    61,    37,    45,    62,    38,
      -1,    -1,    -1,    -1,    39,    64,    23,    57,    65,    24,
      45,    66,    40,    -1,    25,    23,    14,    70,    15,    20,
      14,    68,    15,    24,    -1,    68,    15,    20,    14,    69,
      -1,    69,    -1,    69,    20,    52,    -1,    52,    -1,    70,
      20,    52,    -1,    52,    -1,    -1,    -1,    26,    72,    23,
      52,    73,    20,    14,    74,    15,    24,    -1,    -1,    74,
      20,    52,    -1,    52,    -1,    21,     3,    -1,    22,    55,
      -1,    22,     3,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   106,   106,   112,   113,   116,   117,   120,   121,   124,
     125,   128,   135,   140,   147,   151,   155,   161,   166,   170,
     174,   178,   182,   186,   193,   199,   205,   211,   220,   224,
     228,   231,   235,   239,   242,   243,   248,   254,   260,   263,
     269,   275,   282,   289,   299,   307,   315,   323,   331,   339,
     349,   353,   357,   361,   369,   368,   382,   395,   381,   406,
     410,   414,   405,   428,   446,   455,   465,   469,   475,   479,
     486,   492,   485,   501,   502,   506,   513,   521,   526
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "ID", "ASSIGNMENT_OPERATOR",
  "STRING_CTE", "INT_CTE", "REAL_CTE", "ADDITION_OPERATOR",
  "SUBSTRACTION_OPERATOR", "MULTIPLICATION_OPERATOR", "DIVISION_OPERATOR",
  "CONCATENATION_OPERATOR", "DIM", "OPEN_CLASP", "CLOSE_CLASP", "AS",
  "STRING_TYPE", "INTEGER_TYPE", "REAL_TYPE", "COMA_SEPARATOR", "READ",
  "WRITE", "OPEN_PARENTHESIS", "CLOSE_PARENTHESIS", "ALL_EQUAL", "IGUALES",
  "GREATER_THAN_OPERATOR", "GREATER_EQUALS_OPERATOR",
  "SMALLER_THAN_OPERATOR", "SMALLER_EQUALS_OPERATOR", "EQUALS_OPERATOR",
  "NOT_EQUALS_OPERATOR", "OR_OPERATOR", "AND_OPERATOR", "NOT", "IF",
  "ELSE", "ENDIF", "WHILE", "ENDWHILE", "$accept", "program", "lines",
  "write_sentences", "sentences", "declarations", "declaration",
  "declaration_list", "variable_type", "sentence", "assignment",
  "expression", "term", "factor", "string_concatenation", "comparation",
  "condition", "if", "$@1", "if_else", "$@2", "$@3", "while", "$@4", "$@5",
  "$@6", "all_equal", "expressions_list_all_equals_to_compare",
  "expression_list_all_equals_to_compare",
  "expression_list_all_equals_pivote", "iguales", "$@7", "$@8",
  "expression_list_equals", "read", "write", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    41,    42,    43,    43,    44,    44,    45,    45,    46,
      46,    47,    48,    48,    49,    49,    49,    50,    50,    50,
      50,    50,    50,    50,    51,    51,    51,    51,    52,    52,
      52,    53,    53,    53,    54,    54,    54,    54,    54,    55,
      55,    55,    55,    55,    56,    56,    56,    56,    56,    56,
      57,    57,    57,    57,    59,    58,    61,    62,    60,    64,
      65,    66,    63,    67,    68,    68,    69,    69,    70,    70,
      72,    73,    71,    74,    74,    74,    75,    76,    76
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     2,     1,     1,     2,     2,     1,     2,
       1,     4,     5,     5,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     3,     3,     4,     3,     3,     3,
       1,     3,     3,     1,     4,     1,     1,     1,     3,     1,
       3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
       1,     3,     3,     2,     0,     7,     0,     0,    10,     0,
       0,     0,     9,    10,     5,     1,     3,     1,     3,     1,
       0,     0,    10,     0,     3,     1,     2,     2,     2
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,     0,     2,     4,     0,    10,     5,     0,
      78,    39,    77,     1,     6,     0,     0,     0,     0,    59,
       3,     9,     8,    17,    18,    19,    20,    23,    21,    22,
       0,     0,     0,     0,     0,    76,     0,     0,     0,     7,
       0,     0,    11,    43,    42,    41,    40,    35,    36,    37,
       0,     0,    70,    25,    30,    33,    24,    27,     0,    35,
       0,     0,    50,     0,     0,     0,     0,    26,     0,     0,
       0,     0,     0,     0,     0,    69,     0,    53,     0,     0,
       0,     0,     0,     0,     0,     0,     0,    60,     0,     0,
       0,    38,     0,    28,    29,    31,    32,     0,     0,    45,
      44,    47,    46,    48,    49,    52,    51,    54,     0,    14,
      15,    16,    12,    13,    34,    71,     0,    68,     0,     0,
       0,     0,     0,    55,     0,    61,     0,    67,     0,    65,
      57,     0,    73,     0,     0,     0,    62,    75,     0,     0,
      63,    66,    58,     0,     0,     0,    72,    74,    64
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     3,     4,     5,    20,     6,     7,    31,   112,    22,
      23,    61,    54,    55,    12,    62,    63,    24,   118,    25,
     119,   135,    26,    38,   108,   131,    27,   128,   129,    76,
      57,    70,   121,   138,    28,    29
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -86
static const yytype_int8 yypact[] =
{
      20,    -6,    58,    11,   -86,    -4,     1,   -86,   -86,    66,
      43,    75,   -86,   -86,   -86,    88,    92,    82,    97,   -86,
      31,   -86,   -86,   -86,   -86,   -86,   -86,   -86,   -86,   -86,
      -5,   106,    81,   101,    68,   -86,   108,     6,   102,   -86,
     107,    66,   -86,   -86,   -86,   -86,   -86,    43,   -86,   -86,
      13,    90,   -86,   100,   104,   -86,   -86,   -86,    13,   -86,
      13,    51,    83,   103,     6,   110,   109,   -86,    13,    -3,
     105,    13,    13,    13,    13,   100,    23,   -86,    13,    13,
      13,    13,    13,    13,    13,    13,    31,   -86,    84,    84,
     111,   -86,    13,   104,   104,   -86,   -86,   112,    13,   100,
     100,   100,   100,   100,   100,   -86,   -86,    29,   113,   -86,
     -86,   -86,   -86,   -86,   -86,   100,   116,   100,    93,    89,
      31,   114,    13,   -86,    31,    31,   119,   100,   121,   118,
      31,    99,    13,    52,    13,   115,   -86,   100,    42,   126,
     -86,   100,   -86,   117,    13,    13,   -86,   100,   118
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -86,   -86,   -86,   -86,   -85,   -86,   136,   120,    54,   -18,
     -86,   -34,    47,   -43,   122,   -57,    80,   -86,   -86,   -86,
     -86,   -86,   -86,   -86,   -86,   -86,   -86,   -86,     0,   -86,
     -86,   -86,   -86,   -86,   -86,    85
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -57
static const yytype_int16 yytable[] =
{
      53,   107,    39,    77,    15,    71,    72,    67,     9,    59,
      40,    13,    48,    49,     1,    41,    59,    69,     2,    48,
      49,    91,    16,     2,    75,    90,    17,   105,   106,    51,
      95,    96,    15,     1,    15,   125,    51,    18,    97,   130,
      19,    60,     2,    98,    99,   100,   101,   102,   103,   104,
      16,     2,    16,     2,    17,    32,    17,   143,   115,    71,
      72,    10,   144,    11,   117,    18,   -56,    18,    19,    30,
      19,    47,   139,    11,    48,    49,   140,    50,    78,    79,
      80,    81,    82,    83,    43,     8,    44,    33,   127,    39,
      14,    51,    34,    59,    52,    35,    48,    49,   137,    68,
     141,   109,   110,   111,    45,    36,    46,    39,    71,    72,
     147,   127,    39,    51,    73,    74,    84,    85,    93,    94,
      37,    42,    58,    65,    88,    64,   124,    86,    92,    89,
     122,   123,   116,   132,   126,   114,   133,   120,   134,   136,
     145,   146,    21,   113,    87,   148,     0,     0,     0,     0,
       0,     0,     0,   142,     0,     0,    56,     0,     0,     0,
       0,    66
};

static const yytype_int16 yycheck[] =
{
      34,    86,    20,    60,     3,     8,     9,    50,    14,     3,
      15,     0,     6,     7,    13,    20,     3,    51,    22,     6,
       7,    24,    21,    22,    58,    68,    25,    84,    85,    23,
      73,    74,     3,    13,     3,   120,    23,    36,    15,   124,
      39,    35,    22,    20,    78,    79,    80,    81,    82,    83,
      21,    22,    21,    22,    25,    12,    25,    15,    92,     8,
       9,     3,    20,     5,    98,    36,    37,    36,    39,     3,
      39,     3,    20,     5,     6,     7,    24,     9,    27,    28,
      29,    30,    31,    32,     3,     0,     5,    12,   122,   107,
       5,    23,     4,     3,    26,     3,     6,     7,   132,     9,
     134,    17,    18,    19,     3,    23,     5,   125,     8,     9,
     144,   145,   130,    23,    10,    11,    33,    34,    71,    72,
      23,    15,    14,    16,    14,    23,    37,    24,    23,    20,
      14,    38,    20,    14,    20,    24,    15,    24,    20,    40,
      14,    24,     6,    89,    64,   145,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    38,    -1,    -1,    34,    -1,    -1,    -1,
      -1,    41
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    13,    22,    42,    43,    44,    46,    47,    76,    14,
       3,     5,    55,     0,    76,     3,    21,    25,    36,    39,
      45,    47,    50,    51,    58,    60,    63,    67,    75,    76,
       3,    48,    12,    12,     4,     3,    23,    23,    64,    50,
      15,    20,    15,     3,     5,     3,     5,     3,     6,     7,
       9,    23,    26,    52,    53,    54,    55,    71,    14,     3,
      35,    52,    56,    57,    23,    16,    48,    54,     9,    52,
      72,     8,     9,    10,    11,    52,    70,    56,    27,    28,
      29,    30,    31,    32,    33,    34,    24,    57,    14,    20,
      54,    24,    23,    53,    53,    54,    54,    15,    20,    52,
      52,    52,    52,    52,    52,    56,    56,    45,    65,    17,
      18,    19,    49,    49,    24,    52,    20,    52,    59,    61,
      24,    73,    14,    38,    37,    45,    20,    52,    68,    69,
      45,    66,    14,    15,    20,    62,    40,    52,    74,    20,
      24,    52,    38,    15,    20,    14,    24,    52,    69
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
#else
static void
yy_stack_print (yybottom, yytop)
    yytype_int16 *yybottom;
    yytype_int16 *yytop;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}

/* Prevent warnings from -Wmissing-prototypes.  */
#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */


/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*-------------------------.
| yyparse or yypush_parse.  |
`-------------------------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{


    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       `yyss': related to states.
       `yyvs': related to semantic values.

       Refer to the stacks thru separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yytoken = 0;
  yyss = yyssa;
  yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */
  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;

	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),
		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss_alloc, yyss);
	YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:

/* Line 1455 of yacc.c  */
#line 107 "sintactico.y"
    {
          LOG_MSG("\n\nCompilación exitosa\n");
        }
    break;

  case 11:

/* Line 1455 of yacc.c  */
#line 129 "sintactico.y"
    {
            add_var_symbol_table();
            var_count=0;
          }
    break;

  case 12:

/* Line 1455 of yacc.c  */
#line 136 "sintactico.y"
    {
            strcpy(var_name[var_count], (yyvsp[(1) - (5)].str_value));
            var_count++;
          }
    break;

  case 13:

/* Line 1455 of yacc.c  */
#line 141 "sintactico.y"
    {
            strcpy(var_name[var_count], (yyvsp[(1) - (5)].str_value));
            var_count++;
          }
    break;

  case 14:

/* Line 1455 of yacc.c  */
#line 148 "sintactico.y"
    {
            strcpy(var_type[var_count], (yyvsp[(1) - (1)].str_value));
          }
    break;

  case 15:

/* Line 1455 of yacc.c  */
#line 152 "sintactico.y"
    {
            strcpy(var_type[var_count], (yyvsp[(1) - (1)].str_value));
          }
    break;

  case 16:

/* Line 1455 of yacc.c  */
#line 156 "sintactico.y"
    {
            strcpy(var_type[var_count], (yyvsp[(1) - (1)].str_value));
          }
    break;

  case 17:

/* Line 1455 of yacc.c  */
#line 162 "sintactico.y"
    {
          types_validations_count = -1;
          LOG_MSG("\nAsignación");
        }
    break;

  case 18:

/* Line 1455 of yacc.c  */
#line 167 "sintactico.y"
    {
          LOG_MSG("\nSentencia IF");
        }
    break;

  case 19:

/* Line 1455 of yacc.c  */
#line 171 "sintactico.y"
    {
          LOG_MSG("\nSentencia IF ELSE");
        }
    break;

  case 20:

/* Line 1455 of yacc.c  */
#line 175 "sintactico.y"
    {
          LOG_MSG("\nSentencia WHILE");
        }
    break;

  case 21:

/* Line 1455 of yacc.c  */
#line 179 "sintactico.y"
    {
          LOG_MSG("\nSentencia READ");
        }
    break;

  case 22:

/* Line 1455 of yacc.c  */
#line 183 "sintactico.y"
    {
          LOG_MSG("\nSentencia WRITE");
        }
    break;

  case 23:

/* Line 1455 of yacc.c  */
#line 187 "sintactico.y"
    {
          all_equals_pivote_index = 1;
          LOG_MSG("\nSentencia ALLEQUALS");
        }
    break;

  case 24:

/* Line 1455 of yacc.c  */
#line 194 "sintactico.y"
    {
          validate_var_type((yyvsp[(1) - (3)].str_value), "STRING");
          insert_polish((yyvsp[(1) - (3)].str_value));
          insert_polish((yyvsp[(2) - (3)].str_value));
        }
    break;

  case 25:

/* Line 1455 of yacc.c  */
#line 200 "sintactico.y"
    {
          validate_assignament_type((yyvsp[(1) - (3)].str_value));
          insert_polish((yyvsp[(1) - (3)].str_value));
          insert_polish((yyvsp[(2) - (3)].str_value));
        }
    break;

  case 26:

/* Line 1455 of yacc.c  */
#line 206 "sintactico.y"
    {
          validate_var_type((yyvsp[(1) - (4)].str_value), "NUMBER");
          insert_polish((yyvsp[(1) - (4)].str_value));
          insert_polish((yyvsp[(2) - (4)].str_value));
        }
    break;

  case 27:

/* Line 1455 of yacc.c  */
#line 212 "sintactico.y"
    {
          validate_var_type((yyvsp[(1) - (3)].str_value), "NUMBER");
          LOG_MSG("\nSentencia #IGUALES");
          insert_polish((yyvsp[(1) - (3)].str_value));
          insert_polish((yyvsp[(2) - (3)].str_value));
        }
    break;

  case 28:

/* Line 1455 of yacc.c  */
#line 221 "sintactico.y"
    {
          insert_polish((yyvsp[(2) - (3)].str_value));
        }
    break;

  case 29:

/* Line 1455 of yacc.c  */
#line 225 "sintactico.y"
    {
          insert_polish((yyvsp[(2) - (3)].str_value));
        }
    break;

  case 31:

/* Line 1455 of yacc.c  */
#line 232 "sintactico.y"
    {
          insert_polish((yyvsp[(2) - (3)].str_value));
        }
    break;

  case 32:

/* Line 1455 of yacc.c  */
#line 236 "sintactico.y"
    {
          insert_polish((yyvsp[(2) - (3)].str_value));
        }
    break;

  case 35:

/* Line 1455 of yacc.c  */
#line 244 "sintactico.y"
    {
          save_type_id((yyvsp[(1) - (1)].str_value));
          insert_polish((yyvsp[(1) - (1)].str_value));
        }
    break;

  case 36:

/* Line 1455 of yacc.c  */
#line 249 "sintactico.y"
    {
          types_validations_count++;
          strcpy(types_validations[types_validations_count], "NUMBER");
          insert_polish((yyvsp[(1) - (1)].str_value));
        }
    break;

  case 37:

/* Line 1455 of yacc.c  */
#line 255 "sintactico.y"
    {
          types_validations_count++;
          strcpy(types_validations[types_validations_count], "NUMBER");
          insert_polish((yyvsp[(1) - (1)].str_value));
        }
    break;

  case 39:

/* Line 1455 of yacc.c  */
#line 264 "sintactico.y"
    {
          types_validations_count++;
          strcpy(types_validations[types_validations_count], "STRING");
          insert_polish((yyvsp[(1) - (1)].str_value));
        }
    break;

  case 40:

/* Line 1455 of yacc.c  */
#line 270 "sintactico.y"
    {
          insert_polish((yyvsp[(1) - (3)].str_value));
          insert_polish((yyvsp[(3) - (3)].str_value));
          insert_polish((yyvsp[(2) - (3)].str_value));
        }
    break;

  case 41:

/* Line 1455 of yacc.c  */
#line 276 "sintactico.y"
    {
          validate_var_type((yyvsp[(3) - (3)].str_value), "STRING");
          insert_polish((yyvsp[(1) - (3)].str_value));
          insert_polish((yyvsp[(3) - (3)].str_value));
          insert_polish((yyvsp[(2) - (3)].str_value));
        }
    break;

  case 42:

/* Line 1455 of yacc.c  */
#line 283 "sintactico.y"
    {
          validate_var_type((yyvsp[(1) - (3)].str_value), "STRING");
          insert_polish((yyvsp[(1) - (3)].str_value));
          insert_polish((yyvsp[(3) - (3)].str_value));
          insert_polish((yyvsp[(2) - (3)].str_value));
        }
    break;

  case 43:

/* Line 1455 of yacc.c  */
#line 290 "sintactico.y"
    {
          validate_var_type((yyvsp[(1) - (3)].str_value), "STRING");
          validate_var_type((yyvsp[(3) - (3)].str_value), "STRING");
          insert_polish((yyvsp[(1) - (3)].str_value));
          insert_polish((yyvsp[(3) - (3)].str_value));
          insert_polish((yyvsp[(2) - (3)].str_value));
        }
    break;

  case 44:

/* Line 1455 of yacc.c  */
#line 300 "sintactico.y"
    { 
          validate_condition_type();
          insert_polish("CMP");
          insert_polish("");
          push_stack(last_element_polish);
          insert_polish("BLT");
        }
    break;

  case 45:

/* Line 1455 of yacc.c  */
#line 308 "sintactico.y"
    { 
          validate_condition_type();
          insert_polish("CMP");
          insert_polish("");
          push_stack(last_element_polish);
          insert_polish("BLE");
        }
    break;

  case 46:

/* Line 1455 of yacc.c  */
#line 316 "sintactico.y"
    { 
          validate_condition_type();
          insert_polish("CMP");
          insert_polish("");
          push_stack(last_element_polish);
          insert_polish("BGT");
        }
    break;

  case 47:

/* Line 1455 of yacc.c  */
#line 324 "sintactico.y"
    { 
          validate_condition_type();
          insert_polish("CMP");
          insert_polish("");
          push_stack(last_element_polish);
          insert_polish("BGE");
        }
    break;

  case 48:

/* Line 1455 of yacc.c  */
#line 332 "sintactico.y"
    { 
          validate_condition_type();
          insert_polish("CMP");
          insert_polish("");
          push_stack(last_element_polish);
          insert_polish("BNE");
        }
    break;

  case 49:

/* Line 1455 of yacc.c  */
#line 340 "sintactico.y"
    { 
          validate_condition_type();
          insert_polish("CMP");
          insert_polish("");
          push_stack(last_element_polish);
          insert_polish("BEQ");
        }
    break;

  case 50:

/* Line 1455 of yacc.c  */
#line 350 "sintactico.y"
    {
          comparation_number = 1;
        }
    break;

  case 51:

/* Line 1455 of yacc.c  */
#line 354 "sintactico.y"
    {
          comparation_number = 2;
        }
    break;

  case 52:

/* Line 1455 of yacc.c  */
#line 358 "sintactico.y"
    {
          comparation_number = 2;
        }
    break;

  case 53:

/* Line 1455 of yacc.c  */
#line 362 "sintactico.y"
    {
          comparation_number = 2;
        }
    break;

  case 54:

/* Line 1455 of yacc.c  */
#line 369 "sintactico.y"
    {
          char aux[10];
          int x = 0;
          for(x; x < comparation_number; x++) {
            struct_polish *p = pop_stack();
            sprintf(aux, "%d", polish_index);
            p->element = strdup(&aux[0]);
          }
        }
    break;

  case 56:

/* Line 1455 of yacc.c  */
#line 382 "sintactico.y"
    {
          char aux[10];
          int x = 0;
          for(x; x < comparation_number; x++) {
            struct_polish *p = pop_stack();
            sprintf(aux, "%d", (polish_index + 2));
            p->element = strdup(&aux[0]);
          }
          insert_polish("");
          push_stack(last_element_polish);
          insert_polish("BI");
        }
    break;

  case 57:

/* Line 1455 of yacc.c  */
#line 395 "sintactico.y"
    {
          char aux[10];
          struct_polish *p = pop_stack();
          sprintf(aux, "%d", polish_index);
          p->element = strdup(&aux[0]);
          push_stack(last_element_polish);		  
        }
    break;

  case 59:

/* Line 1455 of yacc.c  */
#line 406 "sintactico.y"
    {
          sprintf(while_start, "%d", polish_index);
        }
    break;

  case 60:

/* Line 1455 of yacc.c  */
#line 410 "sintactico.y"
    {
          validate_condition_type();
        }
    break;

  case 61:

/* Line 1455 of yacc.c  */
#line 414 "sintactico.y"
    {
          char aux[10];
          int x = 0;
          for(x; x < comparation_number; x++) {
            struct_polish *p = pop_stack();
            sprintf(aux, "%d", (polish_index+2));
            p->element = strdup(&aux[0]); //escribe pos de salto condicional
          }
          insert_polish(strdup(&while_start[0]));
          insert_polish("BI");
        }
    break;

  case 63:

/* Line 1455 of yacc.c  */
#line 429 "sintactico.y"
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
    break;

  case 64:

/* Line 1455 of yacc.c  */
#line 448 "sintactico.y"
    {
          if(all_equals_to_compare_index < all_equals_pivote_index) {
            LOG_MSG("\n\nLa lista tiene menor cantidad de elementos que el pivote en all equals\n");
            exit(1);
          }
          all_equals_to_compare_index = 1;
        }
    break;

  case 65:

/* Line 1455 of yacc.c  */
#line 456 "sintactico.y"
    {
          if(all_equals_to_compare_index < all_equals_pivote_index) {
            LOG_MSG("\n\nLa lista tiene menor cantidad de elementos que el pivote en all equals\n");
            exit(1);
          }
          all_equals_to_compare_index = 1;
        }
    break;

  case 66:

/* Line 1455 of yacc.c  */
#line 466 "sintactico.y"
    {
          create_all_equals_condition();
        }
    break;

  case 67:

/* Line 1455 of yacc.c  */
#line 470 "sintactico.y"
    {
          create_all_equals_condition();
        }
    break;

  case 68:

/* Line 1455 of yacc.c  */
#line 476 "sintactico.y"
    {
          create_all_equals_pivote();
        }
    break;

  case 69:

/* Line 1455 of yacc.c  */
#line 480 "sintactico.y"
    {
          create_all_equals_pivote();
        }
    break;

  case 70:

/* Line 1455 of yacc.c  */
#line 486 "sintactico.y"
    {
            insert_polish("0");
            insert_polish("_equalsCount");
            insert_polish(":=");  
          }
    break;

  case 71:

/* Line 1455 of yacc.c  */
#line 492 "sintactico.y"
    {
            insert_polish("_equalsPivot");
            insert_polish(":=");
          }
    break;

  case 72:

/* Line 1455 of yacc.c  */
#line 497 "sintactico.y"
    {
            insert_polish("_equalsCount");
          }
    break;

  case 74:

/* Line 1455 of yacc.c  */
#line 503 "sintactico.y"
    {
          create_equals_condition();
        }
    break;

  case 75:

/* Line 1455 of yacc.c  */
#line 507 "sintactico.y"
    {
          create_equals_condition();
        }
    break;

  case 76:

/* Line 1455 of yacc.c  */
#line 514 "sintactico.y"
    {
          insert_polish((yyvsp[(2) - (2)].str_value));
          insert_polish("READ");
          types_validations_count = -1;
        }
    break;

  case 77:

/* Line 1455 of yacc.c  */
#line 522 "sintactico.y"
    {
          insert_polish("WRITE");
          types_validations_count = -1;
        }
    break;

  case 78:

/* Line 1455 of yacc.c  */
#line 527 "sintactico.y"
    {
          insert_polish((yyvsp[(2) - (2)].str_value));
          insert_polish("WRITE");
          validate_var_type((yyvsp[(2) - (2)].str_value), "STRING");
          types_validations_count = -1;
        }
    break;



/* Line 1455 of yacc.c  */
#line 2284 "y.tab.c"
      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined(yyoverflow) || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}



/* Line 1675 of yacc.c  */
#line 534 "sintactico.y"


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
  if(strcmp("STRING_CTE", token) == 0) {
    aux->length = strlen(yytext);
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
        printf("\n\nLa variable %s ya se encuentra declarada\n", var_name[var_count-x-1]);
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
    printf("\n\nLinea %d. No coinciden los tipos de datos.\n", yylineno);
    exit(1);
  } else if(is_valid_type == 2) {
    printf("\n\nLinea %d. La variable %s no se encuentra declarada\n", yylineno, var_name);
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
    printf("\n\nLinea %d. La variable %s no se encuentra declarada\n", yylineno, var_name);
    exit(1);
  }
}

void create_ts_file() {
  FILE *ts_file;

  //Abre el archivo de tabl de simbolo
  if((ts_file = fopen(TS_FILE, "wt")) == NULL) {
    printf("\n\nError al abrir el archivo de tabla de simbolos %s\n", TS_FILE);
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
        if(strcmp(type, types_validations[x]) != 0) {
          printf("\n\nLinea %d. No coinciden los tipos de datos\n", yylineno);
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
    printf("\n\nError al abrir el archivo de codigo intermedio %s\n", CODE_FILE);
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
    LOG_MSG("\n\nLa lista tiene mayor cantidad de elementos que el pivote en all equals\n");
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
  char value[32];
  //Abre el archivo de assembler
  if((assembler_file = fopen(ASSEMBLER_FILE, "wt")) == NULL) {
    printf("\n\nError al abrir el archivo de assembler %s\n", ASSEMBLER_FILE);
    exit(1);
  }
  
  fprintf(assembler_file, ".MODEL LARGE\n");
  fprintf(assembler_file, ".386\n");
  fprintf(assembler_file, ".STACK 200h\n\n");
  fprintf(assembler_file, ".DATA\n\n");
  fprintf(assembler_file, "STRINGMAXLENGTH equ %d\n\n", STRING_MAX_LENGTH);

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
        fprintf(assembler_file, "%s dd %s\n", p->name, value);
      } else {
        fprintf(assembler_file, "%s dd %f\n", p->name, atof(value));
      }
    } else {
      if(strcmp(value,"?") == 0) {
        fprintf(assembler_file, "%s db STRINGMAXLENGTH dup(?),'$'\n", p->name);
      } else {
        fprintf(assembler_file, "%s db \"%s\",'$',%d dup(?)\n", p->name, value, (STRING_MAX_LENGTH - p->length));
      }
    }
    p = p->next;
  }

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


