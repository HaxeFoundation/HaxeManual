## 5.12 for

Haxe does not support traditional for-loops known from C. Its `for` keyword expects an opening parenthesis `(`, then a variable identifier followed by the keyword `in` and an arbitrary expression used as iterating collection. After the closing parenthesis `)` follows an arbitrary loop body expression.

```haxe
for (v in e1) e2;
```

The typer ensures that the type of `e1` can be iterated over, which is typically the case if it has an `iterator` method returning an `Iterator<T>`, or if it is an `Iterator<T>` itself.

Variable `v` is then available within loop body `e2` and holds the value of the individual elements of collection `e1`.

The type of a `for` expression is always `Void`, meaning it has no value and cannot be used as right-side expression.

---

Previous section: [Function Call](expression-function-call.md)

Next section: [if](expression-if.md)