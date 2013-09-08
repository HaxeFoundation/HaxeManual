Haxe 3 comes with improved options for pattern matching. Here we will explore the syntax for different patterns using this data structure as running example:

```
enum Tree<T> {
    Leaf(v:T);
    Node(l:Tree<T>, r:Tree<T>);
}
```

Some pattern matcher basics include:



* Patterns will always be matched from top to bottom.
* The topmost pattern that matches the input value has its expression executed.
* A `_` pattern matches anything, so `case _`: is equal to `default:`