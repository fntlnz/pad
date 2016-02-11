#include "example.hpp"
#include "ast/node.hpp"
#include <string>
#include <iostream>
#include <typeinfo>
#include "parser/parser.hpp"

FILE *yyin;

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

  return 0;
}
