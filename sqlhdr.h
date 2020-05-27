#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <math.h>

extern FILE *yyin;
extern FILE *yyout;


extern int yyerror(char *s);
extern void un_sql();
extern int yyparse();
extern int yylex();

extern void start_save(void);
extern void save_str(char *s);
extern void save_param(char *n);
extern void end_sql(void);
