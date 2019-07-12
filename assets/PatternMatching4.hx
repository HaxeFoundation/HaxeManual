var myTree = Node(Leaf("foo"), Node(Leaf("bar"), Leaf("foobar")));
switch (myTree) {
  case Leaf(_):
  // ...
  case var node:
    // without var above the compiler would warn about a potential typo
    // node contains the entire matched tree
}
