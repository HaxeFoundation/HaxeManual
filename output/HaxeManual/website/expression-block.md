## 5.1 Blocks

A block in Haxe starts with an opening curly brace `{` and ends with a closing curly brace `}`. A block may contain several expressions, each of which is followed by a semicolon `;`. The general syntax is thus:

```haxe
{
	expr1;
	expr2;
	...
	exprN;
}
```
The value and by extension the type of a block-expression is equal to the value and the type of the last sub-expression.

Blocks can contain local variables declared by [`var` expression](expression-var.md), as well as local functions declared by [`function` expressions](expression-function.md). These are available within the block and within sub-blocks, but not outside the block. Also, they are available only after their declaration. The following example uses `var`, but the same rules apply to `function` usage:

```haxe
{
	a; // error, a is not declared yet
	var a = 1; // declare a
	a; // ok, a was declared
	{
		a; // ok, a is available in sub-blocks
	}
  // ok, a is still available after
	// sub-blocks	
	a;
}
a; // error, a is not available outside
```
At runtime, blocks are evaluated from top to bottom. Control flow (e.g. [exceptions](expression-try-catch.md) or [return expressions](expression-return.md)) may leave a block before all expressions
are evaluated.

##### Variable Shadowing

Haxe allows local variable shadowing within the same block. This means that
a `var` or `function` can be declared with the same name that was
previously available in a block, effectively hiding it from the further code:

```haxe
{
	var v = 42; // declare v
	$type(v); // Int
	var v = "hi"; // declare a new v
	$type(v); // String, previous declaration is not available
}
```

It might come as a surprise that this is allowed, but it's useful to avoid pollution of local name space and thus prevent accidental usage of a wrong variable.

Note, that the shadowing strictly follows syntax, so if a variable was captured
in a closure before it was shadowed, that closure would still reference the
original declaration:

```haxe
{
	var a = 1;
	function f() {
	    trace(a);
	}
	var a = 2;
	f(); // traces 1
}
```

---

Previous section: [Expressions](expression.md)

Next section: [Constants](expression-constants.md)