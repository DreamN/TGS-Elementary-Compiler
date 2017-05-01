%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include "createasm.h"
  extern int yylex();
  typedef struct yy_buffer_state * YY_BUFFER_STATE;
  extern int yyparse();
  extern YY_BUFFER_STATE yy_scan_string(char * str);
  extern void yy_delete_buffer(YY_BUFFER_STATE buffer);
  void yyerror(char *msg);
  int res = 0 ;
  char snum[10];
  char reader[128];
  extern FILE *fp;
%}
%union {
    int i;
    char c;
    char* str;
}
%token <i> IF EQ LOOP TO END /* Condition Token */
%token <i> NUM PRESENT PRESENTHEX    /* Options Token */
%token <i> UNKNOWN /* Error Token */
%token <c> VAR
%token <str> STRING
%type <i> E T F
%type <str> STR
%type <i> BOOL

%%
program:
  program S
  | /* NULL */
  ;

S : VAR '=' E '\n'                        {MemVar(STORE, $3, 1);
                                           releaseRegister();}
  | IF BOOL '\n' S END '\n'               {printf("If Bool\n");}                                   /* If */
  | LOOP VAR ':' E TO E '\n' S END '\n'   {printf("LOOP\n");}                                      /* For Loop */
  | PRESENT STR '\n'                      {;}                              /* Print number in decimal */
  | PRESENT E '\n'                        {asmprintfInt($2);
                                           releaseRegister();}
  | PRESENTHEX E '\n'                     {printf("> %x\n", $2);}
  | UNKNOWN                               {printf("!ERROR : Unknown operation\n");}              /* "!ERROR" when out of gramma character */
  | E '\n'                                {printf("res%d: %d\n", res++, $1);}
  | BOOL                                  {printf("res%d: %d\n", res++, $1);}
  ;

E : E '+' T          {$$ = $1;
                           createOp(ADD, $1, $3);
                           releaseRegister();}
  | E '-' T          {$$ = $1;
                           createOp(SUB, $1, $3);
                           releaseRegister();}
  | T                {$$ = $1;}
  ;

T : T '*' F          {$$ = $1;
                           createOp(MULT, $1, $3);
                           releaseRegister();}
  | T '/' F          {$$ = $1;
                           createOp(DIV, $1, $3);
                           releaseRegister();}
  | T '\\' F         {$$ = $1;
                           createOp(MOD, $1, $3);
                           releaseRegister();}
  | F                {$$ = $1;}
  ;

F : '(' E ')'        {$$ = $2;}
  | '-' F            {$$ = $2;
                           addNegative($2);}
  | NUM              {$$ = nextFreeRegister();
                           RegConst($$, $1);}
  | VAR              {$$ = nextFreeRegister();
                           MemVar(LOAD, $$, 1);}
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
  FILE *fr = fopen(argv[1], "r");
  char *filename = strtok(argv[1], ".");
  filename = strcat(filename, ".asm");
  fp = fopen(filename, "w");
  initasm();
  while(fgets(reader, 128, fr)){
      //printf("%s", reader);
      YY_BUFFER_STATE buffer = yy_scan_string(reader);
      yyparse();
      yy_delete_buffer(buffer);
  }
  initvariable();
  fclose(fp);
  fclose(fr);
  return 0;
}
