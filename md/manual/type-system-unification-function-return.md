## 3.5.4 Function Return

Unification of function return types may involve the [`Void`-type](types-void.md) and require a clear definition of what unifies with `Void`. With `Void` describing the absence of a type, it is not assignable to any other type, not even `Dynamic`. This means that if a function is explicitly declared as returning `Dynamic`, it must not return `Void`.

The opposite applies as well: If a function declares a return type of `Void`, it cannot return `Dynamic` or any other type. However, this direction of unification is allowed when assigning function types:

```haxe
var func:Void->Void = function() return "foo";
```
The right-hand function clearly is of type `Void->String`, yet we can assign it to variable `func` of type `Void->Void`. This is because the compiler can safely assume that the return type is irrelevant, given that it could not be assigned to any non-`Void` type.

---

Previous section: [Monomorphs](type-system-monomorphs.md)

Next section: [Common Base Type](type-system-unification-common-base-type.md)