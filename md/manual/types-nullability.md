## 2.2 Nullability

> ##### Define: nullable
>
> A type in Haxe is considered **nullable** if `null` is a valid value for it.


It is common for programming languages to have a single, clean definition for nullability. However, Haxe has to find a compromise in this regard. The reason for this is obvious when looking at the nature of Haxe's target languages: While some of them allow and, in fact, default to `null` for anything, others do not even allow `null` for certain types. This necessitates the distinction of two types of target languages:

> ##### Define: Static target
>
> Static targets employ their own type system where `null` is not a valid value for basic types. This is true for the Flash, C++, Java and C# targets.

> ##### Define: Dynamic target
>
> Dynamic targets are more lenient with their types and allow `null` values for basic types. They consist of JavaScript, PHP, Neko and Flash 6-8.


There is nothing to worry about when working with `null` on dynamic targets, but static ones may require some thought. For starters, basic types are initialized to these values:



* `Int`: `0`
* `Float`: `NaN` on Flash, `0.0` on other static targets
* `Bool`: `false`


As a consequence, the Haxe Compiler does not allow the assignment of `null` to a basic type on static targets. In order to achieve this, the basic type has to be wrapped as `Null<T>`:


```haxe
var a:Int = null; // error on static platforms
var b:Null<Int> = null; // allowed
```
Similarly, basic types cannot be compared to `null` unless wrapped:

```haxe
var a : Int = 0;
if( a == null ) { ... } // error on static platforms
var b : Null<Int> = 0;
if( b != null ) { ... } // allowed
```
This restriction extends to all situations where [unification](type-system-unification.md) is performed.

If a `null`-value is "hidden" in `Null<T>` or `Dynamic` and assigned to a basic type, the default value is used:

```haxe
var n : Null<Int> = null;
var a : Int = n;
trace(a); // 0 on static platforms
```

---

Previous section: [Void](types-void.md)

Next section: [Optional Arguments and Nullability:](types-nullability-optional-arguments.md)

Contribute: [fileAndLines](https://github.com/HaxeFoundation/HaxeManual/blob/master/02-types.tex#L158-158)