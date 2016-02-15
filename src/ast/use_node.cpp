#include "ast/use_node.hpp"

std::string pad::ast::UseNode::getRaw() {

  std::string ret("Use list node of type " + std::to_string(type));

  if (use_list.size() == 0) {
    return ret;
  }

  ret += "\n";
  for (auto &elem : use_list) {
    ret += elem->getRaw();
    if (elem != use_list.back()) {
      ret += "\n";
    }
  }
  return ret;
}
