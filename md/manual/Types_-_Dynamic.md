While haxe has a static type system, this type system can effectively be turned off by using the `Dynamic` type. A **dynamic value** can be assigned to anything, and anything can be assigned to it. This has several drawbacks:



* The compiler can no longer type-check assignments, function calls and other constructs where specific types are expected.
* Certain optimizations, in particular when compiling to static targets, can no longer be employed.
* Some common errors, e.g. a typo in a field access, can not be caught at compile-time and likely cause an error at runtime.
* [manual/Dead_Code_Elimination] cannot detect used fields if they are used through `Dynamic`.


It is very easy to come up with examples where the usage of `Dynamic` can cause problems at runtime. Consider compiling the following two lines to a static target:

```
var d:Dynamic = 1;
d.foo;
```
Trying to run a compiled program in the Flash Player yields an error `Property foo not found on Number and there is no default value`. Without `Dynamic`, this would have been detected at compile-time.



Use of `Dynamic` should be minimized as there are better options in many situations, but sometimes it is just practical to use it. Parts of the haxe [manual/Reflection] API use it, and it is sometimes the best option when dealing with custom data structures that are not known at compile-time.

Dynamic behaves in a special way when being unified ([manual/Unification]) with a [manual/Monomorph], which is described in [manual/Monomorphs].