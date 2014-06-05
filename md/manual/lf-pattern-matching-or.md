## 6.4.6 Or patterns

The `|` operator can be used anywhere within patterns to describe multiple accepted patterns:

```haxe
    var myArray = [1, 6];
    var match = switch(myArray) {
      case [2, _]: "0";
      case [_, 6]: "1";
      case []: "2";
      case [_, _, _]: "3";
```

If there is a captured variable in an or-pattern, it must appear in both its sub-patterns.

---

Previous section: [Array matching](lf-pattern-matching-array.md)

Next section: [Guards](lf-pattern-matching-guards.md)

Contribute: [fileAndLines](https://github.com/HaxeFoundation/HaxeManual/blob/master/06-language-features.tex#L191-191)