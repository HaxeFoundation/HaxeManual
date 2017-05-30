## 13.3 Tracing types

`$type` is a **compile-time** mechanism being called like a function, with a single argument. The compiler evaluates the argument expression and then outputs the type of that expression.

This is useful to evaluate if an expression has a certain type, mostly when dealing with [Type inference](type-system-type-inference.md), which leaves the definition of the type up to the compiler.

```haxe
var myValue = "foo";
$type(myValue); // String
```

---

Previous section: [Position Information Parameter](debugging-posinfos.md)

Next section: [Debugging in JavaScript](debugging-javascript.md)