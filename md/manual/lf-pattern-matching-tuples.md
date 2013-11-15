## 6.3.8 Match on multiple values

Array syntax can also be used to match on multiple values:

```haxe
var s = switch [1, false, "foo"] {
	case [1, false, "bar"]: "0";
	case [_, true, _]: "1";
	case [_, false, _]: "2";
}
trace(s); // 2
```

This is quite similar to usual array matching, but there are differences:



* The number of elements is fixed, so patterns of different array length will not be accepted.
* It is not possible to capture the switch value in a variable, i.e. `case x` is not allowed (`case _` still is).

---

Previous section: [Guards](lf-pattern-matching-guards.md)

Next section: [Extractors](lf-pattern-matching-extractors.md)