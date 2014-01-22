## 2.7 Dynamic

While Haxe has a static type system, this type system can effectively be turned off by using the `Dynamic` type. A **dynamic value** can be assigned to anything, and anything can be assigned to it. This has several drawbacks:



* The compiler can no longer type-check assignments, function calls and other constructs where specific types are expected.
* Certain optimizations, in particular when compiling to static targets, can no longer be employed.
* Some common errors, e.g. a typo in a field access, can not be caught at compile-time and likely cause an error at runtime.
* [Dead Code Elimination](cr-dce.md) cannot detect used fields if they are used through `Dynamic`.


It is very easy to come up with examples where the usage of `Dynamic` can cause problems at runtime. Consider compiling the following two lines to a static target:

```haxe
var d:Dynamic = 1;
d.foo;
```
Trying to run a compiled program in the Flash Player yields an error `Property foo not found on Number and there is no default value`. Without `Dynamic`, this would have been detected at compile-time.

> ##### Trivia: Dynamic Inference before Haxe 3
>
> The Haxe 3 compiler never infers a type to `Dynamic`, so users must be explicit about it. Previous Haxe versions used to infer arrays of mixed types, e.g. `[1, true, "foo"]`, as `Array<Dynamic>`. We found that this behavior introduced too many type problems and thus removed it for Haxe 3.

Use of `Dynamic` should be minimized as there are better options in many situations, but sometimes it is just practical to use it. Parts of the Haxe [Reflection](std-reflection.md) API use it, and it is sometimes the best option when dealing with custom data structures that are not known at compile-time.

Dynamic behaves in a special way when being [unified](type-system-unification.md) with a [monomorph](types-monomorph.md), which is described in [Monomorphs](type-system-monomorphs.md).

> ##### Trivia: Dynamic in the Standard Library
>
> Dynamic was quite frequent in the Haxe Standard Library before Haxe 3. With the continuous improvements of the Haxe type system, the occurences of Dynamic were reduced over the releases leading to Haxe 3.

---

Previous section: [Default values](types-function-default-values.md)

Next section: [Dynamic with Type Parameter](types-dynamic-with-type-parameter.md)