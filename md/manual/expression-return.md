## 5.19 return

A `return` expression can come with or without an value expression:

```haxe
return;
return expression;
```

It leaves the control-flow of the innermost function it is declared in, which has to be distinguished when [local functions](expression-function.md) are involved:

```haxe
function f1() {
	function f2() {
		return;
	}
	f2();
	expression;
}
```

The `return` leaves local function `f2`, but not `f1`, meaning `expression` is still evaluated.

If `return` is used without a value expression, the typer ensures that the return type of the function it returns from is of `Void`. If it has a value expression, the typer [unifies](type-system-unification.md) its type with the return type (explicitly given or inferred by previous `return` expressions) of the function it returns from.

---

Previous section: [try/catch](expression-try-catch.md)

Next section: [break](expression-break.md)