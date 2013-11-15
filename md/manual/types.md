## 2 Types

The Haxe compiler employs a sophisticated typing system which helps detecting type-related errors in a program at compile-time. A type error is an invalid operation on a given type, such as dividing by a String, trying to access a field of an Integer or calling a function with not enough (or too many) arguments.

In some languages this additional safety comes at a price because programmers are forced to explicitly assign types to syntactic constructs:

```haxe
var myButton:MySpecialButton = new MySpecialButton(); // As3
MySpecialButton* myButton = new MySpecialButton(); // C++ 
```
The explicit type annotations are not required in Haxe, because the compiler can **infer** the type:

```haxe
var myButton = new MySpecialButton(); // haxe
```
We will explore type inference in detail later in [Type Inference](type_inference.md). For now, it is sufficient to say that the variable `myButton` in the above code is known to be an **instance of class** `MySpecialButton`. A class instance is one of seven type groups:



 * Class instance: an object of a given class or interface
 * Enum instance: a value of a Haxe enumeration
 * Structure: an anonymous structure, i.e. a collection of named fields
 * Function: a compound type of several arguments and one return
 * Dynamic: a wildcard type which is compatible to any type
 * Abstract: an abstract value type
 * Monomorph: an unknown type, which may later become a different type



> ##### Define: Compound Type
>
> A compound type is a type which has sub-types. This includes any type with [type parameters](type_parameters.md) and the [function](function.md) type.

---

Previous section: [History](haxe_history.md)

Next section: [Basic Types](basic_types.md)