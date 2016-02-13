#include <memory>

#include "ast/node.hpp"

#ifndef PAD_AST_CONST_ELEMENT_NODE_H_
#define PAD_AST_CONST_ELEMENT_NODE_H_
namespace pad {
namespace ast {
class ConstElementNode : public Node {
  public:
    std::string name;
    Node *expression;
    std::string getRaw();
};
} /* ast  */
} /* pad  */
#endif /* ifndef PAD_AST_CONST_ELEMENT_NODE_H_ */
