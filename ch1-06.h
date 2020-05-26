#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

extern FILE *yyin;
extern FILE *yyout;
extern int yywrap();
extern int yyerror(char *s);
extern int yylex();
