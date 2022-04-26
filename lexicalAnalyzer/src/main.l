%option noyywrap

%{
#include <stdbool.h>

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
BNOT [!]
ILIT 0[x]([0-9aA-fF]+)
ERROR .|[0-9]+|0[x]([0-9aA-zZ]+)|[0-9][aA-zZ]+


%%
{WHITESPACES} {};
{LPARENT} { printToken(yytext, "LPARENT");}
{RPARENT} { printToken(yytext, "RPARENT");}
{COMMA} { printToken(yytext, "COMMA");}
{BOR} { printToken(yytext, "BOR");}
{BAND} { printToken(yytext, "BAND");}
{IDENTIFIER} { printToken(yytext, "IDENTIFIER");}
{ASSIGN} { printToken(yytext, "ASSIGN");}
{BNOT} { printToken(yytext, "BNOT");}
{ILIT} { printToken(yytext, "ILIT");}
{ERROR} { printToken(yytext, "ERROR");}

%%

int main(int argc, char *argv[])
{
    
    FILE *file=fopen(argv[1],"r");
    if (file) {
        yyrestart(file);
        yylex();
    } else {
        yylex();
    }

    return 0;
}