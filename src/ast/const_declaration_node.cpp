#include "ast/const_declaration_node.hpp"

std::string pad::ast::ConstDeclarationNode::getRaw() {
  std::string ret("Constants declaration Node");

  if (const_list.size() == 0) {
    return ret;
  }

  ret += "\n";

  for (auto &c : const_list) {
    ret += c->getRaw();
    if (c != const_list.back()) {
      ret += "\n";
    }
  }
  return ret;
}
