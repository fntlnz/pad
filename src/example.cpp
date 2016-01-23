#include "example.hpp"
#include "ast/node.hpp"
#include <string>
#include <iostream>
#include <typeinfo>
extern "C"{
#include "parser/parser.hpp"
}

extern "C" FILE *yyin;
extern "C" pad::ast::Node *root;

void dump_ast(pad::ast::Node *ast) {
  std::cout << typeid(ast).name() << " :" << ast->value << std::endl;
  for (auto& v : ast->children) {
    dump_ast(v);
  }
}

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

  dump_ast(root);
  return 0;
}
