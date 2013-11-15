## 6.3.2 Enum matching

As with haxe 2, enums can be matched by their constructors in a natural way. With haxe 3 pattern matching, this match can now be "deep":

```haxe
var myTree = Node(Leaf("foo"), Node(Leaf("bar"), Leaf("foobar")));
var match = switch(myTree) {
	// matches any Leaf
	case Leaf(_): "0";
	// matches any Node that has r = Leaf
	case Node(_, Leaf(_)): "1";
	// matches any Node that has has r = another Node, which has l = Leaf("bar")
	case Node(_, Node(Leaf("bar"), _)): "2";
	// matches anything
	case _: "3";
}
trace(match); // 2
```

The pattern matcher will check each case from top to bottom and pick the first one that matches the input value. If you are not too familiar with pattern matching, the following manual interpretation of each case rule might help:



* `case Leaf(_)`: matching fails because `myTree` is a `Node`
* `case Node(_, Leaf(_))`: matching fails because the right sub-tree of `myTree` is not a `Leaf`, but another `Node`
* `case Node(_, Node(Leaf("bar"), _))`: matching succeeds
* `case _`: this is not checked here because the previous line matched

---

Previous section: [Introduction](lf-pattern-matching-introduction.md)

Next section: [Variable capture](lf-pattern-matching-variable-capture.md)