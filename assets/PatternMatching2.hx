var myTree = Node(Leaf("foo"), Node(Leaf("bar"), Leaf("foobar")));
var name = switch (myTree) {
    case Leaf(s): s;
    case Node(Leaf(s), _): s;
    case _: "none";
  }
trace(name); // foo
