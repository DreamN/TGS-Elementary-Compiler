%{
  #include <stdio.h>
  #include <stdlib.h>
  extern int yylex();
  void yyerror(char *msg);
  void lexerror(int code); /* return "!ERROR" function */
  float acc = 0;
  int var[26];
  int size;
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
  struct node* reg = NULL; /* create frist node */
%}
%union {
    int i;
    char c;
}
%token <i> IF LOOP TO /* Condition Token */
%token <i> AND OR NOT XOR  /* Operation Token */
%token <i> NUM ACC PUSH POP SHOW LOAD TOP SIZE /* Options Token */
%token <i> UNKNOWN /* Error Token */
%token <c> VAR  /* Variable token */
%type <i> E T F R BOOL STR /* Gramma */
%%
program:
  program S '\n' /* Start gramma */
  | /* NULL */
  ;
S : VAR '=' E '\n'
  | IF BOOL ENDLINE S END '\n'                                          /* If */
  | LOOP VAR ':' E TO E '\n' S END '\n'                                 /* For Loop */
  | PRESENT STR '\n'                                                    /* Print numbrt in decimal */
  | PRESENTHEX STR '\n'                                                 /* Print number in heximal */
  | UNKNOWN                                                             /* "!ERROR" when out of gramma character */

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
    | VAR
    | E
    | NUM
    ;
%%
void yyerror(char *msg) {
  fprintf(stderr, "%s\n", msg);
}
int main(void) {
 init(reg);
 size = 0;
 printf("> ");
 yyparse();
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
