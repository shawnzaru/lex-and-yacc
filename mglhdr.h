#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <math.h>

int warning(char *s, char *t);
int start_screen(char *name);
int add_title(char *line);
int add_line(int action, int attrib);
int end_screen(char *name);
int process_items();
int dump_data(char **array);
int end_file();
int check_name(char *name);
