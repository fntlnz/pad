#include "ast/const_element_node.hpp"

std::string pad::ast::ConstElementNode::getRaw() {
  return "Const element Node: " + name + " - expr: " + expression->getRaw();
}
