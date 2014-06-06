## 6.4.1 Introduction

Pattern matching is the process of branching depending on a value matching given, possibly deep patterns. In Haxe, all pattern matching is done within a [`switch` expression](expression-switch.md) where the individual `case` expressions represent the patterns. Here we will explore the syntax for different patterns using this data structure as running example:

```haxe
enum Tree<T> {
    Leaf(v:T);
    Node(l:Tree<T>, r:Tree<T>);
}
```

Some pattern matcher basics include:

* Patterns will always be matched from top to bottom.
* The topmost pattern that matches the input value has its expression executed.
* A `_` pattern matches anything, so `case _`: is equal to `default:`

---

Previous section: [Pattern Matching](lf-pattern-matching.md)

Next section: [Enum matching](lf-pattern-matching-enums.md)