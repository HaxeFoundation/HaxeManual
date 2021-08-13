var myTree = Node(Leaf("foo"), Node(Leaf("bar"), Leaf("foobar")));
var match = switch (myTree) {
    // matches any Leaf
    case Leaf(_): "0";
    // matches any Node that has r = Leaf
    case Node(_, Leaf(_)): "1";
    // matches any Node that has
    // r = another Node, which has
    // l = Leaf("bar")
    case Node(_, Node(Leaf("bar"), _)): "2";
    // matches anything
    case _: "3";
  }
trace(match); // 2
