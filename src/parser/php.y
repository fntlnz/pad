%{
#include <cstdio>
#include <iostream>
#include <string>
using namespace std;

// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
 
void yyerror (char const *msg);
%}

%locations

%union {
  int ival;
  float fval;
  char *sval;
  std::string *realstringval;
}

%token <sval> TOKEN_STRING

%token TOKEN_OPEN_TAG
%token TOKEN_CLOSE_TAG
%token TOKEN_NAMESPACE TOKEN_NAMESPACE_SEPARATOR
%token TOKEN_USE
%token TOKEN_FUNCTION TOKEN_CONST

/*%type <ival> use_type;*/
%type <realstringval> namespace_name use_declaration unprefixed_use_declaration

%%

pad:
  TOKEN_OPEN_TAG top_statements TOKEN_CLOSE_TAG
  ;

top_statements:
  top_statements top_statement { cout << "found top statement" << endl; }
  | /* empty */  { cout << "allocate statement list" << endl; } /* allocate statement list when a data structure is available to do so */

top_statement:
  TOKEN_NAMESPACE namespace_name ';' { cout << "Namespace: " << *$2 << endl; }
  | TOKEN_NAMESPACE namespace_name '{' top_statements '}' { cout << "Namespace: " << *$2 << endl; }
  | TOKEN_NAMESPACE '{' top_statements '}' { cout << "Global namespace" << endl; }
  | TOKEN_USE use_declarations ';'  { cout << "Found use statement" << endl; }
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
  /*use_declarations ',' use_declaration { [> do nothing for now <] }*/
  use_declaration { cout << "Using delcaration of: "  << *$1 << endl; }
  ;

use_declaration:
  unprefixed_use_declaration { $$ = $1; }
  | TOKEN_NAMESPACE_SEPARATOR unprefixed_use_declaration { $$ = $2; }

unprefixed_use_declaration:
  namespace_name { $$ = $1; }
  /*| namespace_name TOKEN_AS TOKEN_STRING { }*/

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
