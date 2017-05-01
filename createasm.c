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
      fprintf(fp, "\tmov %s, %s\n", regToString(reg1), regToString(EDX));
  }
}

void MemVar(int op, int reg, int id){
  switch (op) {
    case STORE:
      fprintf(fp, "\tmov VAR[%d], %s\n", id, regToString(reg));
    break;
    case LOAD:
      fprintf(fp, "\tmov %s, VAR[%d]\n", regToString(reg), id);
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
  fprintf(fp, "\tmov %s, BYTE [%s]\n", regToString(nextFreeReg), regToString(reg));
  fprintf(fp, "\tpush %s\n", regToString(nextFreeReg));
  fprintf(fp, "\tcall printf\n");
}

char *regToString(int reg){
  switch (reg) {
    case EAX:
      return "eax";
    break;
    case EBX:
      return "ebx";
    break;
    case ECX:
      return "ecx";
    break;
    case EDX:
      return "edx";
    break;
    case ESI:
      return "esi";
    break;
    case EDI:
      return "edi";
    break;
  }
}

int nextFreeRegister(){
  int temp = nextFreeReg;
  nextFreeReg++;
  return temp;
}

void releaseRegister(){
  nextFreeReg--;
}

void initasm(){
  fprintf(fp, "section .text\n\n");
  fprintf(fp, "global _start\n\n");
  fprintf(fp, "extern printf\n\n");
  fprintf(fp, "_start:\n");
}

void initvariable(){
  fprintf(fp, "section .data\n");
  fprintf(fp, "\tVAR times 676 DQ 0\n");
}
