#include <memory>

#include "ast/node.hpp"

#ifndef PAD_AST_CONST_ELEMENT_NODE_H_
#define PAD_AST_CONST_ELEMENT_NODE_H_
namespace pad {
namespace ast {
class ConstElementNode : public Node {
  public:
    ConstElementNode(std::string n, std::unique_ptr<Node> expr) : name(n), expression(std::move(expr)) {}
    std::string name;
    std::unique_ptr<Node> expression;
    std::string getRaw();
};
} /* ast  */
} /* pad  */
#endif /* ifndef PAD_AST_CONST_ELEMENT_NODE_H_ */
