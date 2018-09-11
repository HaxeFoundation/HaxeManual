## 5.10 var

The `var` keyword allows declaring multiple variables, separated by comma `,`. Each variable has a valid [identifier](dictionary.md#define-identifier) and optionally a value assignment following the assignment operator `=`. Variables can also have an explicit type-hint.

```haxe
var a; // declare local a
var b:Int; // declare variable b of type Int
// declare variable c, initialized to value 1
var c = 1;
// declare an uninitialized variable d
// and variable e initialized to value 2
var d,e = 2;
```

The scoping behavior of local variables is described in [Blocks](expression-block.md).

---

Previous section: [Function Call](expression-function-call.md)

Next section: [Local Functions](expression-function.md)