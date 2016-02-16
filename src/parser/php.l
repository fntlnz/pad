%{
#include <iostream>
using namespace std;
#define YY_DECL extern "C" int yylex()
int yycolumn = 1;
#define YY_USER_ACTION  yylloc.first_line = yylloc.last_line = yylineno; \
    yylloc.first_column = yycolumn; \
    yylloc.last_column = yycolumn + yyleng - 1; \
    yycolumn += yyleng;
#include "ast/node.hpp"
#include "ast/const_declaration_node.hpp"
#include "ast/const_element_node.hpp"
#include "ast/namespace_node.hpp"
#include "ast/statement_list_node.hpp"
#include "ast/use_element_node.hpp"
#include "ast/use_node.hpp"
#include "ast/variable_node.hpp"
#include "ast/group_use_node.hpp"
#include "parser/parser.hpp"

%}
%s IN_SCRIPTING
%s DOUBLE_QUOTES
%s HEREDOC
%s BACKQUOTE
%s VAR_OFFSET
%option yylineno
%option noyywrap
%option nounput
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
<IN_SCRIPTING>"use" {
    return TOKEN_USE;
}
<IN_SCRIPTING>"as" {
    return TOKEN_AS;
}
<IN_SCRIPTING>"const" {
    return TOKEN_CONST;
}
<IN_SCRIPTING>"function" {
    return TOKEN_FUNCTION;
}
<IN_SCRIPTING>{LABEL} {
    yylval.string = new std::string(strdup(yytext));
    return TOKEN_STRING;
}

<IN_SCRIPTING,DOUBLE_QUOTES,HEREDOC,BACKQUOTE,VAR_OFFSET>"$"{LABEL} {
    yylval.variable = new pad::ast::VariableNode(std::string(strdup(yytext)));
    return TOKEN_VARIABLE;
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
