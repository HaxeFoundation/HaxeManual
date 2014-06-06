## 6.4.10 Exhaustiveness checks

The compiler ensures that no possible cases are forgotten:

```haxe
switch(true) {
    case false:
} // Unmatched patterns: true
```

The matched type `Bool` admits two values `true` and `false`, but only `false` is checked.

---

Previous section: [Extractors](lf-pattern-matching-extractors.md)

Next section: [Useless pattern checks](lf-pattern-matching-unused.md)