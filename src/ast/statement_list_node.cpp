#include "ast/statement_list_node.hpp"

std::string pad::ast::StatementListNode::getRaw() {
  auto children_size_string = std::to_string(children.size());
  return "Statement list node containing "  + children_size_string + " children";
}
