#include "ast/statement_list_node.hpp"

std::string pad::ast::StatementListNode::getRaw() {
  auto children_size_string = std::to_string(children.size());
  std::string ret("Statement list node containing "  + children_size_string + " children");
  if (children.size() == 0) {
    return ret;
  }
  ret += "\n";
  for (auto &c : children) {
    ret += c->getRaw();
    if (c != children.back()) {
      ret += "\n";
    }
  }
  return ret;
}
