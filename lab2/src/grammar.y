%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(char const * msg);
int line_count = 0; 


%}

%token TOK_LPARENT TOK_RPARENT TOK_COMMA TOK_BOR TOK_BAND TOK_IDENTIFIER TOK_ASSIGN TOK_BNOT TOK_ILIT TOK_ERROR;
%type exp

%%
input
: %empty
| input line {line_count++;}
;

line
: '\n'
| exp
| exp '\n'
;

exp
: TOK_IDENTIFIER TOK_ASSIGN TOK_ILIT
| TOK_IDENTIFIER TOK_LPARENT TOK_IDENTIFIER TOK_RPARENT
| indentifier_or_ilit operation indentifier_or_ilit
| TOK_LPARENT exp TOK_RPARENT operation indentifier_or_ilit
;

indentifier_or_ilit
: TOK_IDENTIFIER
| TOK_ILIT
;

operation
: TOK_BOR
| TOK_BAND
;
%%


void yyerror(char const * msg){
    printf("In line %d: %s\n", line_count, msg);
    exit(1);
}


int main(int argc, char **argv)
{
    FILE *file = fopen(argv[1],"r");
    if (file) {
        yyrestart(file);
        yyparse();
    } else {
        yyparse();
    }
    return 0;
}