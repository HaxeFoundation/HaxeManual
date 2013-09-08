> Define: nullable

>
> A type in haxe is considered **nullable** if `null` is a valid value for it.

It is common for programming languages to have a single, clean definition for nullability, but haxe has to find a compromise in this regard. The reason for this is obvious when looking at the nature of haxe's target languages: While some of them allow and, in fact, default to `null` for anything, others do not even allow `null` for certain types. This necessitates the distinction of two types of target languages:

> Define: Static target

>
> Static targets employ their own type system where `null` is not a valid value for basic types. This is true for the Flash 9+, C++, Java and C# targets.
> Define: Dynamic target

>
> Dynamic targets are more lenient with their types and allow *null* values for basic types. They const is JavaScript, PHP, neko and Flash 6-8.

There is nothing to worry about when working with `null` on dynamic targets, but static ones may require some thought. For starters, basic types are initialized to these values:



* **`Int`:** `0`
* **`Float`:** `NaN` on Flash 9, `0.0` on other static targets
* **`Bool`:** `false`


As a consequence, the haxe compiler does not allow assigning `null` to a basic type on static targets. In order to achieve this, the basic type has to be wrapped as `Null<T>`:

```
var a:Int = null; // error on static platforms
var b:Null<Int> = null; // allowed
```
Similarly, basic types cannot be compared to `null` unless wrapped:

```
var a : Int = 0;
if( a == null ) { ... } // error on static platforms
var b : Null<Int> = 0;
if( b != null ) { ... } // allowed
```
This restriction extends to all situations where [manual/Unification] is performed.

If a `null`-value is "hidden" in `Null<T>` or `Dynamic` and assigned to a basic type, the default value is used:

```
var n : Null<Int> = null;
var a : Int = n;
trace(a); // 0 on static platforms
```