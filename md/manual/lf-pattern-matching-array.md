## 6.4.5 Array matching

Arrays can be matched on fixed length:

```haxe
    var value = switch(myStructure) {
      case { name: "haxe", rating: "poor" }:
        throw false;
      case { rating: "awesome", name: n }:
        n;
      case _:
        "no awesome language found";
    }
    trace(value); // haxe
```

This will trace `1` because `array[1]` matches `6`, and `array[0]` is allowed to be anything.

---

Previous section: [Structure matching](lf-pattern-matching-structure.md)

Next section: [Or patterns](lf-pattern-matching-or.md)

Contribute: [fileAndLines](https://github.com/HaxeFoundation/HaxeManual/blob/master/06-language-features.tex#L182-182)