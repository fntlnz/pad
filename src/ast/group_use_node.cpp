#include "ast/group_use_node.hpp"

std::string pad::ast::GroupUseNode::getRaw() {
  std::string ret("Group use node\n");
  ret.append(this->use_declarations->getRaw());
  return ret;
}
