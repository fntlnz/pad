#include <string>
#include "ast/node.hpp"
#include "ast/use_element_node.hpp"
#ifndef PAD_AST_USE_H_
#define PAD_AST_USE_H_

namespace pad {
namespace ast {

enum UseNodeType {
  FUNCTION,
  CONST,
  CLASS
};

class UseNode : public Node {
  public:
    UseNodeType type;
    std::list<UseElementNode*> use_list;
    std::string getRaw();
};

} /* ast */
} /* pad */
#endif /* ifndef PAD_AST_USE_H_ */
