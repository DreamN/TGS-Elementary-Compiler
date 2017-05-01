#ifndef CREATEASM_H
#define CREATEASM_H


FILE *fp;

void createOp(int op, int reg1, int reg2);
enum {ADD, SUB, MULT, DIV} Ops;

void MemVar(int op, int id, int reg);
enum {LOAD, STORE} Ops;

char *regToString(int reg);
enum {EAX, EBX, ECX, EDX, ESI, EDI} REGISTER_NAME;

int nextFreeRegister();
int releaseRegister();

#endif
