## 5.9 var

The `var` keyword allows declaring multiple variables, separated by comma `,`. Each variable has a valid [identifier](dictionary.md#identifier) and optionally a value assignment following the assignment operator `=`. Variables can also have an explicit type-hint.

```haxe
var a; // declare local a
var b:Int; // declare variable b of type Int
var c = 1; // declare variable c, initialized to value 1
var d,e = 2; // declare variable d and variable e initialized to value 2
```

The scoping behavior of local variables is described in [Blocks](expression-block.md).

---

Previous section: [Function Call](expression-function-call.md)

Next section: [Local functions](expression-function.md)