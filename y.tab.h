
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
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

/* Line 1676 of yacc.c  */
#line 33 "sintactico.y"

    char* str_value;
    float real_value;
    int int_value;



/* Line 1676 of yacc.c  */
#line 140 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


