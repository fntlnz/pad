#include <string>
#include "ast/node.hpp"
#include "ast/use_element_node.hpp"
#include "ast/use_node.hpp"
#ifndef PAD_AST_GROUP_USE_H_
#define PAD_AST_GROUP_USE_H_
namespace pad {
namespace ast {

class GroupUseNode: public Node {
 public:
  GroupUseNode(std::string ns, UseNode *u) : namespace_name(ns), use_declarations(u) { };
  std::string namespace_name;
  UseNode *use_declarations;

  std::string getRaw();
};

} /* ast */
} /* pad */
#endif /* ifndef PAD_AST_GROUP_USE_H_ */
