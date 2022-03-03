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
{ILIT} { printToken(yytext, "ILIT");}
{ERROR} { printToken(yytext, "ERROR");}

%%

int main()
{
    bool is_testing = false;
    
    if(is_testing) {
        FILE* test_file = fopen("test.txt", "r");
        yyrestart(test_file);
        yylex();
    } else {
        yylex();
    }
    

    return 0;
}