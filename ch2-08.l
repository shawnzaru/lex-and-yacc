%{
  /* This example deliberately doesn't work! */
%}

%s MAGIC

%%
magic       BEGIN MAGIC;
<MAGIC>.+   { BEGIN 0; printf("Magic:"); ECHO; }
.+          ECHO;
%%

int main()
{
  yylex();
  return 0;
}

int yywrap()
{
  return 1;
}
