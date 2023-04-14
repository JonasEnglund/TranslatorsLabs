%{
#include <stdlib.h>
#include "main.tab.h"
void yyerror(const char *s);
// <expression> ::= <term> | <expression> "+" <term>
// <term> ::= <factor> | <term> "*" <factor>
// <factor> ::= <integer> | "pow(" <expression> "," <expression> ")" | "("
// <expression> ")"
// <integer> ::= INT

//  pow(2,pow(3,4))    результат (thanks to python): 2417851639229258349412352 actual: переполнение
//  pow(2,pow(2*2,1+1)) результат: 65536 
%}

%%


[0-9]+  { yylval.num = atoi(yytext); printf("Readed int:%d; actual text:%s\n", yylval.num, yytext); return INT; }
"pow"   { return POW; }
\(     { return LPAREN; }
")"     { return RPAREN; }
","     { return COMMA; }
"+"     { return PLUS; }
"*"     { return MULT; }
[ \t]   { /* Ignore whitespace. */ }
[\n]    { /* Ignore newline. */ }


%%

int yywrap() {
    return 1;
}

