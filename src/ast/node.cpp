#include "ast/node.hpp"

const std::string pad::ast::getUseNodeTypeString(UseNodeType type) {
  const std::string type_strings[] = {
    "FUNCTION",
    "CONST",
    "CLASS",
  };

  return type_strings[type];
}
