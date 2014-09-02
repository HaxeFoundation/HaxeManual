## 5.24 type check

##### since Haxe 3.1.0

It is possible to employ compile-time type checks using the following syntax:

```haxe
(expr : type)
```

The parentheses are mandatory. Unlike [safe casts](expression-cast-safe.md) this construct has no run-time impact. It has two compile-time implications:

1. [Top-down inference](type-system-top-down-inference.md) is used to type `expr` with type `type`.
2. The resulting typed expression is [unified](type-system-unification.md) with type `type`.

This has the usual effect of both operations such as the given type being used as expected type when performing [unqualified identifier resolution](type-system-resolution-order.md) and the unification checking for [abstract casts](types-abstract-implicit-casts.md).

---

Previous section: [safe cast](expression-cast-safe.md)

Next section: [Language Features](lf.md)