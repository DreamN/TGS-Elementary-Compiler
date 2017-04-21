%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include "y.tab.h"
  void yyerror(char *);
  int htoi(char *);   /* change base 16 to base 10 number */
  int Ohtoi(char c);  /* change base 16 to base 10 number (1 character) */
  int azToInt(char c);
%}

%%

[0-9]+                              {yylval.i = atoi(yytext); return NUM;}      /* number Token (0-infinity)*/
[0-9A-Fa-f]+[Hh]                    {yylval.i = htoi(yytext); return NUM;}      /* base 16 number Token (15AH) */
"$"[A-Za-z][A-Za-z]                 {yylval.i = azToInt(yytext[1])*26 + azToInt(yytext[2]);  return VAR;}   /* Variable Token ($AA-$ZZ) */
"\""[A-Za-z_0-9+-*\\/]"\""          {return STRING;}                            /* Haven't imprement yet! */
[-+*()\n/=\\]                       {return *yytext;}                           /* Operation Token */
"present:"                          {return PRESENT;}                           /* Present Something */
"present_h:"                        {return PRESENTH;}                          /* Present Something in Hex */
"eq"                                {return EQ;}                                /* Equal or Not (in Boolean) */
"loop:"                             {return LOOP;}                              /* Loop */
"if:"                               {return IF;}                                /* If   */
"end:"                              {return END;}                               /* End  */
"to"                                {return TO;}                                /* To   */
[ \t\f\v] ; //Ignore
.                                   {return UNKNOWN;}                           /* out of gramma character Token */

%%

int Ohtoi(char c){  /* change base 16 to base 10 number (1 character) */
	int r;
	if(c>='0' && c<='9'){
		r = c - '0';
	}
	else if(c>='A' && c<='F'){
		r = c - 'A' + 10;
	}
	else if(c>='a' && c<='f'){
		r = c - 'a' + 10;
	}
	return r;
}

int htoi(char *s){  /* change base 16 to base 10 number */
	int i;
	int result = Ohtoi(s[0]);
	for(i=1; i<strlen(s)-1; i++){
		result *= 16;
		result += Ohtoi(s[i]);
	}
	return result;
}

int azToInt(char c){
  if(c >= 'a' && c <= 'z'){
    return c-'a'
  }
  else if(c >= 'A' && c <= 'Z'){
    return c-'A'
  }
  // else error occur
}

int yywrap(void){
  return 1;
}
