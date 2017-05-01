#ifndef CREATEASM_H
#define CREATEASM_H

FILE *fp;

void createOp(int op, int reg1, int reg2);
enum {ADD, SUB, MULT, DIV, MOD} Ope_Ops;

void MemVar(int op, int reg, int id);
enum {LOAD, STORE} Mem_Ops;

char *regToString(int reg);
enum {EAX, EBX, ECX, EDX, ESI, EDI} REGISTER_NAME;

void RegConst(int reg, int num);

void addNegative(int reg);

void asmprintfInt(int string);

int nextFreeRegister();
void releaseRegister();

void initasm();
void initvariable();

#endif
