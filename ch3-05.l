%{
#include "ch3-05.tab.h"
#include "ch3hdr2.h"
#include <math.h>
#include <stdlib.h>
%}

%%
([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?) {
    yylval.dval = atof(yytext);
    return NUMBER;
  }

[ \t]  ;     /* ignore white space */

[A-Za-z][A-Za-z0-9]*  {  /* return symbol pointer */
    struct symtab *sp = symlook(yytext);
    yylval.symp = sp;
    return NAME;
  }

"$"    { exit(0); }

\n  |
.      { return yytext[0]; }
%%

int yywrap()
{
  return 1;
}

