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

  int autoIncJmp = 0;

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

 struct node* st = NULL;

 int push(struct node* head) /* push data to stack */
 {
     struct node* tmp = (struct node*)malloc(sizeof(struct node));
     if(tmp == NULL) /*if create node fail */
     {
         exit(0);
     }
     tmp->data = autoIncJmp++;
     tmp->next = head;
     st = tmp;
     return st->data;
 }

 void pushLoopSig(struct node* head) /* push data to stack */
 {
     struct node* tmp = (struct node*)malloc(sizeof(struct node));
     if(tmp == NULL) /*if create node fail */
     {
         exit(0);
     }
     tmp->data = -1;
     tmp->next = head;
     st = tmp;
 }

 int pop(struct node *head) /* pop stack */
 {
     if(head == NULL){ /* if stack is Empty */
       return -100;
     }
     struct node* tmp = head;
     int data = head->data;
     st = head->next;
     free(tmp);
     return data;
 }

%}
%union {
    int i;
    char c;
    char* str;
}
%token <i> IF LOOP TO END /* Condition Token */
%token <i> NUM PRESENT PRESENTHEX    /* Options Token */
%token <i> UNKNOWN /* Error Token */
%token <i> VAR ENDLINE
%token <str> STRING
%token <str> BOOL
%type <i> E T F
%type <str> STR

%%
program:
  program S
  | /* NULL */
  ;

S : VAR '=' E ENDLINE                     {
                                            var[$1] = $3;
                                            MemVar(STORE, $3, $1);
                                            releaseRegister();
                                          }
  | IF ':' E BOOL E ENDLINE               {
                                            jmpIf(push(st), $3, $5, strtok($4," "));
                                          }           /* If */
  | LOOP ':' VAR ':' E TO E ENDLINE       {
                                            int conna = push(st);
                                            int connb = push(st);
                                            jmpLoop($3, conna, connb, $5, $7);
                                            pushLoopSig(st);
                                          }                              /* For Loop */
  | PRESENT ':' STR ENDLINE               {}                              /* Print number in decimal */
  | PRESENT ':' E ENDLINE                 {
                                            asmprintfInt($3);
                                            releaseRegister();
                                          }
  | PRESENTHEX ':' E ENDLINE              {
                                            asmprintfHex($3);
                                            releaseRegister();
                                          }
  | UNKNOWN                               {printf("!ERROR : Unknown operation\n");}   /* "!ERROR" when out of gramma character */
  | E ENDLINE                             {releaseRegister();}
  | END ENDLINE                           {
                                            if(st->data == -1){
                                              pop(st);
                                              int connb = pop(st);
                                              int conna = pop(st);
                                              jmpEndLoop(conna, connb);
                                            }
                                            else {
                                              jmpEndIf(pop(st));
                                            }
                                          }
  | ENDLINE                               {}
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
                       RegConst($$, $1);
                     }
  | VAR              {
                       $$ = nextFreeRegister();
                       MemVar(LOAD, $$, $1);
                     }
  ;


STR : STRING         {asmprintfString($1);}
    | STR '+' STRING {asmprintfString($3);}
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
