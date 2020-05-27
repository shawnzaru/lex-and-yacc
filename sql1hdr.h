#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <math.h>

extern FILE *yyin;
extern FILE *yyout;

extern int yyerror(char *s);
extern int yyparse();
extern int yylex();
