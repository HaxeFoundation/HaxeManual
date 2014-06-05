## 6.4.3 Variable capture

It is possible to catch any value of a sub-pattern by matching it against an identifier:

```haxe
    trace(match); // 2


    var myTree = Node(Leaf("foo"),
      Node(Leaf("bar"), Leaf("foobar")));
    var name = switch(myTree) {
      case Leaf(s): s;
```

This would return one of the following:



* If `myTree` is a `Leaf`, its name is returned.
* If `myTree` is a `Node` whose left sub-tree is a `Leaf`, its name is returned (this will apply here, returning `"foo"`).
* Otherwise `"none"` is returned.



It is also possible to use = to capture values which are further matched:

```haxe
      case _: "none";
    }
    trace(name); // foo

    var node = switch(myTree) {
```

Here, `leafNode` is bound to `Leaf("foo")` if the input matches that. In all other cases, `myTree` itself is returned: `case x` works similar to `case _` in that it matches anything, but with an identifier name like `x` it also binds the matched value to that variable.

---

Previous section: [Enum matching](lf-pattern-matching-enums.md)

Next section: [Structure matching](lf-pattern-matching-structure.md)

Contribute: [fileAndLines](https://github.com/HaxeFoundation/HaxeManual/blob/master/06-language-features.tex#L150-150)