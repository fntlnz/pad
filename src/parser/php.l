%{
#include <iostream>
using namespace std;
#define YY_DECL extern "C" int yylex()

int yycolumn = 1;
#define YY_USER_ACTION  yylloc.first_line = yylloc.last_line = yylineno; \
    yylloc.first_column = yycolumn; \
    yylloc.last_column = yycolumn + yyleng - 1; \
    yycolumn += yyleng;

#include "parser/parser.hpp"
%}

%s IN_SCRIPTING
%option yylineno
%option noyywrap
ANY_CHARACTER  .
LABEL [a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*
TOKENS [;:,.\[\]()|^&+-/*=%|~$<>?@]
%%
[ \t\n]           ;

<INITIAL>"<?php"    {
    BEGIN(IN_SCRIPTING);
    return TOKEN_OPEN_TAG;
}

<IN_SCRIPTING>"?>"  {
    BEGIN(INITIAL);
    return TOKEN_CLOSE_TAG;
}

<IN_SCRIPTING>"\\" {
    return TOKEN_NAMESPACE_SEPARATOR;
}

<IN_SCRIPTING>"namespace" {
    return TOKEN_NAMESPACE;
}

<IN_SCRIPTING>{LABEL} {
    yylval.sval = strdup(yytext);
    return TOKEN_STRING;
}

<IN_SCRIPTING>{TOKENS} {
    return yytext[0];
}

<IN_SCRIPTING>"{" {
    /* TODO: push and pop scopes stack see zend_language_scanner.l:1577 */
    return yytext[0];
}

<IN_SCRIPTING>"}" {
    /* TODO: push and pop scopes stack see zend_language_scanner.l:1577 */
    return yytext[0];
}

<INITIAL>{ANY_CHARACTER} ;
%%
