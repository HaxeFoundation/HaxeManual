## 6.3.3 Variable capture

It is possible to catch any value of a sub-pattern by matching it against an identifier:

```haxe
var myTree = Node(Leaf("foo"), Node(Leaf("bar"), Leaf("foobar")));
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

```haxe
var node = switch(myTree) {
	case Node(leafNode = Leaf("foo"), _): leafNode;
	case x: x;
}
trace(node); // Leaf(foo)
```

Here, `leafNode` is bound to `Leaf("foo")` if the input matches that. In all other cases, `myTree` itself is returned: `case x` works similar to `case _` in that it matches anything, but with an identifier name like `x` it also binds the matched value to that variable.

---

Previous section: [Enum matching](lf-pattern-matching-enums.md)

Next section: [Structure matching](lf-pattern-matching-structure.md)