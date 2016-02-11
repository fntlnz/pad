#include "ast/node.hpp"
#ifndef PAD_AST_USE_ELEMENT_NODE_H
#define PAD_AST_USE_ELEMENT_NODE_H
namespace pad {
namespace ast {
class UseElementNode : public Node {
  public:
    UseElementNode(std::string element_name) : name(element_name) {}
    UseElementNode(std::string element_name, std::string alias_name) : name(element_name), alias(alias_name) {}
    std::string name;
    std::string alias;
    std::string getRaw();
};
} /* pad */
} /* ast */
#endif /* ifndef PAD_AST_USE_ELEMENT_NODE_H */
