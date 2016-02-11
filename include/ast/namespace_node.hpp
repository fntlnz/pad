#include <memory>

#include "ast/statement_list_node.hpp"

#ifndef PAD_AST_NAMESPACE_H_
#define PAD_AST_NAMESPACE_H_
namespace pad {
namespace ast {
class NamespaceNode : public Node {
  public:
    NamespaceNode(std::string namespace_name) : name(namespace_name) {}
    std::string name;
    std::unique_ptr<StatementListNode> statement_list;
    std::string getRaw();
};
} /* ast */
} /* pad */
#endif /* ifndef PAD_AST_NAMESPACE_H_*/
