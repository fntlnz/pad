%{
#include <cstdio>
#include <iostream>
#include <string>
#include "ast/node.hpp"
#include "ast/const_declaration_node.hpp"
#include "ast/const_element_node.hpp"
#include "ast/namespace_node.hpp"
#include "ast/statement_list_node.hpp"
#include "ast/use_element_node.hpp"
#include "ast/use_node.hpp"
#include "ast/variable_node.hpp"
#include "ast/group_use_node.hpp"

extern "C" int yylex();
extern "C" int yyparse();

pad::ast::StatementListNode *root;
void yyerror (char const *msg);

%}

%locations

%union {
  std::string *string;
  pad::ast::VariableNode *variable;
  pad::ast::UseElementNode *use_element;
  pad::ast::StatementListNode *statement_list;
  pad::ast::UseNode *use;
  pad::ast::GroupUseNode *group_use;
  pad::ast::ConstElementNode *const_element;
  pad::ast::ConstDeclarationNode *const_declaration;
  pad::ast::Node *node;
  pad::ast::UseNodeType use_node_type;
}

%token <string> TOKEN_STRING
%token <variable> TOKEN_VARIABLE

%token TOKEN_OPEN_TAG
%token TOKEN_CLOSE_TAG
%token TOKEN_NAMESPACE TOKEN_NAMESPACE_SEPARATOR
%token TOKEN_USE TOKEN_AS
%token TOKEN_FUNCTION TOKEN_CONST

%type <string> namespace_name
%type <statement_list> top_statements;
%type <node>  top_statement
%type <use> use_declarations unprefixed_use_declarations
%type <use_element> use_declaration unprefixed_use_declaration
%type <group_use> group_use_declaration
%type <const_element> const_decl
%type <const_declaration> const_list
%type <variable> variable callable_variable expr simple_variable
%type <use_node_type> use_type
%%

pad:
  TOKEN_OPEN_TAG top_statements TOKEN_CLOSE_TAG { root = $2; }
  ;

top_statements:
    top_statements top_statement { $1->children.push_back($2); $$ = $1; }
  | /* empty */  { $$ = new pad::ast::StatementListNode(); }

top_statement:
    TOKEN_NAMESPACE namespace_name ';' { $$ = new pad::ast::NamespaceNode(*$2); }
  | TOKEN_NAMESPACE namespace_name '{' top_statements '}' { auto n = new pad::ast::NamespaceNode(*$2); n->statement_list = $4; $$ = n;}
  | TOKEN_NAMESPACE '{' top_statements '}' { auto n = new pad::ast::NamespaceNode(""); n->statement_list = $3; $$ = n; }
  | TOKEN_USE use_type group_use_declaration ';'    {
      pad::ast::GroupUseNode *groupUseNode = (pad::ast::GroupUseNode *)$3;
      groupUseNode->use_declarations->type = $2;
      $$ = groupUseNode;
    }
  | TOKEN_USE use_declarations ';'  {
      pad::ast::UseNode *useNode = (pad::ast::UseNode *)$2;
      useNode->type = pad::ast::UseNodeType::CLASS;
      $$ = useNode;
    }
  | TOKEN_USE use_type use_declarations ';' {
      pad::ast::UseNode *useNode = (pad::ast::UseNode *)$3;
      useNode->type = $2;
      $$ = useNode;
    }
  | TOKEN_CONST const_list ';'  { $$ = $2; }
  ;

group_use_declaration:
    namespace_name TOKEN_NAMESPACE_SEPARATOR '{' unprefixed_use_declarations '}' {
      $$ = new pad::ast::GroupUseNode(*$1, $4);
    }
  |	TOKEN_NAMESPACE_SEPARATOR namespace_name TOKEN_NAMESPACE_SEPARATOR '{' unprefixed_use_declarations '}' {
      $$ = new pad::ast::GroupUseNode(*$2, $5);
    }
;

use_type:
    TOKEN_FUNCTION  { $$ = pad::ast::UseNodeType::FUNCTION; }
  | TOKEN_CONST     { $$ = pad::ast::UseNodeType::CONST; }
  ;

namespace_name:
    TOKEN_STRING { $$ = $1; }
  | namespace_name TOKEN_NAMESPACE_SEPARATOR TOKEN_STRING {
      $1->append("\\");
      $1->append(*$3);
      $$ = $1;
  }
  ;

use_declarations:
    use_declarations ',' use_declaration { $1->use_list.push_back($3); $$ = $1; }
  | use_declaration { auto n = new pad::ast::UseNode(); n->use_list.push_back($1); $$ = n; }
  ;

use_declaration:
    unprefixed_use_declaration { $$ = $1; }
  | TOKEN_NAMESPACE_SEPARATOR unprefixed_use_declaration { $$ = $2; }
  ;


unprefixed_use_declarations:
		unprefixed_use_declarations ',' unprefixed_use_declaration
			{ $1->use_list.push_back($3); $$ = $1; }
	|	unprefixed_use_declaration
			{ auto n = new pad::ast::UseNode(); n->use_list.push_back($1); $$ = n; }
;

unprefixed_use_declaration:
    namespace_name { $$ = new pad::ast::UseElementNode(*$1); }
  | namespace_name TOKEN_AS TOKEN_STRING {
      $$ = new pad::ast::UseElementNode(*$1, *$3);
  }
  ;

const_list:
    const_list ',' const_decl { $$ = $1; $1->const_list.push_back($3); }
  | const_decl {
      auto declaration = new pad::ast::ConstDeclarationNode();
      declaration->const_list.push_back($1);
      $$ = declaration;
    }
;

const_decl:
  TOKEN_STRING '=' expr {
    auto element = new pad::ast::ConstElementNode();
    element->name = *$1;
    element->expression = $3;
    $$ = element;
  }
  ;

expr:
  variable { $$ = $1; }
;

variable:
  callable_variable { $$ = $1; }
;

callable_variable:
  simple_variable {
    $$ = $1;
  }

simple_variable:
    TOKEN_VARIABLE      { $$ = $1; }
  | '$' '{' expr '}'  { $$ = $3; }
  | '$' simple_variable { $$ = $2; }
  ;

%%

void yyerror (char const *msg) {
  std::cout << "EEK, parse error!  Message: " << msg << "line: " << yylloc.first_line << std::endl;
  std::cout << "Parse error" << std::endl;
  std::cout << "Message: " << msg << std::endl;
  std::cout << "Context: " << std::endl;
  std::cout << "   Line: " << yylloc.first_line << std::endl;
  std::cout << "   First Column: " << yylloc.first_column << std::endl;
  std::cout << "   Last Column: " << yylloc.last_column << std::endl;

  exit(-1);
}

/* vim: set ts=2 sts=2 sw=2 et : */
