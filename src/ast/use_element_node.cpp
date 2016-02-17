#include "ast/use_element_node.hpp"

std::string pad::ast::UseElementNode::getRaw() {
  std::string ret("Use node: ");
  ret.append(name);
  if (alias.size() > 0) {
    ret.append(" - alias: ");
    ret.append(alias);
  }

  if (type) {
    ret.append(" - type: ");
    ret.append(std::to_string(type));
  }

  return ret;
}
