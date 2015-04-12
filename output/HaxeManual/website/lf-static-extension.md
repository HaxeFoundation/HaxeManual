## 6.3 Static Extension

> ##### Define: Static Extension
>
> A static extension allows pseudo-extending existing types without modifying their source. In Haxe this is achieved by declaring a static method with a first argument of the extending type and then bringing the defining class into context through `using`.

Static extensions can be a powerful tool which allows augmenting types without actually changing them. The following example demonstrates the usage:

```haxe
using Main.IntExtender;

class IntExtender {
  static public function triple(i:Int) {
    return i * 3;
  }
}

class Main {
  static public function main() {
    trace(12.triple());
  }
}
```

Clearly, `Int` does not natively provide a `triple` method, yet this program compiles and outputs `36` as expected. This is because the call to `12.triple()` is transformed into `IntExtender.triple(12)`. There are three requirements for this:

1. Both the literal `12` and the first argument of `triple` are of type `Int`.
2. The class `IntExtender` is brought into context through `using Main.IntExtender`.
3. `Int` does not have a `triple` field by itself (if it had, that field would take priority over the static extension).

Static extensions are usually considered syntactic sugar and indeed they are, but it is worth noting that they can have a dramatic effect on code readability: Instead of nested calls in the form of `f1(f2(f3(f4(x))))`, chained calls in the form of `x.f4().f3().f2().f1()` can be used.

Following the rules previously described in [Resolution Order](type-system-resolution-order.md), multiple `using` expressions are checked from bottom to top, with the types within each module as well as the fields within each type being checked from top to bottom. Using a module (as opposed to a specific type of a module, see [Modules and Paths](type-system-modules-and-paths.md)) as static extension brings all its types into context.

---

Previous section: [Externs](lf-externs.md)

Next section: [In the Haxe Standard Library](lf-static-extension-in-std.md)