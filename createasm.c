#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "createasm.h"

FILE *fp;

int nextFreeReg = 0;
int increment = 1;

void incTab(){
  int i;
  for(i=0; i<increment; i++){
      fprintf(fp, "\t");
  }
}

void createOp(int op, int reg1, int reg2){
  switch (op) {
    case ADD:
      incTab();fprintf(fp, "add %s, %s\n", regToString(reg1), regToString(reg2));
    break;
    case SUB:
      incTab();fprintf(fp, "sub %s, %s\n", regToString(reg1), regToString(reg2));
    break;
    case MULT:
      incTab();fprintf(fp, "imul %s, %s\n", regToString(reg1), regToString(reg2));
    break;
    case DIV:
      if(reg1 != RAX) fprintf(fp, "\tpush rax\n");
      incTab();fprintf(fp, "push rdx\n");
      incTab();fprintf(fp, "xor rdx, rdx\n");
      incTab();fprintf(fp, "mov rax, %s\n", regToString(reg1));
      incTab();fprintf(fp, "mov rsi, %s\n", regToString(reg2));
      incTab();fprintf(fp, "idiv rsi\n");
      incTab();fprintf(fp, "mov %s, rax\n", regToString(reg1));
      incTab();fprintf(fp, "pop rdx\n");
      if(reg1 != RAX) {incTab();fprintf(fp, "\tpop rax\n");}
    break;
    case MOD:
      if(reg1 != RAX) fprintf(fp, "\tpush rax\n");
      incTab();fprintf(fp, "push rdx\n");
      incTab();fprintf(fp, "xor rdx, rdx\n");
      incTab();fprintf(fp, "mov rax, %s\n", regToString(reg1));
      incTab();fprintf(fp, "mov rsi, %s\n", regToString(reg2));
      incTab();fprintf(fp, "idiv rsi\n");
      incTab();fprintf(fp, "mov %s, rdx\n", regToString(reg1));
      incTab();fprintf(fp, "pop rdx\n");
      if(reg1 != RAX){incTab();fprintf(fp, "pop rax\n");}
  }
}

void MemVar(int op, int reg, int id){
  switch (op) {
    case STORE:
      incTab();fprintf(fp, "mov [VAR+%d*8], %s\n", id, regToString(reg));
    break;
    case LOAD:
      incTab();fprintf(fp, "mov %s, [VAR+%d*8]\n", regToString(reg), id);
    break;
  }
}

void RegConst(int reg, int num){
  incTab();fprintf(fp, "mov %s, %d\n", regToString(reg), num);
}

void addNegative(int reg){
  incTab();fprintf(fp, "NOT %s\n", regToString(reg));
  incTab();fprintf(fp, "add %s, 00000001B\n", regToString(reg));
}

void asmprintfInt(int reg){
  incTab();fprintf(fp, "push rcx\n");
  incTab();fprintf(fp, "mov rdi, formatInt\n");
  incTab();fprintf(fp, "mov rsi, %s\n", regToString(reg));
  incTab();fprintf(fp, "xor rax, rax\n");
  incTab();fprintf(fp, "call printf\n");
  incTab();fprintf(fp, "pop rcx\n");
}

void asmprintfHex(int reg){
  incTab();fprintf(fp, "push rcx\n");
  incTab();fprintf(fp, "mov rdi, formatHex\n");
  incTab();fprintf(fp, "mov rsi, %s\n", regToString(reg));
  incTab();fprintf(fp, "xor rax, rax\n");
  incTab();fprintf(fp, "call printf\n");
  incTab();fprintf(fp, "pop rcx\n");
}

void asmprintfString(char* string){
  int i, temp = 0;
  int hittime = 0;
  for(i=0; hittime < 2; ++i){
    if(string[i] == '"'){
      hittime ++;
    }
    else{
      incTab();fprintf(fp, "mov %s, %d\n", regToString(nextFreeReg), temp);
      incTab();fprintf(fp, "mov byte[arraystr + %s], '%c'\n", regToString(nextFreeReg), string[i]);
      temp ++;
    }

  }
  incTab();fprintf(fp, "mov %s, %d\n", regToString(nextFreeReg), temp);
  incTab();fprintf(fp, "mov byte[arraystr + %s], %c\n", regToString(nextFreeReg), '0');
  incTab();fprintf(fp, "mov rdi, arraystr\n");
  incTab();fprintf(fp, "call puts\n");
}

