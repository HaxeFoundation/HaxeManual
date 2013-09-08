It is possible to catch any value of a sub-pattern by matching it against an identifier:

```
var name = switch(myTree) {
	case Leaf(s): s;
	case Node(Leaf(s), _): s;
	case _: "none";
}
trace(name); // foo
```

This would return one of the following:



* If `myTree` is a `Leaf`, its name is returned.
* If `myTree` is a `Node` whose left sub-tree is a `Leaf`, its name is returned (this will apply here, returning `"foo"`).
* Otherwise `"none"` is returned.



It is also possible to use = to capture values which are further matched:

```
case Node(leafNode = Leaf("foo"), _): leafNode;
case x: x;

race(node); // Leaf(foo)
```

Here, `leafNode` is bound to `Leaf("foo")` if the input matches that. In all other cases, `myTree` itself is returned: `case x` works similar to `case _` in that it matches anything, but with an identifier name like `x` it also binds the matched value to that variable.