## 6.3.6 Or patterns

The `|` operator can be used anywhere within patterns to describe multiple accepted patterns:

```haxe
var match = switch(7) {
	case 4 | 1: "0";
	case 6 | 7: "1";
	case _: "2";
}
trace(match); // 1
```

If there's a captured variable in an or-pattern, it must appear in both its sub-patterns.

---

Previous section: [Array matching](lf-pattern-matching-array.md)

Next section: [Guards](lf-pattern-matching-guards.md)