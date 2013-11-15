## 2.4 Enum Instance

Haxe provides powerful enumeration (short: enum) types, which are actually an **algebraic data type** (ADT). While they cannot have any expressions, they are very useful for describing the structure of code logic:

```haxe
enum Color {
	Red;
	Green;
	Blue;
	Rgb(r:Int, g:Int, b:Int);
}
```
Semantically, this enum describes a color which is either red, green, blue or a specified RGB value. The syntactic structure is as follows:


* The keyword `enum` denotes that we are declaring an enum.
* `Color` is the name of the enum and could be anything conforming to the rules for type identifiers.
* Enclosed in curly braces `{}` are the **enum constructors**,
* which are `Red`, `Green` and `Blue` taking no arguments,
* as well as `Rgb` taking three `Int` arguments named `r`, `g` and `b`.


The haxe type system provides a type which unifies with all enum types:

> ##### Define: Enum
>
> This type is compatible with all enum types. At compile-time, `Enum<T>` can be considered to be the common base type of all enum types. However, this relation is not reflected in generated code.

---

Previous section: [Interfaces](types-interfaces.md)

Next section: [Enum Constructor](types-enum-constructor.md)