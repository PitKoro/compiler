%option noyywrap

%{
#include "../includes/grammar.h"
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
{LPARENT} {return TOK_LPARENT;}
{RPARENT} {return TOK_RPARENT;}
{COMMA} {return TOK_COMMA;}
{BOR} {return TOK_BOR;}
{BAND} {return TOK_BAND;}
{IDENTIFIER} {return TOK_IDENTIFIER;}
{ASSIGN} {return TOK_ASSIGN;}
{BNOT} {return TOK_BNOT;}
{ILIT} {return TOK_ILIT;}
{ERROR} {return TOK_ERROR;}
%%
