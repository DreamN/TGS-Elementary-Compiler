%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  extern int yylex();
  typedef struct yy_buffer_state * YY_BUFFER_STATE;
  extern int yyparse();
  extern YY_BUFFER_STATE yy_scan_string(char * str);
  extern void yy_delete_buffer(YY_BUFFER_STATE buffer);
  void yyerror(char *msg);
  char itoa(int val, int pos);
  int res = 0 ;
  char snum[10];
  char reader[128];
  int var[676];
%}
%union {
    int i;
    char c;
    char* str;
}
%token <i> IF EQ LOOP TO END /* Condition Token */
%token <i> NUM PRESENT PRESENTHEX    /* Options Token */
%token <i> UNKNOWN /* Error Token */
%token <i> VAR
%token <str> STRING
%type <i> E T F
%type <str> STR
%type <i> BOOL

%%
program:
  program S
  | /* NULL */
  ;

S : VAR '=' E '\n'                        {
                                           var[$1] = $3;
                                           printf("res%d: Assign $%c%c <- %d\n", res++, itoa($1, 1), itoa($1, 0), var[$1]);
                                          }
  | IF BOOL '\n' S END '\n'               {printf("If Bool\n");}                                   /* If */
  | LOOP VAR ':' E TO E '\n' S END '\n'   {printf("LOOP\n");}                                      /* For Loop */
  | PRESENT STR '\n'                      {printf("> \"%s\" \n", $2);}                              /* Print number in decimal */
  | PRESENT E '\n'                        {printf("> %d\n", $2);}
  | PRESENTHEX E '\n'                     {printf("> %x\n", $2);}
  | UNKNOWN                               {printf("!ERROR : Unknown operation\n");}              /* "!ERROR" when out of gramma character */
  | E '\n'                                {printf("res%d: %d\n", res++, $1);}
  | BOOL                                  {printf("res%d: %d\n", res++, $1);}
  | '\n'                                  {}
  ;

E : E '+' T          {$$ = $1 + $3;}
  | E '-' T          {$$ = $1 - $3;}
  | T                {$$ = $1;}
  ;

T : T '*' F          {$$ = $1 * $3;}
  | T '/' F          {$$ = $1 / $3;}
  | T '\\' F         {$$ = $1 % $3;}
  | F                {$$ = $1;}
  ;

F : '(' E ')'        {$$ = $2;}
  | '-' F            {$$ = -$2;}
  | NUM              {$$ = $1;}
  | VAR              {$$ = var[$1];}
  ;

BOOL : E EQ E        {$$ = $1 == $3;}
     ;

STR : STRING         {$$ = $1;}
    | E '+' STRING   {}// IMP Later
    | STRING '+' E   {}// IMP Later
    ;

%%
void yyerror(char *msg) {
  fprintf(stderr, "%s\n", msg);
}

int main(int argc, char *argv[]) {
  FILE *fp = fopen(argv[1], "r");
  char *filename = strtok(argv[1], ".");
  filename = strcat(filename, ".asm");
  while(fgets(reader, 128, fp)){
      //printf("%s", reader);
      YY_BUFFER_STATE buffer = yy_scan_string(reader);
      yyparse();
      yy_delete_buffer(buffer);
  }
  fclose(fp);
  return 0;
}

char itoa(int val, int pos){
  if(pos==0){
    return val%26 + 'A';
  }
  else{
    return val/26 + 'A';
  }
}
