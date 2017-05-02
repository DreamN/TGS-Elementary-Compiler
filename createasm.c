#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "createasm.h"

FILE *fp;

int nextFreeReg = 0;

void createOp(int op, int reg1, int reg2){
  switch (op) {
    case ADD:
      fprintf(fp, "\tadd %s, %s\n", regToString(reg1), regToString(reg2));
    break;
    case SUB:
      fprintf(fp, "\tsub %s, %s\n", regToString(reg1), regToString(reg2));
    break;
    case MULT:
      fprintf(fp, "\timul %s, %s\n", regToString(reg1), regToString(reg2));
    break;
    case DIV:
      fprintf(fp, "\tidiv %s, %s\n", regToString(reg1), regToString(reg2));
    break;
    case MOD:
      fprintf(fp, "\tidiv %s, %s\n", regToString(reg1), regToString(reg2));
      fprintf(fp, "\tmov %s, %s\n", regToString(reg1), regToString(RDX));
  }
}

void MemVar(int op, int reg, int id){
  switch (op) {
    case STORE:
      fprintf(fp, "\tmov [VAR+%d*8], %s\n", id, regToString(reg));
    break;
    case LOAD:
      fprintf(fp, "\tmov %s, [VAR+%d*8]\n", regToString(reg), id);
    break;
  }
}

void RegConst(int reg, int num){
  fprintf(fp, "\tmov %s, %d\n", regToString(reg), num);
}

void addNegative(int reg){
  fprintf(fp, "\tNOT %s\n", regToString(reg));
  fprintf(fp, "\tadd %s, 00000001B\n", regToString(reg));
}

void asmprintfInt(int reg){
  fprintf(fp, "\tpush rcx\n");
  fprintf(fp, "\tmov rdi, formatInt\n");
  fprintf(fp, "\tmov rsi, %s\n", regToString(reg));
  fprintf(fp, "\txor rax, rax\n");
  fprintf(fp, "\tcall printf\n");
  fprintf(fp, "\tpop rcx\n");
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
  fprintf(fp, "\tglobal main\n\n");
  fprintf(fp, "\textern printf\n\n");
  fprintf(fp, "\tsection .text\n\n");
  fprintf(fp, "main:\n");
}

void initvariable(){
  fprintf(fp, "section .data\n");
  fprintf(fp, "\tVAR times 1024 DQ 0\n");
  fprintf(fp, "\tformatInt db  \"%%d\", 10, 0\n");
  fprintf(fp, "\tformatChar db  \"%%c\", 10, 0\n");
}

void jmpIf(int jmpId, int a, int b){
  fprintf(fp, "\tcmp %s, %s\n", regToString(a), regToString(b));
  fprintf(fp, "\tjne s%d\n", jmpId);
  releaseRegister();
  releaseRegister();
}

void jmpEndIf(int jmpId){
  fprintf(fp, "\ts%d:\n", jmpId);
}

void jmpLoop(int id, int conna, int connb, int a, int b){
  fprintf(fp, "\tsub %s, 1\n", regToString(a));
  fprintf(fp, "\tmov [VAR+%d*8], %s\n", id, regToString(a));
  fprintf(fp, "\tmov [VAR+%d*8], %s\n", 700+conna, regToString(b));
  fprintf(fp, "\ts%d:\n", connb);
  //compare var = b
  int nreg = nextFreeRegister();
  int mreg = nextFreeRegister();
//store B in VAR
  fprintf(fp, "\tmov %s, [VAR+%d*8]\n", regToString(nreg), id);
  fprintf(fp, "\tadd %s, 1\n", regToString(nreg));
  fprintf(fp, "\tmov [VAR+%d*8], %s\n", id, regToString(nreg));

  fprintf(fp, "\tmov %s, [VAR+%d*8]\n", regToString(mreg), 700+conna);

  fprintf(fp, "\tcmp %s, %s\n", regToString(nreg), regToString(mreg));
  fprintf(fp, "\tje s%d\n", conna);
  releaseRegister();
  releaseRegister();
  releaseRegister();
  releaseRegister();
}

void jmpEndLoop(int conna, int connb){

  fprintf(fp, "\tjmp s%d\n", connb);
  fprintf(fp, "\ts%d:\n", conna);
}
