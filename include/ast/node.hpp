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
    std::string getRaw() {
      return "Namespace Node";
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

class StringNode : public Node {
  public:
    std::string value;
    std::string getRaw() {
      return "String node: " + value;
    }
};

class UseElementNode : public Node {
  public:
    std::string getRaw() {
      return "Use element node";
    }
};


} /* ast */
} /* pad  */ 
#endif /* ifndef PAD_AST_NODE_H */
