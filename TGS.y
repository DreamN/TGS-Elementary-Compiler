%{
  #include <stdio.h>
  #include <stdlib.h>
  extern int yylex();
  void yyerror(char *msg);
  int res = 0 ;
  char snum[10];
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

%%
program:
  program S
  | /* NULL */
  ;

S : VAR '=' E '\n'                        {printf("VAR\n");}
  | IF BOOL '\n' S END '\n'               {printf("If Bool\n");}                                   /* If */
  | LOOP VAR ':' E TO E '\n' S END '\n'   {printf("LOOP\n");}                                      /* For Loop */
  | PRESENT STR '\n'                      {printf("> \"%s\" \n", $2);}                              /* Print number in decimal */
  | PRESENT E '\n'                        {printf("> %d\n", $2);}
  | PRESENTHEX E '\n'                     {printf("> %x\n", $2);}
  | UNKNOWN                               {printf("!ERROR : Unknown operation\n");}              /* "!ERROR" when out of gramma character */
  | E '\n'                                {printf("res%d: %d\n", res++, $1);}
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
  | VAR              {$$ = $1;}
  ;

BOOL : F EQ F

STR : STRING         {$$ = $1;}
    | E '+' STRING   {}// IMP Later
    | STRING '+' E   {}// IMP Later
    ;

%%
void yyerror(char *msg) {
  fprintf(stderr, "%s\n", msg);
}
int main(void) {
 yyparse();
}
