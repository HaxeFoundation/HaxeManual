## 5.8 Array Access

Array access is expressed by using an opening bracket `[` followed by the index expression and a closing bracket `]`.

```haxe
expr[indexExpr]
```

This notation is allowed with arbitrary expressions, but at typing level only certain combinations are admitted:

* `expr` is of `Array` or `Dynamic` and `indexExpr` is of `Int`
* `expr` is an [abstract type](types-abstract.md) which defines a matching [array access](types-abstract-array-access.md)

---

Previous section: [Field Access](expression-field-access.md)

Next section: [Function Call](expression-function-call.md)