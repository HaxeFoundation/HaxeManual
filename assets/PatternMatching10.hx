var myTree = Node(Leaf("foo"), Node(Leaf("bar"), Leaf("foobar")));
trace(myTree.match(Leaf(_))); // false
trace(myTree.match(Node(_)|Leaf(_))); // true
trace(myTree.match(Node(Leaf("foo"),_))); // true