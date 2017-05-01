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
  char itoa(int val, int pos);
  int res = 0 ;
  char snum[10];
  char reader[128];
  int var[676];
  int setRes = 0;

  extern FILE *fp;


  struct node   /* structure of stack */
 {
     int data;
     struct node* next;
 };

 void init(struct node* head)  /*create a stack*/
 {
     head = NULL;
 }

 struct node* push(struct node* head,int data) /* push data to stack */
 {
     struct node* tmp = (struct node*)malloc(sizeof(struct node));
     if(tmp == NULL) /*if create node fail */
     {
         exit(0);
     }
     tmp->data = data;
     tmp->next = head;
     head = tmp;
     size += 1;
     return head;
 }

 struct node* pop(struct node *head,int *element) /* pop stack */
 {
     if(head == NULL){ /* if stack is Empty */
       lexerror(1);  /* Return "!Error" */
       return NULL;
     }
     struct node* tmp = head;
     *element = head->data;
     head = head->next;
     free(tmp);
     size -= 1;
     return head;
 }

 struct node* st = NULL;

%}
%union {
    int i;
    char c;
    char* str;
}
%token <i> IF EQ LOOP TO END /* Condition Token */
%token <i> SETRES
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
                                            if(setRes)printf("res%d: Assign $%c%c <- %d\n", res++, itoa($1, 1), itoa($1, 0), var[$1]);
                                            MemVar(STORE, $3, 1);
                                            releaseRegister();
                                          }
  | IF BOOL '\n' S END '\n'               {printf("If Bool\n");}                                   /* If */
  | LOOP VAR ':' E TO E '\n' S END '\n'   {printf("LOOP\n");}                                      /* For Loop */
  | PRESENT ':' STR '\n'                  {printf("> %s\n", $3);}                              /* Print number in decimal */
  | PRESENT ':' E '\n'                    {
                                            printf("> %d\n", $3);
                                            asmprintfInt($3);
                                            releaseRegister();
                                          }
  | PRESENTHEX ':' E '\n'                 {printf("> %x\n", $3);}
  | UNKNOWN                               {printf("!ERROR : Unknown operation\n");}              /* "!ERROR" when out of gramma character */
  | E '\n'                                {if(setRes)printf("res%d: %d\n", res++, $1);}
  | BOOL                                  {if(setRes)printf("res%d: %d\n", res++, $1);}
  | SETRES                                {setRes = 1;}
  | '\n'                                  {}
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
  | '-' F            {
                      $$ = $2;
                      addNegative($2);
                     }
  | NUM              {
                       $$ = nextFreeRegister();
                       RegConst($$, $1);}
  | VAR              {
                       $$ = nextFreeRegister();
                       MemVar(LOAD, $$, $1);
                     }
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

char itoa(int val, int pos){
  if(pos==0){
    return val%26 + 'A';
  }
  else{
    return val/26 + 'A';
  }
}
