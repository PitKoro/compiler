%option noyywrap

%{
#include <stdio.h>

void printToken(char* str, char* className) {
    printf("<%s, %s>\n", className, str);
}
%}
WHITESPACES [\t ]+
LPARENT [(]
RPARENT [)]
COMMA [,]
BOR [|]
BAND [&]
IDENTIFIER [[:alpha:]_][[:alnum:]_]*
ASSIGN [=]
ILIT 0[xX][0-9a-fA-F]+


%%
{WHITESPACES} {};
{LPARENT} { printToken(yytext, "LPARENT");}
{RPARENT} { printToken(yytext, "RPARENT");}
{BOR} { printToken(yytext, "BOR");}
{BAND} { printToken(yytext, "BAND");}
{IDENTIFIER} { printToken(yytext, "IDENTIFIER");}
{ASSIGN} { printToken(yytext, "ASSIGN");}
{ILIT} { printToken(yytext, "ILIT");}
{ERROR} { printToken(yytext, "ERROR");}

%%

int main()
{
    yylex();
    return 0;
}