## 5.14 while

A normal while loop starts with the `while` keyword, followed by an opening parenthesis `(`, the condition expression and a closing paranthesis `)`. After that follows the loop body expression:

```haxe
while(condition) expression;
```

The condition expression has to be of type `Bool`.

Upon each iteration, the condition expression is evaluated. If it evaluates to `false`, the loop stops, otherwise it evaluates the loop body expression.

```haxe
class Main {
  static public function main() {
    var f = 0.0;
    while (f < 0.5) {
      trace(f);
      f = Math.random();
    }
  }
}
```

This kind of while-loop is not guaranteed to evaluate the loop body expression at all: If the condition does not hold from the start, it is never evaluated. This is different for [do-while loops](expression-do-while.md).

---

Previous section: [for](expression-for.md)

Next section: [do-while](expression-do-while.md)