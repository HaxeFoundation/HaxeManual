## 5.16 if

Conditional expressions come in the form of a leading `if` keyword, a condition expression enclosed in parentheses `()` and a expression to be evaluated in case the condition holds:

```haxe
if (condition) expression;
```

The condition expression has to be of type `Bool`.

Optionally, `expression` may be followed by the `else` keyword as well as another expression to be evaluated if the condition does not hold:

```haxe
if (condition) expression1 else expression2;
```

Here, `expression2` may consist of another `if` expression:

```haxe
if (condition1) expression1
else if(condition2) expression2
else expression3
```

If the value of an `if` expression is required, e.g. for `var x = if(condition) expression1 else expression2`, the typer ensures that the types of `expression1` and `expression2` [unify](type-system-unification.md). If no `else` expression is given, the type is inferred to be `Void`.

---

Previous section: [do-while](expression-do-while.md)

Next section: [switch](expression-switch.md)