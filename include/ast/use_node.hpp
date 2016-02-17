#include <string>
#include "ast/node.hpp"
#include "ast/use_element_node.hpp"
#include "ast/use_type.hpp"

#ifndef PAD_AST_USE_H_
#define PAD_AST_USE_H_

namespace pad {
namespace ast {

class UseNode : public Node {
  public:
    UseType type;
    std::list<UseElementNode*> use_list;
    std::string getRaw();
};

} /* ast */
} /* pad */
#endif /* ifndef PAD_AST_USE_H_ */
