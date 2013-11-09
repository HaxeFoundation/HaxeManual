## 2 Types

The haxe compiler employs a sophisticated typing system which detects type-related errors at **compile-time** instead of **run-time**.  Thanks to the type system, a nasty, hard to detect run-time type error turns into a compiler error.  A type error is an invalid operation on a given type, such as dividing by a String, trying to access a field of an Integer or calling a function with not enough (or too many) arguments.

In some other languages, this additional type safety comes at a price, forcing programmers to explicitly assign types to syntactic constructs:

```haxe
var myButton:MySpecialButton = new MySpecialButton(); // As3
MySpecialButton* myButton = new MySpecialButton(); // C++ 
```
The explicit type annotations are not required in haxe, because the compiler can **infer** the type:

```haxe
var myButton = new MySpecialButton(); // haxe
```
We will explore type inference in detail later in [Type Inference](3.6-Type_Inference.md). For now, it is sufficient to say that the variable `myButton` in the code above is known to be an **class instance** of type `MySpecialButton`. A **class instance** is one of seven type groups:



 * Class instance: an object of a given class or interface
 * Enum instance: a value of a haxe enumeration
 * Structure: an anonymous structure, i.e. a collection of named fields
 * Function: a compound type of several arguments and one return
 * Dynamic: a wildcard type which is compatible to any type
 * Abstract: an abstract value type
 * Monomorph: an unknown type, which may later become a different type



> ##### Define: Compound Type
>
> A compound type is a type which has sub-types. This includes any type with [type parameters](3.2-Type_Parameters.md) and the [function](2.6-Function.md) type.

---

Previous section: [History](1.4-History.md)

Next section: [Basic Types](2.1-Basic_Types.md)