## 6.4.9 Extractors

##### since Haxe 3.1.0

Extractors allow applying transformations to values being matched. This is often useful when a small operation is required on a matched value before matching can continue:

```haxe
enum Test {
  TString(s:String);
  TInt(i:Int);
}

class Main {
  static public function main() {
    var e = TString("fOo");
    switch(e) {
      case TString(temp):
        switch(temp.toLowerCase()) {
          case "foo": true;
          case _: false;
        }
      case _: false;
    }
  }
}
```

Here we have to capture the argument value of the `TString` enum constructor in a variable `temp` and use a nested switch on `temp.toLowerCase()`. Obviously, we want matching to succeed if `TString` holds a value of `"foo"` regardless of its casing. This can be simplified with extractors:

```haxe
enum Test {
  TString(s:String);
  TInt(i:Int);
}

class Main {
  static public function main() {
    var e = TString("fOo");
    var success = switch(e) {
      case TString(_.toLowerCase() => "foo"):
        true;
      case _:
        false;
    }
  }
}
```

Extractors are identified by the `extractorExpression => match` expression. The compiler generates code which is similar to the previous example, but the original syntax was greatly simplified. Extractors consist of two parts, which are separated by the `=>` operator:

1. The left side can be any expression, where all occurrences of underscore `_` are replaced with the currently matched value.
2. The right side is a pattern which is matched against the result of the evaluation of the left side.

Since the right side is a pattern, it can contain another extractor. The following example "chains" two extractors:

```haxe
class Main {
  static public function main() {
    switch(3) {
      case add(_, 1) => mul(_, 3) => a:
        trace(a);
    }
  }

  static function add(i1:Int, i2:Int) {
    return i1 + i2;
  }

  static function mul(i1:Int, i2:Int) {
    return i1 * i2;
  }
}
```

This traces `12` as a result of the calls to `add(3, 1)`, where `3` is the matched value, and `mul(4, 3)` where `4` is the result of the `add` call. It is worth noting that the `a` on the right side of the second `=>` operator is a [capture variable](lf-pattern-matching-variable-capture.md).

It is currently not possible to use extractors within [or-patterns](lf-pattern-matching-or.md):

```haxe
class Main {
  static public function main() {
    switch("foo") {
      // Extractors in or patterns are not allowed
      case (_.toLowerCase() => "foo") | "bar":
    }
  }
}
```

However, it is possible to have or-patterns on the right side of an extractor, so the previous example would compile without the parentheses.

---

Previous section: [Match on multiple values](lf-pattern-matching-tuples.md)

Next section: [Exhaustiveness checks](lf-pattern-matching-exhaustiveness.md)