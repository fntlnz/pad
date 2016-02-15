#include "ast/variable_node.hpp"

std::string pad::ast::VariableNode::getRaw() {
  return "Variable Node: " + name;
}
