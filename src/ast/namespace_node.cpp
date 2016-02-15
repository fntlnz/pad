#include "ast/namespace_node.hpp"

std::string pad::ast::NamespaceNode::getRaw() {
  std::string ret("Namespace node: " + name);
  if (statement_list) {
    ret += statement_list->getRaw();
  }
  return ret;
}
