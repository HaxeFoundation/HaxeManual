## 5.18 try/catch

Haxe allows catching values using its `try/catch` syntax:

```haxe
try try-expr
catch(varName1:Type1) catch-expr-1
catch(varName2:Type2) catch-expr-2
```

If during runtime the evaluation of `try-expression` causes a [`throw`](expression-throw.md), it can be caught by any subsequent `catch` block. These blocks consist of

* a variable name which holds the thrown value,
* an explicit type annotation which determines which types of values to catch, and
* the expression to execute in that case.

Haxe allows throwing and catching any kind of value, it is not limited to types inheriting from a specific exception or error class. Catch blocks are checked from top to bottom with the first one whose type is compatible with the thrown value being picked.

This process has many similarities to the compile-time [unification](type-system-unification.md) behavior. However, since the check has to be done at runtime there are several restrictions:

* The type must exist at runtime: [Class instances](types-class-instance.md), [enum instances](types-enum-instance.md), [abstract core types](types-abstract-core-type.md) and [Dynamic](types-dynamic.md).
* Type parameters can only be [Dynamic](types-dynamic.md).

---

Previous section: [switch](expression-switch.md)

Next section: [return](expression-return.md)