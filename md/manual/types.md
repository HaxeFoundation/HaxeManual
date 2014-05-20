## 2 Types

The Haxe Compiler employs a rich typing system which helps detecting type-related errors in a program at compile-time. A type error is an invalid operation on a given type, such as dividing by a String, trying to access a field of an Integer or calling a function with not enough (or too many) arguments.

In some languages this additional safety comes at a price because programmers are forced to explicitly assign types to syntactic constructs:

```haxe
var myButton:MySpecialButton = new MySpecialButton(); // As3
MySpecialButton* myButton = new MySpecialButton(); // C++ 
```
The explicit type annotations are not required in Haxe, because the compiler can **infer** the type:

```haxe
var myButton = new MySpecialButton(); // Haxe
```
We will explore type inference in detail later in [Type Inference](type-system-type-inference.md). For now, it is sufficient to say that the variable `myButton` in the above code is known to be an **instance of class** `MySpecialButton`. 

The Haxe type system knows seven type groups:



 * **Class instance**: an object of a given class or interface
 * **Enum instance**: a value of a Haxe enumeration
 * **Structure**: an anonymous structure, i.e. a collection of named fields
 * **Function**: a compound type of several arguments and one return
 * **Dynamic**: a wildcard type which is compatible to any type
 * **Abstract**: a compile-time type which is represented by a different type at runtime
 * **Monomorph**: an unknown type, which may later become a different type



We will describe each of these type groups and how they relate to each other in the next chapters.

> ##### Define: Compound Type
>
> A compound type is a type which has sub-types. This includes any type with [type parameters](type-system-type-parameters.md) and the [function](types-function.md) type.

---

Previous section: [History](introduction-haxe-history.md)

Next section: [Basic Types](types-basic-types.md)