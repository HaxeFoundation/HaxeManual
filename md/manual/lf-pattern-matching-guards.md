## 6.4.7 Guards

It is also possible to further restrict patterns with the `case ... if(condition):` syntax:

```haxe
    trace(match); // 1


    var match = switch(7) {
      case 4 | 1: "0";
      case 6 | 7: "1";
      case _: "2";
    }
    trace(match); // 1
```

The first case has an additional guard condition `if (b > a)`. It will only be selected if that condition holds, otherwise matching continues with the next case.

---

Previous section: [Or patterns](lf-pattern-matching-or.md)

Next section: [Match on multiple values](lf-pattern-matching-tuples.md)

Contribute: [fileAndLines](https://github.com/HaxeFoundation/HaxeManual/blob/master/06-language-features.tex#L200-200)