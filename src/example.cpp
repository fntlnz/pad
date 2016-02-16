#include "example.hpp"
#include "ast/node.hpp"
#include "ast/const_declaration_node.hpp"
#include "ast/namespace_node.hpp"
#include "ast/use_element_node.hpp"
#include "ast/use_node.hpp"
#include "ast/variable_node.hpp"
#include "ast/group_use_node.hpp"
#include <iostream>
extern "C"{
#include "parser/parser.hpp"
}
extern "C" FILE *yyin;
extern "C" pad::ast::StatementListNode *root;

int parse() {
  // open a file handle to a particular file:
  FILE *myfile = fopen("test.php", "r");
  // make sure it is valid:
  if (!myfile) {
    std::cout << "I can't open test.php!" << std::endl;
    return -1;
  }
  // set flex to read from it instead of defaulting to STDIN:
  yyin = myfile;
  // parse through the input until there is no more:
  do {
    yyparse();
  } while (!feof(yyin));

  std::cout << root->getRaw() << std::endl;
  return 0;
}
