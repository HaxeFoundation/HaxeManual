## 6.4.8 Match on multiple values

Array syntax can be used to match on multiple values:

```haxe
    var myArray = [7, 6];
    var s = switch(myArray) {
      case [a, b] if (b > a):
        b + ">" +a;
      case [a, b]:
        b + "<=" +a;
```

This is quite similar to usual array matching, but there are differences:

* The number of elements is fixed, so patterns of different array length will not be accepted.
* It is not possible to capture the switch value in a variable, i.e. `case x` is not allowed (`case _` still is).

---

Previous section: [Guards](lf-pattern-matching-guards.md)

Next section: [Extractors](lf-pattern-matching-extractors.md)

Contribute: [fileAndLines](https://github.com/HaxeFoundation/HaxeManual/blob/master/06-language-features.tex#L209-209)