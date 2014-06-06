## 5.9 Function Call

Functions calls consist of an arbitrary subject expression followed by an opening parenthesis `(`, a comma `,` separated list of expressions as arguments and a closing parenthesis `)`.

```haxe
subject(); // call with no arguments
subject(e1); // call with one argument
subject(e1, e2); // call with two arguments
// call with multiple arguments
subject(e1, ..., eN);
```

---

Previous section: [Array Access](expression-array-access.md)

Next section: [var](expression-var.md)