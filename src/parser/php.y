%{
#include <cstdio>
#include <iostream>
#include <string>
#include "ast/node.hpp"
using namespace std;
using namespace pad::ast;

extern "C" int yylex();
extern "C" int yyparse();

Node *root;
void yyerror (char const *msg);

%}

%locations

%union {
  int ival;
  float fval;
  char *sval;
  std::string *realstringval;
  pad::ast::Node *node;
}

%token <sval> TOKEN_STRING

%token TOKEN_OPEN_TAG
%token TOKEN_CLOSE_TAG
%token TOKEN_NAMESPACE TOKEN_NAMESPACE_SEPARATOR
%token TOKEN_USE TOKEN_AS
%token TOKEN_FUNCTION TOKEN_CONST

%type <realstringval> namespace_name
%type <node> top_statements top_statement use_declaration use_declarations unprefixed_use_declaration
%%

pad:
  TOKEN_OPEN_TAG top_statements TOKEN_CLOSE_TAG { root = $2; }
  ;

top_statements:
  top_statements top_statement { $1->children.push_back($2); $$ = $1; }
  | /* empty */  { $$ = new StatementListNode(); }

top_statement:
  TOKEN_NAMESPACE namespace_name ';' { $$ = new NamespaceNode(*$2); }
  | TOKEN_NAMESPACE namespace_name '{' top_statements '}' { $$ = new NamespaceNode(*$2); $$->children.push_back($4); }
  | TOKEN_NAMESPACE '{' top_statements '}' { $$ = new NamespaceNode(""); $$->children.push_back($3); }
  | TOKEN_USE use_declarations ';'  { $$ = $2; }
  ;

namespace_name:
  TOKEN_STRING { std::string *token_string = new std::string($1); $$ = token_string; }
  | namespace_name TOKEN_NAMESPACE_SEPARATOR TOKEN_STRING {
      $1->append("\\");
      $1->append($3);
      $$ = $1;
  }
  ;

/*use_type:*/
  /*TOKEN_FUNCTION  { $$ = TOKEN_FUNCTION; }*/
  /*| TOKEN_CONST   { $$ = TOKEN_CONST; }*/
/*  ;*/

use_declarations:
  use_declarations ',' use_declaration { $1->children.push_back($3); $$ = $1; }
  | use_declaration { $$ = $1;  }
  ;

use_declaration:
  unprefixed_use_declaration { $$ = $1; }
  | TOKEN_NAMESPACE_SEPARATOR unprefixed_use_declaration { $$ = $2; }

unprefixed_use_declaration:
  namespace_name { $$ = new UseElementNode(*$1); }
  | namespace_name TOKEN_AS TOKEN_STRING {
      std::string *alias_string = new std::string($3);
      $$ = new UseElementNode(*$1, *alias_string);
  }

%%

void yyerror (char const *msg) {
  cout << "EEK, parse error!  Message: " << msg << "line: " << yylloc.first_line << endl;
  cout << "Parse error" << endl;
  cout << "Message: " << msg << endl;
  cout << "Context: " << endl;
  cout << "   Line: " << yylloc.first_line << endl;
  cout << "   First Column: " << yylloc.first_column << endl;
  cout << "   Last Column: " << yylloc.last_column << endl;

  exit(-1);
}

/* vim: set ts=2 sts=2 sw=2 et : */
