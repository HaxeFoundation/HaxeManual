## 6.4.12 Single pattern check

The compiler provides the function `match` to check if an enum value matches a given pattern:

```haxe
    var myTree = Node(Leaf("foo"), Node(Leaf("bar"), Leaf("foobar")));
    var value = "foo";
    trace(myTree.match(Leaf(_))); // false
    trace(myTree.match(Node(_)|Leaf(_))); // true
    trace(myTree.match(Node(Leaf("foo"),_))); // true
    trace(myTree.match(Node(Leaf(value),_))); // true
```

As this function only tests if the pattern is matched, guards and variable capture are unavailable.

The `match` function is equivalent to a `switch` with a single `case` for the given pattern, returning `true`, and a `default` returning `false`.

```haxe
    myTree.match(Node(_));
    // is equivalent to
    switch(myTree) {
      case Node(_):
        true;
      case _:
        false;
    }
```

See the [EnumValue API documentation (since Haxe 3.2.1)](https://api.haxe.org/haxe/EnumValueTools.html#match) for more information.

---

Previous section: [Useless pattern checks](lf-pattern-matching-unused.md)

Next section: [String Interpolation](lf-string-interpolation.md)