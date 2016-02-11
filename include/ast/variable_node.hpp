#include "ast/node.hpp"
#ifndef PAD_AST_VARIABLE_NODE_H_
#define PAD_AST_VARIABLE_NODE_H_
namespace pad {
namespace ast {
class VariableNode : public Node {
  public:
    VariableNode(std::string variable_name) : name(variable_name) {}
    std::string name;
    std::string getRaw();
};
} /* ast */
} /* pad */
#endif /* ifndef PAD_AST_VARIABLE_NODE_H_*/
