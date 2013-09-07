The haxe compiler employs a sophisticated typing system which helps detecting type-related errors in a program at compile-time. A type error is an invalid operation on a given type, such as dividing by a String, trying to access a field of an Integer or calling a function with not enough (or too many) arguments.

In some languages, this additional safety comes at a price because programmers are forced to explicitly assign types to syntactic constructs:

```
var myButton:MySpecialButton = new MySpecialButton(); // As3
MySpecialButton* myButton = new MySpecialButton(); // C++ 
```
The explicit type annotations are not required in haxe, because the compiler can **infer** the type:

```
var myButton = new MySpecialButton(); // haxe
```
We will explore type inference in detail later in [[manual/Type_Inference]]. For now, it is sufficient to say that variable `myButton` in above code is known to be an **instance of class** `MySpecialButton`. A class instance is one of seven type groups:



 * an object of a given class or interface
 * a value of a haxe enumeration
 * an anonymous structure, i.e. a collection of named fields
 * a compound type of several arguments and one return
 * a wildcard type which is compatible to any type
 * an abstract value type
 * an unknown type, which may later become a different type