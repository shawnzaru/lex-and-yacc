%{
#include <stdio.h>
#include <stdlib.h>
extern FILE *yyin;
int yyerror(char *);
int yylex();
%}

%token NAME NUMBER
%left '-' '+'
%left '*' '/'
%nonassoc UMINUS

%%

statement:  NAME '=' expression
  |  expression    { printf("= %d\n", $1); }
  ;

expression:  expression '+' expression { $$ = $1 + $3; }
  |  expression '-' expression { $$ = $1 - $3; }
  |  expression '*' expression { $$ = $1 * $3; }
  |  expression '/' expression
        {  if($3 == 0)
            yyerror("divide by zero");
          else
            $$ = $1 / $3;
        }
  |  '-' expression %prec UMINUS  { $$ = -$2; }
  |  '(' expression ')'  { $$ = $2; }
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
