%s MAGIC

%%
<MAGIC>.+  { BEGIN 0; printf("Magic:"); ECHO; }
magic       BEGIN MAGIC;
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
