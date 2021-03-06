%{
/*
 * A lexer for the basic grammar to use for recognizing english sentences.
 */
#include <stdio.h>
#include "ch1-05.h"
%}

%token NOUN PRONOUN VERB ADVERB ADJECTIVE PREPOSITION CONJUNCTION

%%
sentence: subject VERB object  { printf("Sentence is valid.\n"); }
  ;

subject: NOUN
  | PRONOUN
  ;

object: NOUN
  ;
%%

int main()
{
  yyparse();
  return 0;
}

int yyerror(char *s)
{
  fprintf(stderr, "%s\n", s);
  return 0;
}
