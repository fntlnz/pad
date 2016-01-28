#include <vector>
#include <string>
#ifndef PAD_AST_NODE_H
#define PAD_AST_NODE_H
namespace pad {
namespace ast {
class Node {
  public:
    std::vector<Node *> children;
    virtual std::string getRaw() = 0;
};

class StatementListNode : public Node {
  public:
    std::string getRaw() {
      return "Statement list node";
    }
};

class NamespaceNode : public Node {
  public:
    NamespaceNode(std::string n) : name(n) {};
    const std::string name;
    std::string getRaw() {
      return "Namespace: " + name;
    }
};

enum UseNodeType {
  FUNCTION,
  CONST,
  CLASS
};

const std::string getUseNodeTypeString(UseNodeType type);

class UseNode : public Node {
  public:
    std::string getRaw() {
      return "Use list node of type " + getUseNodeTypeString(type);
    }
    UseNodeType type;
};


class UseElementNode : public Node {
  public:
    UseElementNode(std::string n) : name(n) {};
    UseElementNode(std::string n, std::string a) : name(n), alias(a) {};
    const std::string name;
    const std::string alias;
    std::string getRaw() {
      if (alias.empty()) {
        return "Use: " + name;
      }
      return "Use: " + name + " as " + alias;
    }
};

} /* ast */
} /* pad  */ 
#endif /* ifndef PAD_AST_NODE_H */