char *regToString(int reg){
  switch (reg) {
    case RAX:
      return "rax";
    break;
    case RBX:
      return "rbx";
    break;
    case RCX:
      return "rcx";
    break;
    case RDX:
      return "rdx";
    break;
    case RSI:
      return "rsi";
    break;
    case RDI:
      return "rdi";
    break;
  }
}

int nextFreeRegister(){
  int temp = nextFreeReg;
  nextFreeReg++;
  // printf("next-> %d\n", temp);
  return temp;
}

void releaseRegister(){
  nextFreeReg--;
  // printf("release-> %d\n", nextFreeReg);
}

void initasm(){
  fprintf(fp, "global main\n\n");
  fprintf(fp, "extern printf\n\n");
  fprintf(fp, "extern puts\n\n");
  fprintf(fp, "section .text\n\n");
  fprintf(fp, "main:\n");
}

void initvariable(){
  fprintf(fp, "section .data\n");
  fprintf(fp, "VAR times 1024 DQ 0\n");
  fprintf(fp, "arraystr	TIMES 512 dd 0 \n");
  fprintf(fp, "formatInt db  \"%%d\", 10, 0\n");
  fprintf(fp, "formatHex db  \"%%x\", 10, 0\n");
}

void jmpIf(int jmpId, int a, int b, char* opt){
  incTab();fprintf(fp, "cmp %s, %s\n", regToString(a), regToString(b));
  if(strcmp(opt, "eq") == 0){
    incTab();fprintf(fp, "jne s%d\n", jmpId);
  }
  else if(strcmp(opt, "neq") == 0){
    incTab();fprintf(fp, "je s%d\n", jmpId);
  }
  else if(strcmp(opt, "lt") == 0){
    incTab();fprintf(fp, "jge s%d\n", jmpId);
  }
  else if(strcmp(opt, "lte") == 0){
    incTab();fprintf(fp, "jg s%d\n", jmpId);
  }
  else if(strcmp(opt, "gt") == 0){
    incTab();fprintf(fp, "jle s%d\n", jmpId);
  }
  else if(strcmp(opt, "gte") == 0){
    incTab();fprintf(fp, "jl s%d\n", jmpId);
  }
  releaseRegister();
  releaseRegister();
  increment++;
}

void jmpEndIf(int jmpId){
  increment--;
  incTab();fprintf(fp, "s%d:\n", jmpId);
}

void jmpLoop(int id, int conna, int connb, int a, int b){
  incTab();fprintf(fp, "sub %s, 1\n", regToString(a));
  incTab();fprintf(fp, "mov [VAR+%d*8], %s\n", id, regToString(a));
  incTab();fprintf(fp, "add %s, 1\n", regToString(b));
  incTab();fprintf(fp, "mov [VAR+%d*8], %s\n", 700+conna, regToString(b));
  incTab();fprintf(fp, "s%d:\n", connb);
  increment++;
  //compare var = b
  int nreg = nextFreeRegister();
  int mreg = nextFreeRegister();
//store B in VAR
  incTab();fprintf(fp, "mov %s, [VAR+%d*8]\n", regToString(nreg), id);
  incTab();fprintf(fp, "add %s, 1\n", regToString(nreg));
  incTab();fprintf(fp, "mov [VAR+%d*8], %s\n", id, regToString(nreg));

  incTab();fprintf(fp, "mov %s, [VAR+%d*8]\n", regToString(mreg), 700+conna);

  incTab();fprintf(fp, "cmp %s, %s\n", regToString(nreg), regToString(mreg));
  incTab();fprintf(fp, "je s%d\n", conna);
  releaseRegister();
  releaseRegister();
  releaseRegister();
  releaseRegister();
}

void jmpEndLoop(int conna, int connb){
  increment--;
  incTab();fprintf(fp, "jmp s%d\n", connb);
  incTab();fprintf(fp, "s%d:\n", conna);
}
