#include <vector>
#include <string>
#include <memory>
#include <list>

#ifndef PAD_AST_NODE_H_
#define PAD_AST_NODE_H_
namespace pad {
namespace ast {

class Node {
  public:
    virtual std::string getRaw() = 0;
};

} /* ast */
} /* pad  */
#endif /* ifndef PAD_AST_NODE_H_ */
