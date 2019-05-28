var myTree = Node(Leaf("foo"), Node(Leaf("bar"), Leaf("foobar")));
var node = switch(myTree) {
  case Node(leafNode = Leaf("foo"), _): leafNode;
  case x: x;
}
trace(node); // Leaf(foo)