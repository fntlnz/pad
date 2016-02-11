#include "ast/node.hpp"
#ifndef PAD_AST_STATEMENT_LIST_NODE_H_
#define PAD_AST_STATEMENT_LIST_NODE_H_
namespace pad {
namespace ast {
class StatementListNode : public Node {
  public:
    std::list<std::unique_ptr<Node>> children;
    std::string getRaw();
};
}
}
#endif /* ifndef PAD_AST_STATEMENT_LIST_NODE_H_ */
