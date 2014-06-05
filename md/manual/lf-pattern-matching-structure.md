## 6.4.4 Structure matching

It is also possible to match against the fields of anonymous structures and instances:

```haxe
        leafNode;
      case x: x;
    }
    trace(node); // Leaf(foo)

    var myStructure = {
      name: "haxe",
```

In the second case we bind the matched `name` field to identifier `n` if `rating` matches `"awesome"`. Of course this structure could also be put into the `Tree` from the previous example to combine structure and enum matching.

A limitation with regards to class instances is that you cannot match against fields of their parent class.

---

Previous section: [Variable capture](lf-pattern-matching-variable-capture.md)

Next section: [Array matching](lf-pattern-matching-array.md)

Contribute: [fileAndLines](https://github.com/HaxeFoundation/HaxeManual/blob/master/06-language-features.tex#L171-171)