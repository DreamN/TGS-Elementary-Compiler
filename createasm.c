#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "createasm.h"

FILE *fp;

int nextFreeReg = 0;

void createOp(int op, int reg1, int reg2){
  switch (op) {
    case ADD:
      fprintf(fp, "add %s, %s\n", regToString(reg1), regToString(reg2));
    break;
    case SUB:
      fprintf(fp, "sub %s, %s\n", regToString(reg1), regToString(reg2));
    break MULT:
      fprintf(fp, "imul %s, %s\n", regToString(reg1), regToString(reg2));
    break;
    case DIV:
      fprintf(fp, "idiv %s, %s\n",regToString(reg1),regToString(reg2));
    break;
  }
}

void MemVar(int op, int id, int reg){
  switch (op) {
    case STORE:
      fprintf(fp, "mov VAR[%d], %s\n", id, regToString(nextFreeReg));
    break;
    case LOAD:
      fprintf(fp, "mov %s, VAR[%d]\n", regToString(nextFreeReg), id);
    break;
  }
}


void initasm(){
  fprintf(fp, "section .text\n");
  fprintf(fp, "\tglobal _start\n\n");
  fprintf(fp, "_start:\n", );
}

void initvariable(){
  fprintf(fp, "section .data\n");
  fprintf(fp, "\tVAR times 676 DQ 0\n", );
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
      return "edx"
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
