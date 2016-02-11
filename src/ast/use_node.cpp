#include "ast/use_node.hpp"

std::string pad::ast::UseNode::getRaw() {
  return "Use list node of type " + std::to_string(type);
}
