var myTree = Node(Leaf("foo"), Node(Leaf("bar"), Leaf("foobar")));
myTree.match(Node(_));
// is equivalent to
switch(myTree) {
  case Node(_):
    true;
  case _:
    false;
}