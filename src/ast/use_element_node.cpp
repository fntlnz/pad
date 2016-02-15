#include "ast/use_element_node.hpp"

std::string pad::ast::UseElementNode::getRaw() {
  if (alias.size() == 0) {
    return "Use node: " + name;
  }
  return "Use node: " + name + " alias: " + alias;
}
