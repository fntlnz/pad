#include "ast/namespace_node.hpp"

std::string pad::ast::NamespaceNode::getRaw() {
  return "Namespace node: " + name;
}
