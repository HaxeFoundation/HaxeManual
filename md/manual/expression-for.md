## 5.13 for

Haxe does not support traditional for-loops known from C. Its `for` keyword expects an opening parenthesis `(`, then a variable identifier followed by the keyword `in` and an arbitrary expression used as iterating collection. After the closing parenthesis `)` follows an arbitrary loop body expression.

```haxe
for (v in e1) e2;
```

The typer ensures that the type of `e1` can be iterated over, which is typically the case if it has an `iterator` method returning an `Iterator<T>`, or if it is an `Iterator<T>` itself.

Variable `v` is then available within loop body `e2` and holds the value of the individual elements of collection `e1`.

Haxe has a special range operator to iterate over intervals. It is a binary operator taking two `Int` operands: `min...max` returns an `IntIterator` instance that iterates from `min` (inclusive) to `max` (exclusive). Note that `max` may not be smaller than `min`.

```haxe
for (i in 0...10) trace(i); // 0 to 9
```

The type of a `for` expression is always `Void`, meaning it has no value and cannot be used as right-side expression.

The control flow of loops can be affected by [`break`](expression-break.md) and [`continue`](expression-continue.md) expressions.

---

Previous section: [new](expression-new.md)

Next section: [while](expression-while.md)