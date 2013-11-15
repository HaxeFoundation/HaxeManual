## 6.3.10 Exhaustiveness checks

The compiler ensures that you do not forget a possible case for non value-only switches:

```haxe
switch(true) {
    case false:
} // This match is not exhaustive, these patterns are not matched: true
```

The matched type `Bool` admits two values `true` and `false`, but only `false` is checked.

---

Previous section: [Extractors](extractors.md)

Next section: [Useless pattern checks](useless_pattern_checks.md)