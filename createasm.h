#ifndef CREATEASM_H
#define CREATEASM_H

FILE *fp;

void createOp(int op, int reg1, int reg2);
enum {ADD, SUB, MULT, DIV, MOD} Ope_Ops;

void MemVar(int op, int reg, int id);
enum {LOAD, STORE} Mem_Ops;

char *regToString(int reg);
enum {RAX, RBX, RCX, RDX, RSI, RDI} REGISTER_NAME;

void RegConst(int reg, int num);

void addNegative(int reg);

void asmprintfInt(int reg);
void asmprintfHex(int reg);
void asmprintfString(char* string);

int nextFreeRegister();
void releaseRegister();

void initasm();
void initvariable();

void jmpIf(int jmpId, int a, int b, char* opt);

void jmpEndIf(int jmpId);

void jmpLoop(int id, int conna, int connb, int a, int b);

void jmpEndLoop(int conna, int connb);

#endif
