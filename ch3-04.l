%{
#include "ch3-04.tab.h"
#include "ch3hdr.h"
#include <math.h>
#include <stdlib.h>
%}

%%

([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?) {
    yylval.dval = atof(yytext);
    return NUMBER;
  }

[ \t]    {; /* ignore white space */ }

[A-Za-z][A-Za-z0-9]*  { /* return symbol pointer */
    yylval.symp = symlook(yytext);
    return NAME;
  }

"$"    { exit(0); }

\n |
.      { return yytext[0]; }

%%

int yywrap()
{
  return 1;
}
