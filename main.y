%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int yylex();
void yyerror(const char *s);

// <expression> ::= <term> | <expression> "+" <term>
// <term> ::= <factor> | <term> "*" <factor>
// <factor> ::= <integer> | "pow(" <expression> "," <expression> ")" | "("
// <expression> ")"
// <integer> ::= INT

//  pow(2,pow(3,4))    результат (thanks to python): 2417851639229258349412352 actual: переполнение
//  pow(2,pow(2*2,1+1)) результат: 65536 
%}


%union {
  int num;
}

%token POW LPAREN RPAREN COMMA MULT PLUS
%token<num> INT
%type<num> integer factor term expression

%%

expression:
    term                  { $$ = $1; }
    | expression PLUS term { $$ = $1 + $3; printf("%d + %d = %d\n", $1, $3, $$); }
    ;

term:
    factor                  { $$ = $1; }
    | term MULT factor       { $$ = $1 * $3; printf("%d * %d = %d\n", $1, $3, $$);}
    ;

factor:
    integer     { $$ = $1; }
    | POW LPAREN expression COMMA expression RPAREN { long tmp = (long ) pow($3, $5); $$ = (int) tmp; printf("pow(%d,%d)=%ld\n", $3, $5, tmp); }
    | LPAREN expression RPAREN        { $$ = $2; }
    ;
integer: INT { $$=$1; printf("INT=%d\n", $1); }

%%

int main() {

    if (yyparse() == 0) {
        printf("Result = %d\n", yylval.num);
    } else {
        printf("Error in expression.\n");
    }

    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

