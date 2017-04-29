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
  void lexerror(int code); /* return "!ERROR" function */
  int var[26];
  char reader[128];
%}
%union {
    int i;
    char c;
}
%token <i> IF EQ LOOP TO END /* Condition Token */
%token <i> AND OR NOT XOR  /* Operation Token */
%token <i> NUM STRING PRESENT PRESENTHEX    /* Options Token */
%token <i> UNKNOWN /* Error Token */
%token <c> VAR  /* Variable token */
%type <i> E T F BOOL STR /* Gramma */
%%
program:
  program S '\n' /* Start gramma */
  | /* NULL */
  ;
S : VAR '=' E '\n'                        {var[$1] = $3; printf("=  %d\n> ", $3);}
  | IF BOOL '\n' S END '\n'                                             /* If */
  | LOOP VAR ':' E TO E '\n' S END '\n'                                 /* For Loop */
  | PRESENT STR '\n'                      {printf("%d\n", $2);}         /* Print numbrt in decimal */
  | PRESENTHEX STR '\n'                                                 /* Print number in heximal */
  | UNKNOWN                               {printf("!ERROR : Unknown operation\n");}           /* "!ERROR" when out of gramma character */

E : E '+' T          {$$ = $1 + $3;}                                    /* '+' Operation*/
  | E '-' T          {$$ = $1 - $3;}                                    /* '-' Operation*/
  | T                {$$ = $1;}                                         /* to more piority operation*/
  ;
T : T '*' F          {$$ = $1 * $3;}                                    /* '*' Operation*/
  | T '/' F          {$$ = $1 / $3;}                                    /* '/' Operation*/
  | T '\\' F         {$$ = $1 % $3;}                                    /* modulus Operation*/
  | T AND F          {$$ = $1 & $3;}                                    /* Bitwise AND Operation*/
  | T OR F           {$$ = $1 | $3;}                                    /* Bitwise OR  Operation*/
  | T XOR F          {$$ = $1 ^ $3;}                                    /* Bitwise XOR Operation*/
  | F                {$$ = $1;}                                         /* to more piority operation*/
  ;
F : '(' E ')'        {$$ = $2;}                                         /* ( ) */
  | '-' F            {$$ = -$2;}                                        /* negative value */
  | NOT F            {$$ = ~ $2;}                                       /* Bitwise NOT Operation*/
  | NUM              {$$ = $1;}
  | VAR              {$$ = $1;}
  ;

BOOL : F EQ F

STR : STRING
    | E
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
      printf("%s", reader);
      YY_BUFFER_STATE buffer = yy_scan_string(reader);
      yyparse();
      yy_delete_buffer(buffer);
  }
  return 0;
}
void lexerror(int code){
  switch(code){
    case 1:
      printf("!ERROR \n");
      break;
    default:
      printf("!ERROR \n");
      break;
  }
  return;
}
