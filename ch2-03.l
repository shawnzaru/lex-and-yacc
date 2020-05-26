%{
#undef yywrap

unsigned long charCount = 0, wordCount = 0, lineCount = 0;

char **fileList;
unsigned currentFile;
unsigned nFiles;
unsigned long totalCC = 0, totalWC = 0, totalLC = 0;
%}

word [^ \t\n]+
eol  \n

%%

{word} { wordCount++; charCount += yyleng; }
{eol}  { charCount++; lineCount++; }
.      { charCount++; }

%%

void attachFile(unsigned *pIndex)
{
  /* printf("*pIndex %u, nFiles %d\n", *pIndex, nFiles); */
  FILE *file;

  if (!yyin) {
    fclose(yyin); /* close previous file if there is any */
  }

  file = fopen(fileList[*pIndex], "r");
  if (!file) {
    fprintf(stderr, "could not open %s\n", fileList[*pIndex]);
    exit(1);
  }
  yyin = file;
  (*pIndex)++;
  /* printf("*pIndex %u, nFiles %d\n", *pIndex, nFiles); */
}

int main(int argc, char **argv)
{
  fileList = argv + 1;
  nFiles = argc - 1;
  currentFile = 0;

  attachFile(&currentFile); /* exit here if nFiles == 0 */
  yylex();
  return 0;
}

int yywrap()
{
  printf("%8lu %8lu %8lu %s\n", lineCount, wordCount, charCount, fileList[currentFile-1]);
  totalLC += lineCount;
  totalWC += wordCount;
  totalCC += charCount;
  charCount = wordCount = lineCount = 0;
  if (currentFile >= nFiles) {
    if (nFiles > 1) {
      printf("%8lu %8lu %8lu total\n", totalLC, totalWC, totalCC);
    }
    return 1; /* end lexing */
  } else {
    attachFile(&currentFile);
    return 0; /* more input */
  }
}

