#include <vector>
#include <string>
#ifndef PAD_AST_NODE_H
#define PAD_AST_NODE_H
namespace pad {
namespace ast {
class Node {
  public:
    Node(std::string val) : value(val) { };
    Node() { };
    std::string value;
    std::vector<Node *> children;
};
} /* ast */
} /* pad  */ 
#endif /* ifndef PAD_AST_NODE_H */
