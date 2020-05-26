%{
#include <stdio.h>
#include <stdlib.h>
extern FILE *yyin;
int yyerror(char *);
int yylex();
%}

%token NAME NUMBER
%%
statement:  NAME '=' expression
  |  expression    { printf("= %d\n", $1); }
  ;

expression:  expression '+' NUMBER  { $$ = $1 + $3; }
  |  expression '-' NUMBER  { $$ = $1 - $3; }
  |  NUMBER      { $$ = $1; }
  ;
%%
int main()
{
  do {
    yyparse();
  } while (!feof(yyin));
  return 0;
}

int yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
  return 0;
}
