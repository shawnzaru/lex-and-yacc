include <stdio.h>

char flavor[6], name[8], type[5];
int SQLCODE;

EXEC SQL DECLARE flav CURSOR FOR
  SELECT Foods.name, Foods.type
  FROM   Foods
  WHERE  Foods.flavor = :flavor;

int main()
{
  scanf("%s", flavor);
  EXEC SQL OPEN flav ;
  for (;;) {
    EXEC SQL FETCH flav INTO :name, :type ;
    if (SQLCODE != 0)
      break;
    printf("%8.8s %5.5s\n", name, type);
  }
  EXEC SQL CLOSE flav ;
  return 0;
}

