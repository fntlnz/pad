#include <list>
#include "ast/node.hpp"
#include "ast/const_element_node.hpp"
#ifndef PAD_AST_CONST_DECLARATION_NODE_H_
#define PAD_AST_CONST_DECLARATION_NODE_H_
namespace pad {
namespace ast {
class ConstDeclarationNode : public Node {
  public:
    std::list<ConstElementNode*> const_list;
    std::string getRaw();
};
} /* ast  */
} /* pad  */
#endif /* ifndef PAD_AST_CONST_DECLARATION_NODE_H_ */
