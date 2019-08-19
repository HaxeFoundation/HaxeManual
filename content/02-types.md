<!--label:types-->
## Types

The Haxe Compiler employs a rich type system which helps to detect type-related errors in a program at compile-time. A type error is an invalid operation on a given type such as dividing by a String, trying to access a field of an Integer or calling a function with not enough (or too many) arguments.

In some languages this additional safety comes at a price because programmers are forced to explicitly assign types to syntactic constructs:

```as3
var myButton:MySpecialButton = new MySpecialButton(); // As3
```
```cpp
MySpecialButton* myButton = new MySpecialButton(); // C++ 
```
The explicit type annotations are not required in Haxe, because the compiler can **infer** the type:

```haxe
var myButton = new MySpecialButton(); // Haxe
```
We will explore type inference in detail later in [Type Inference](type-system-type-inference). For now, it is sufficient to say that the variable `myButton` in the above code is known to be an **instance of class** `MySpecialButton`. 

The Haxe type system knows seven type groups:

 * **Class instance**: an object of a given class or interface 
* **Enum instance**: a value of a Haxe enumeration 
* **Structure**: an anonymous structure, i.e. a collection of named fields 
* **Function**: a compound type of several arguments and one return 
* **Dynamic**: a wildcard type which is compatible with any other type 
* **Abstract**: a compile-time type which is represented by a different type at runtime 
* **Monomorph**: an unknown type which may later become a different type

We will describe each of these type groups and how they relate to each other in the following chapters.

> ##### Define: Compound Type
>
> A compound type is a type which has sub-types. This includes any type with [type parameters](type-system-type-parameters) and the [function](types-function) type.

<!--label:types-basic-types-->
### Basic Types

**Basic types** are `Bool`, `Float` and `Int`. They can easily be identified in the syntax by values such as

* `true` and `false` for `Bool`,
* `1`, `0`, `-1` and `0xFF0000` for `Int` and
* `1.0`, `0.0`, `-1.0`, `1e10` for `Float`.

Basic types are not [classes](types-class-instance) in Haxe. Instead, they are implemented as [abstract types](types-abstract) and are tied to the compiler's internal operator-handling as described in the following sections.

<!--label:types-numeric-types-->
#### Numeric types

> ##### Define: Float
>
> Represents a double-precision IEEE 64-bit floating point number.

> ##### Define: Int
>
> Represents an integral number.

While every `Int` can be used where a `Float` is expected (that is, `Int` **is assignable to** or **unifies with** `Float`), the reverse is not true: Assigning a `Float` to an `Int` might cause loss of precision and is therefore not allowed implicitly.



<!--label:types-overflow-->
#### Overflow

For performance reasons, the Haxe Compiler does not enforce any overflow behavior. The burden of checking for overflows falls to the target platform. Here are some platform-specific notes on overflow behavior:

 * C++, Java, C#, Neko, Flash: 32-bit signed integers with usual overflow practices  
* PHP, JS, Flash 8: No native **Int** type, loss of precision will occur if a number reaches the float limit (2<sup>52</sup>)

Alternatively, the **haxe.Int32** and **haxe.Int64** classes can be used to ensure correct overflow behavior at the cost of additional computations on certain platforms.



<!--label:types-bool-->
#### Bool

> ##### Define: Bool
>
> Represents a value which can be either **true** or **false**.

Values of type `Bool` are a common occurrence in **conditions** such as [`if`](expression-if) and [`while`](expression-while).



<!--label:types-void-->
#### Void

> ##### Define: Void
>
> Denotes the absence of a type. It is used to express that something (usually a function) has no value.

`Void` is a special case in the type system because it is not actually a type. It is used to express the absence of a type, which applies mostly to function arguments and return types.
We have already "seen" `Void` in the initial "Hello World" example:

[code asset](assets/HelloWorld.hx)

The function type will be explored in detail in the section [Function Type](types-function) but a quick preview helps here: The type of the function `main` in the example above is `Void->Void`, which reads as "it has no arguments and returns nothing".
Haxe does not allow fields and variables of type `Void` and will complain if an attempt at declaring such is made:

```haxe
// Arguments and variables of type Void are not allowed
var x:Void;
```





<!--label:types-nullability-->
### Nullability

> ##### Define: nullable
>
> A type in Haxe is considered **nullable** if `null` is a valid value for it.

It is common for programming languages to have a single, clean definition for nullability. However, Haxe has to find a compromise in this regard due to the nature of Haxe's target languages: While some of them allow and; in fact, default to `null` for anything, others do not even allow `null` for certain types. This necessitates the distinction between two types of target languages:

> ##### Define: Static target
>
> Static targets employ their own type system where `null` is not a valid value for basic types. This is true for the Flash, C++, Java and C# targets.

> ##### Define: Dynamic target
>
> Dynamic targets are more lenient with their types and allow `null` values for basic types. This applies to the JavaScript, PHP, Neko and Flash 6-8 targets.

There is nothing to worry about when working with `null` on dynamic targets; however, static ones may require some thought. For starters, basic types are initialized to their default values.

> ##### Define: Default values
>
> 
> Basic types have the following default values on static targets:
> 
> * `Int`: `0`
> * `Float`: `NaN` on Flash, `0.0` on other static targets
> * `Bool`: `false`
> 
> 

As a consequence, the Haxe Compiler does not allow the assignment of `null` to a basic type on static targets. In order to achieve this, the basic type has to be wrapped as `Null<T>`:

```haxe
// error on static platforms
var a:Int = null;
var b:Null<Int> = null; // allowed
```

Similarly, basic types cannot be compared to `null` unless wrapped:

```haxe
var a : Int = 0;
// error on static platforms
if( a == null ) { ... }
var b : Null<Int> = 0;
if( b != null ) { ... } // allowed
```

This restriction extends to all situations where [unification](type-system-unification) is performed.

> ##### Define: `Null<T>`
>
> On static targets the types `Null<Int>`, `Null<Float>` and `Null<Bool>` can be used to allow `null` as a value. On dynamic targets this has no effect. `Null<T>` can also be used with other types in order to document that `null` is an allowed value.

If a `null`-value is "hidden" in `Null<T>` or `Dynamic` and assigned to a basic type, the default value is used:

```haxe
var n : Null<Int> = null;
var a : Int = n;
trace(a); // 0 on static platforms
```

<!--label:types-nullability-optional-arguments-->
#### Optional Arguments and Nullability

Optional arguments also have to be accounted for when considering nullability.

In particular, there must be a distinction between **native** optional arguments which are not nullable and Haxe-specific optional arguments which might be. The distinction is made by using the question-mark optional argument:

```haxe
// x is a native Int (not nullable)
function foo(x : Int = 0) {}
// y is Null<Int> (nullable)
function bar( ?y : Int) {}
// z is also Null<Int>
function opt( ?z : Int = -1) {}
```

> ##### Trivia: Argument vs. Parameter
>
> In some other programming languages, **argument** and **parameter** are used interchangeably.  In Haxe, **argument** is used when referring to methods and **parameter** refers to [Type Parameters](type-system-type-parameters).





<!--label:types-class-instance-->
### Class Instance

Similar to many object-oriented languages, classes are the primary data structure for the majority of programs in Haxe. Each Haxe class has an explicit name, an implied path and zero or more class fields. Here we will focus on the general structure of classes and their relations while leaving the details of class fields for [Class Fields](class-field).

The following code example serves as the basis for the remainder of this section:

[code asset](assets/Point.hx)

Semantically, this class represents a point in discrete 2-dimensional space - but this is not important here. Let us instead describe the structure:

* The keyword `class` denotes that we are declaring a class.
* `Point` is the name of the class and could be anything conforming to the [rules for type identifiers](define-identifier).
* Enclosed in curly braces `{}` are the class fields,
* Which consist of two **variable** fields `x` and `y` of type `Int`,
* followed by a special **function** field named `new`, which is the **constructor** of the class,
* as well as a normal function `toString`.

There is a special type in Haxe which is compatible with all classes:

> ##### Define: `Class<T>`
>
> This type is compatible with all class types which means that all classes (not their instances) can be assigned to it. At compile-time, `Class<T>` is the common base type of all class types. However, this relation is not reflected in generated code.
> 
> This type is useful when an API requires a value to be **a** class, but not a specific one. This applies to several methods of the [Haxe reflection API](std-reflection).

<!--label:types-class-constructor-->
#### Class constructor

Instances of classes are created by calling the class constructor - a process commonly referred to as **instantiation**. Another name for class instances is **object**. Nevertheless, we prefer the term class instance to emphasize the analogy between classes/class instances and [enums/enum instances](types-enum-instance). 

```haxe
var p = new Point(-1, 65);
```
This will yield an instance of class `Point`, which is assigned to a variable named `p`. The constructor of `Point` receives the two arguments `-1` and `65` and assigns them to the instance variables `x` and `y` respectively (compare its definition in [Class Instance](types-class-instance)). We will revisit the exact meaning of the `new` expression later in the section [new](expression-new). For now, we just think of it as calling the class constructor and returning the appropriate object.



<!--label:types-class-inheritance-->
#### Inheritance

Classes may inherit from other classes, which in Haxe is denoted by the `extends` keyword:

[code asset](assets/Point3.hx)

This relation is often described as "is-a": Any instance of class `Point3` is also an instance of `Point`. `Point` is then known as the **parent class** of `Point3`, which is a **child class** of `Point`. A class may have many child classes, but only one parent class. The term "a parent class of class X" usually refers to its direct parent class, the parent class of its parent class and so on.

The code above is very similar to the original `Point` class, with two new constructs being shown:

 * `extends Point` denotes that this class inherits from class `Point` 
* `super(x, y)` is the call to the constructor of the parent class, in this case, `Point.new`

It is not necessary for child classes to define their own constructors, but if they do, a call to `super()` is mandatory. Unlike some other object-oriented languages, this call can appear anywhere in the constructor code and does not have to be the first expression.

A class may override [methods](class-field-method) of its parent class, which requires the explicit `override` keyword. The effects and restrictions of this are detailed in [Overriding Methods](class-field-overriding).

##### since Haxe 4.0.0

Classes can be declared with the keyword `final` to prevent them from being extended.

> ##### Trivia: `:final` metadata
>
> Prior to Haxe 4, marking classes as final was possible using the `:final` metadata.



<!--label:types-interfaces-->
#### Interfaces

An interface can be understood as the signature of a class because it describes the public fields of a class. Interfaces do not provide implementations but pure structural information:

```haxe
interface Printable {
	public function toString():String;
}
```
The syntax is similar to classes, with the following exceptions:

* `interface` keyword is used instead of `class` keyword
* functions do not have any [expressions](expression)
* every field must have an explicit type

Interfaces, unlike [structural subtyping](type-system-structural-subtyping), describe a **static relation** between classes. A given class is only considered to be compatible to an interface if it explicitly states so:

```haxe
class Point implements Printable { }
```
Here, the `implements` keyword denotes that `Point` has a "is-a" relationship to `Printable`, i.e. each instance of `Point` is also an instance of `Printable`. While a class may only have one parent class, it may implement multiple interfaces through multiple `implements` keywords:

```haxe
class Point implements Printable
  implements Serializable
```

The compiler checks if the `implements` assumption holds. That is, it makes sure the class actually does implement all the fields required by the interface. A field is considered implemented if the class or any of its parent classes provide an implementation.

Interface fields are not limited to methods. They can be variables and properties as well:

[code asset](assets/InterfaceWithVariables.hx)

Interfaces can extend multiple other interfaces using the `extends` keyword:
```haxe
interface Debuggable extends Printable extends Serializable
```

##### since Haxe 4.0.0

Analogously to classes, interfaces can also be marked with the keyword `final`, preventing them from being extended.

> ##### Trivia: Implements Syntax
>
> Haxe versions prior to 3.0 required multiple `implements` keywords to be separated by a comma. We decided to adhere to the de-facto standard of Java and got rid of the comma. This was one of the breaking changes between Haxe 2 and 3.





<!--label:types-enum-instance-->
### Enum Instance

Haxe provides powerful enumeration (short: enum) types, which are actually an **algebraic data type** (ADT). While they cannot have any [expressions](expression), they are very useful for describing data structures:

[code asset](assets/Color.hx)

Semantically, this enum describes a color which is either red, green, blue or a specified RGB value. The syntactic structure is as follows:

* The keyword `enum` denotes that we are declaring an enum.
* `Color` is the name of the enum and could be anything conforming to the rules for [type identifiers](define-identifier).
* Enclosed in curly braces `{}` are the **enum constructors**,
* which are `Red`, `Green` and `Blue` taking no arguments,
* as well as `Rgb` taking three `Int` arguments named `r`, `g` and `b`.

The Haxe type system provides a type which unifies with all enum types:

> ##### Define: `Enum<T>`
>
> This type is compatible with all enum types. At compile-time, `Enum<T>` can be seen as the common base type of all enum types. However, this relation is not reflected in generated code.

<!--label:types-enum-constructor-->
#### Enum Constructor

Similar to classes and their constructors, enums provide a way of instantiating them by using one of their constructors. However, unlike classes, enums provide multiple constructors which can easily be used through their name:

```haxe
var a = Red;
var b = Green;
var c = Rgb(255, 255, 0);
```
In this code the type of variables `a`, `b` and `c` is `Color`. Variable `c` is initialized using the `Rgb` constructor with arguments.

All enum instances can be assigned to a special type named `EnumValue`.

> ##### Define: EnumValue
>
> EnumValue is a special type which unifies with all enum instances. It is used by the Haxe Standard Library to provide certain operations for all enum instances and can be employed in user-code accordingly in cases where an API requires **an** enum instance, but not a specific one.

It is important to distinguish enum types and enum constructors, as this example demonstrates:

[code asset](assets/EnumUnification.hx)

If the commented line is uncommented, the program does not compile because `Red` (an enum constructor) cannot be assigned to a variable of type `Enum<Color>` (an enum type). The relation is analogous to a class and its instance.

> ##### Trivia: Concrete type parameter for `Enum<T>`
>
> One of the reviewers of this manual was confused about the difference between `Color` and `Enum<Color>` in the example above. Indeed, using a concrete type parameter there is pointless and only serves the purpose of demonstration. Usually, we would omit the type there and let [type inference](type-system-type-inference) deal with it.
> 
> However, the inferred type would be different from `Enum<Color>`. The compiler infers a pseudo-type which has the enum constructors as "fields". As of Haxe 3.2.0, it is not possible to express this type in syntax but also, it is never necessary to do so.



<!--label:types-enum-using-->
#### Using enums

Enums are a good choice if only a finite set of values should be allowed. The individual [constructors](types-enum-constructor) then represent the allowed variants and enable the compiler to check if all possible values are respected. This can be seen here:

[code asset](assets/Color2.hx)

After retrieving the value of `color` by assigning the return value of `getColor()` to it, a [`switch` expression](expression-switch) is used to branch depending on the value. The first three cases `Red`, `Green` and `Blue` are trivial and correspond to the constructors of `Color` that have no arguments. The final case `Rgb(r, g, b)` shows how the argument values of a constructor can be extracted: they are available as local variables within the case body expression, just as if a [`var` expression](expression-var) had been used.

Advanced information on using the `switch` expression will be explored later in the section on [pattern matching](lf-pattern-matching).





<!--label:types-anonymous-structure-->
### Anonymous Structure

Anonymous structures can be used to group data without explicitly creating a type. The following example creates a structure with two fields `x` and `name`, and initializes their values to `12` and `"foo"` respectively:

[code asset](assets/Structure.hx)

The general syntactic rules follow:

1. A structure is enclosed in curly braces `{}` and
2. Has a **comma-separated** list of key-value-pairs.
3. A **colon** separates the key, which must be a valid [identifier](define-identifier), from the value.
4. The value can be any Haxe expression.

Rule 4 implies that structures can be nested and complex, e.g.:

```haxe
var user = {
  name : "Nicolas",
	age : 32,
	pos : [
	  { x : 0, y : 0 },
		{ x : 1, y : -1 }
  ],
};
```
Fields of structures, like classes, are accessed using a **dot** (`.`) like so:

```haxe
// get value of name, which is "Nicolas"
user.name;
// set value of age to 33
user.age = 33;
```
It is worth noting that using anonymous structures does not subvert the typing system. The compiler ensures that only available fields are accessed, which means the following program does not compile:

```haxe
class Test {
  static public function main() {
    var point = { x: 0.0, y: 12.0 };
    // { y : Float, x : Float } has no field z
    point.z;
  }
}
```
The error message indicates that the compiler knows the type of `point`: It is a structure with fields `x` and `y` of type `Float`. Since it has no field `z`, the access fails.
The type of `point` is known through [type inference](type-system-type-inference), which thankfully saves us from using explicit types for local variables. However, if `point` was a field, explicit typing would be necessary:

```haxe
class Path {
    var start : { x : Int, y : Int };
    var target : { x : Int, y : Int };
    var current : { x : Int, y : Int };
}
```
To avoid this kind of redundant type declaration, especially for more complex structures, it is advised to use a [typedef](type-system-typedef):

```haxe
typedef Point = { x : Int, y : Int }

class Path {
    var start : Point;
    var target : Point;
    var current : Point;
}
```

You may also use [Extensions](types-structure-extensions) to "inherit" fields from other structures.

```haxe
typedef Point3 = { > Point, z : Int }
```

<!--label:types-structure-json-->
#### JSON for Structure Values

It is also possible to use **JavaScript Object Notation** for structures by using **string literals** for the keys:

```haxe
var point = { "x" : 1, "y" : -5 };
```
While any string literal is allowed, the field is only considered part of the type if it is a valid [Haxe identifier](define-identifier). Otherwise, Haxe syntax does not allow expressing access to such a field and [reflection](std-reflection) has to be employed through the use of `Reflect.field` and `Reflect.setField`.



<!--label:types-structure-class-notation-->
#### Class Notation for Structure Types

When defining a structure type, Haxe allows using the same syntax as described in [Class Fields](class-field). The following [typedef](type-system-typedef) declares a `Point` type with variable fields `x` and `y` of type `Int`:

```haxe
typedef Point = {
    var x : Int;
    var y : Int;
}
```

##### since Haxe 4.0.0

The fields of a structure may also be declared with `final`, which only allows them to be assigned once. Such a structure will only [unify](type-system-unification) with other types if the corresponding fields are also `final`.



<!--label:types-structure-optional-fields-->
#### Optional Fields

Fields of a structure type can be made optional. In the standard notation, this is achieved by prefixing the field name with a `?`:

```haxe
typedef User = {
  age : Int,
  name : String,
  ?phoneNumber : String
}
```

In class notation, the `@:optional` metadata can be used instead:

```haxe
typedef User = {
  var age : Int;
  var name : String;
  @:optional var phoneNumber : String;
}
```

##### since Haxe 4.0.0

In Haxe 4 it is also possible to declare a structure field as optional in the **class notation** by prefixing its name with `?`:

```haxe
typedef User = {
  var age : Int;
  var name : String;
  var ?phoneNumber : String;
}
```



<!--label:types-structure-performance-->
#### Impact on Performance

Using structures and, by extension, [structural subtyping](type-system-structural-subtyping) has no impact on performance when compiling to [dynamic targets](define-dynamic-target). However, on [static targets](define-static-target) a dynamic lookup has to be performed which is typically slower than a static field access.



<!--label:types-structure-extensions-->
#### Extensions

Extensions are used to express that a structure has all the fields of a given type as well as some additional fields of its own:

[code asset](assets/Extension.hx)

The greater-than operator `>` denotes that an extension of `Iterable<T>` is being created, with the additional class fields following. In this case, a read-only [property](class-field-property) `length` of type `Int` is required.

In order to be compatible with `IterableWithLength<T>`, a type then must be compatible with `Iterable<T>` and also provide a read-only `length` property of type `Int`. The example assigns an `Array`, which happens to fulfill these requirements.

##### since Haxe 3.1.0

It is also possible to extend multiple structures:

[code asset](assets/Extension2.hx)

##### since Haxe 4.0.0

Haxe 4 introduces an alternative notation for extension, separating each extended structure with a `&` symbol.

[code asset](assets/Extension3.hx)





<!--label:types-function-->
### Function Type

The function type, along with the [monomorph](types-monomorph), is a type which is usually well-hidden from Haxe users, yet present everywhere. We can make it surface by using `$type`, a special Haxe identifier which outputs the type its expression has during compilation:

[code asset](assets/FunctionType.hx)

There is a strong resemblance between the declaration of function `test` and the output of the first `$type` expression, with one subtle difference: the **function return type** appears at the end after a `->` symbol.

In either notation it is obvious that the function `test` accepts one argument of type `Int` and one argument of type `String` and returns a value of type `Bool`. If a call to this function, such as `test(1, "foo")`, is made within the second `$type` expression, the Haxe typer checks if `1` can be assigned to `Int` and if `"foo"` can be assigned to `String`. The type of the call is then equal to the type of the value `test` returns, which is `Bool`.

Note that argument names are optional in the function type. If a function type has other function types as argument or return type, parentheses can be used to group them correctly. For example, `(Int, ((Int) -> Void)) -> Void` represents a function which has one argument of type `Int` and one argument of function type `Int -> Void` and a return type `Void`.

[code asset](assets/FunctionType2.hx)

As shown in the above example, the type of a function which takes no arguments uses `()` to represent the argument list.

##### Old function type notation

Before Haxe 4, the function type notation was more similar to other functional programming languages, using `->` in place of all the commas separating the argument types. The `test` function above would be typed as `Int -> String -> Bool` in this notation. `test2` would be typed as `Void -> Bool`.

The older notation is still supported, although newer code should use the new notation described above since it more clearly differentiates argument types from the return type.

> ##### Trivia: New function type notation
>
> The new function type notation was based on the syntax of [arrow functions](expression-arrow-function), which were also introduced in Haxe 4.

<!--label:types-function-optional-arguments-->
#### Optional Arguments

Optional arguments are declared by prefixing an argument identifier with a question mark `?`:

[code asset](assets/OptionalArguments.hx)

Function `test` has two optional arguments: `i` of type `Int` and `s` of `String`. This is directly reflected in the function type output by line 4. 
This example program calls `test` four times and prints its return value.

1. The first call is made without any arguments.
2. The second call is made with a singular argument `1`.
3. The third call is made with two arguments `1` and `"foo"`.
4. The fourth call is made with a singular argument `"foo"`.

The output shows that optional arguments which are omitted from the call have a value of `null`. This implies that the type of these arguments must admit `null` as value, which raises the question of its [nullability](types-nullability). The Haxe Compiler ensures that optional basic type arguments are nullable by inferring their type as `Null<T>` when compiling to a [static target](define-static-target).

While the first three calls are intuitive, the fourth one might come as a surprise: It is indeed allowed to skip optional arguments if the supplied value is assignable to a later argument.



<!--label:types-function-default-values-->
#### Default values

Haxe allows default values for arguments by assigning a **constant value** to them:

[code asset](assets/DefaultValues.hx)

This example is very similar to the one from [Optional Arguments](types-function-optional-arguments), with the only difference being that the values `12` and `"bar"` are assigned to the function arguments `i` and `s` respectively. The effect is that the default values are used instead of `null` should an argument be omitted from the call.

Default values in Haxe are not part of the type and are not replaced at the call-site (unless the function is [inlined](class-field-inline)). On some targets the compiler may still pass `null` for omitted argument values and generate code similar to this into the function:
```haxe
	static function test(i = 12, s = "bar") {
		if (i == null) i = 12;
		if (s == null) s = "bar";
		return "i: " +i + ", s: " +s;
	}
```
This should be considered in performance-critical code where a solution without default values may sometimes be more viable.





<!--label:types-dynamic-->
### Dynamic

While Haxe has a static type system, this type system can, in effect, be turned off by using the `Dynamic` type. A **dynamic value** can be assigned to anything and anything can be assigned to it. This has several drawbacks:

* The compiler can no longer type-check assignments, function calls and other constructs where specific types are expected.
* Certain optimizations, in particular when compiling to static targets, can no longer be employed.
* Some common errors, e.g. a typo in field access, cannot be caught at compile-time and likely cause an error at runtime.
* [Dead Code Elimination](cr-dce) cannot detect used fields if they are used through `Dynamic`.

It is very easy to come up with examples where the usage of `Dynamic` can cause problems at runtime. Consider compiling the following two lines to a static target:

```haxe
var d:Dynamic = 1;
d.foo;
```

Trying to run a compiled program in the Flash Player yields an error `Property foo not found on Number and there is no default value`. Without `Dynamic`, this would have been detected at compile-time.

> ##### Trivia: Dynamic Inference before Haxe 3
>
> The Haxe 3 compiler never infers a type to `Dynamic`, so users must be explicit about it. Previous Haxe versions used to infer arrays of mixed types, e.g. `[1, true, "foo"]`, as `Array<Dynamic>`. We found that this behavior introduced too many type problems and thus removed it for Haxe 3.

Use of `Dynamic` should be minimized as there are better options in many situations but sometimes it is just practical to use it. Parts of the Haxe [Reflection](std-reflection) API use it and it is sometimes the best option when dealing with custom data structures that are not known at compile-time.

`Dynamic` behaves in a special way when being [unified](type-system-unification) with a [monomorph](types-monomorph). Monomorphs are never bound to `Dynamic` which can have surprising results in examples such as this:

[code asset](assets/DynamicInferenceIssue.hx)

Although the return type of `Json.parse` is `Dynamic`, the type of local variable `json` is not bound to it and remains a monomorph. It is then inferred as an [anonymous structure](types-anonymous-structure) upon the `json.length` field access, which causes the following `json[0]` array access to fail. In order to avoid this, the variable `json` can be explicitly typed as `Dynamic` by using `var json:Dynamic`.

> ##### Trivia: Dynamic in the Standard Library
>
> Dynamic was quite frequent in the Haxe Standard Library before Haxe 3. With the continuous improvements of the Haxe type system, the occurrences of Dynamic were reduced over the releases leading to Haxe 3.

<!--label:types-dynamic-with-type-parameter-->
#### Dynamic with Type Parameter

`Dynamic` is a special type because it allows explicit declaration with and without a [type parameter](type-system-type-parameters). If such a type parameter is provided, the semantics described in [Dynamic](types-dynamic) are constrained to all fields being compatible with the parameter type:

```haxe
var att : Dynamic<String> = xml.attributes;
// valid, value is a String
att.name = "Nicolas";
// dito (this documentation is quite old)
att.age = "26";
// error, value is not a String
att.income = 0;
```



<!--label:types-dynamic-access-->
#### Dynamic access

`DynamicAccess` is an [abstract type](types-abstract) for working with [anonymous structures](types-anonymous-structure) that are intended to hold collections of objects by the string key. Basically `DynamicAccess` wraps `Reflect`std-reflection calls in a Map-like interface.

[code asset](assets/DynamicAccess.hx)



<!--label:types-dynamic-any-->
#### Any type

`Any` is a type that is compatible with any other in both ways. 
It serves one purpose - to hold values of any type, but to actually use those values, explicit casting is required. That way the code doesn't suddenly become dynamically typed and we keep all the static typing goodness, like advanced type system features and optimizations.

The implementation is quite simple:

```haxe
abstract Any(Dynamic) from Dynamic to Dynamic {}
```

This type doesn't make any assumptions about what the value actually is and whether it supports fields or any operations - this is up to the user.

[code asset](assets/Any.hx)

It's a more type-safe alternative to `Dynamic`, because it doesn't support field access or operators and it's bound to monomorphs. So, to work with the actual value, it needs to be explicitly promoted to another type.





<!--label:types-abstract-->
### Abstract

An abstract type is a type which is actually a different type at run-time. It is a compile-time feature which defines types "over" concrete types in order to modify or augment their behavior:

[code asset](assets/MyAbstract.hx#L1-L5)

We can derive the following from this example:

* The keyword `abstract` denotes that we are declaring an abstract type.
* `AbstractInt` is the name of the abstract and could be anything conforming to the rules for type identifiers.
* Enclosed in parenthesis `()` is the **underlying type** `Int`.
* Enclosed in curly braces `{}` are the fields,
* which are a constructor function `new` accepting one argument `i` of type `Int`.

> ##### Define: Underlying Type
>
> The underlying type of an abstract is the type which is used to represent said abstract at runtime. It is usually a concrete (i.e. non-abstract) type but could be another abstract type as well.

The syntax is reminiscent of classes and the semantics are indeed similar. In fact, everything in the "body" of an abstract (that is everything after the opening curly brace) is parsed as class fields. Abstracts may have [method](class-field-method) fields and non-[physical](define-physical-field) [property](class-field-property) fields.

Furthermore, abstracts can be instantiated and used just like classes:

[code asset](assets/MyAbstract.hx#L7-L12)

As mentioned before, abstracts are a compile-time feature, so it is interesting to see what the above actually generates. A suitable target for this is JavaScript, which tends to generate concise and clean code. Compiling the above (using `haxe -main MyAbstract -js myabstract.js`) shows this JavaScript code:

```js
var a = 12;
console.log(a);
```
The abstract type `Abstract` completely disappeared from the output and all that is left is a value of its underlying type, `Int`. This is because the constructor of `Abstract` is inlined - something we shall learn about later in the section [Inline](class-field-inline) - and its inlined expression assigns a value to `this`. This might be surprising when thinking in terms of classes. However, it is precisely what we want to express in the context of abstracts. Any **inlined member method** of an abstract can assign to `this` and thus modify the "internal value".

A good question at this point is "What happens if a member function is not declared inline" because the code obviously has to go somewhere. Haxe creates a private class, known to be the **implementation class**, which has all the abstract member functions as static functions accepting an additional first argument `this` of the underlying type.

> ##### Trivia: Basic Types and abstracts
>
> Before the advent of abstract types, all basic types were implemented as extern classes or enums. While this nicely took care of some aspects such as `Int` being a "child class" of `Float`, it caused issues elsewhere. For instance, with `Float` being an extern class, it would unify with the empty structure `{}`, making it impossible to constrain a type to accept only real objects.

<!--label:types-abstract-implicit-casts-->
#### Implicit Casts

Unlike classes, abstracts allow defining implicit casts. There are two kinds of implicit casts:

* Direct: Allows direct casting of the abstract type to or from another type. This is defined by adding `to` and `from` rules to the abstract type and is only allowed for types which unify with the underlying type of the abstract.
* Class field: Allows casting via calls to special cast functions. These functions are defined using `@:to` and `@:from` metadata. This kind of cast is allowed for all types.

The following code example shows an example of **direct** casting:

[code asset](assets/ImplicitCastDirect.hx)

We declare `MyAbstract` as being `from Int` and `to Int`, meaning it can be assigned from `Int` and assigned to `Int`. This is shown in lines 9 and 10, where we first assign the `Int` `12` to variable `a` of type `MyAbstract` (this works due to the `from Int` declaration) and then that abstract back to variable `b` of type `Int` (this works due to the `to Int` declaration).

Class field casts have the same semantics, but are defined completely differently:

[code asset](assets/ImplicitCastField.hx)

By adding `@:from` to a static function, that function qualifies as implicit cast function from its argument type to the abstract. These functions must return a value of the abstract type. They must also be declared `static`.

Similarly, adding `@:to` to a function qualifies it as implicit cast function from the abstract to its return type.

In the example the method `fromString` allows the assignment of value `"3"` to variable `a` of type `MyAbstract` while the method `toArray` allows assigning that abstract to variable `b` of type `Array<Int>`.

When using this kind of cast, calls to the cast-functions are inserted where required. This becomes obvious when looking at the JavaScript output:

```js
var a = _ImplicitCastField.MyAbstract_Impl_.fromString("3");
var b = _ImplicitCastField.MyAbstract_Impl_.toArray(a);
```
This can be further optimized by [inlining](class-field-inline) both cast functions, turning the output into the following:

```haxe
var a = Std.parseInt("3");
var b = [a];
```
The **selection algorithm** when assigning a type `A` to a type `B` with at least one of them being an abstract is simple:

1. If `A` is not an abstract, go to 3.
2. If `A` defines a **to**-conversions that admits `B`, go to 6.
3. If `B` is not an abstract, go to 5.
4. If `B` defines a **from**-conversions that admits `A`, go to 6.
5. Stop, unification fails.
6. Stop, unification succeeds.

![](assets/figures/types-abstract-implicit-casts-selection-algorithm.svg)

_Figure: Selection algorithm flow chart._

By design, implicit casts are **not transitive**, as the following example shows:

[code asset](assets/ImplicitTransitiveCast.hx)

While the individual casts from `A` to `B` and from `B` to `C` are allowed, a transitive cast from `A` to `C` is not. This is to avoid ambiguous cast-paths and retain a simple selection algorithm.



<!--label:types-abstract-operator-overloading-->
#### Operator Overloading

Abstracts allow overloading of unary and binary operators by adding the `@:op` metadata to class fields:

[code asset](assets/AbstractOperatorOverload.hx)

By defining `@:op(A * B)`, the function `repeat` serves as operator method for the multiplication `*` operator when the type of the left value is `MyAbstract` and the type of the right value is `Int`. The usage is shown in line 17, which turns into this when compiled to JavaScript:

```js
console.log(_AbstractOperatorOverload.
  MyAbstract_Impl_.repeat(a,3));
```
Similar to [implicit casts with class fields](types-abstract-implicit-casts), a call to the overload method is inserted where required.

The example `repeat` function is not commutative: While `MyAbstract * Int` works, `Int * MyAbstract` does not. If this should be allowed as well, the `@:commutative` metadata can be added. If it should work **only** for `Int * MyAbstract`, but not for `MyAbstract * Int`, the overload method can be made static, accepting `Int` and `MyAbstract` as first and second type respectively.

Overloading unary operators is analogous:

[code asset](assets/AbstractUnopOverload.hx)

Both binary and unary operator overloads can return any type.

##### since Haxe 4.0.0

In addition to binary and unary operators, the `@:op` syntax can be used to overload field access and array access on abstracts.

* `@:op([])` on a function with one argument overloads array read accces.
* `@:op([])` on a function with two arguments overloads array write accces, with the first argument being the index and the second one being the written value.
* `@:op(a.b)` on a function with one argument overloads field read access.
* `@:op(a.b)` on a function with two arguments overloads field write access.

[code asset](assets/AbstractAccessOverload.hx)

##### Exposing underlying type operations

It is also possible to omit the method body of a `@:op` function, but only if the underlying type of the abstract allows the operation in question and if the resulting type can be assigned back to the abstract.

[code asset](assets/AbstractExposeTypeOperations.hx)



<!--label:types-abstract-array-access-->
#### Array Access

Array access describes the particular syntax traditionally used to access the value in an array at a certain offset. This is usually only allowed with arguments of type `Int`. Nevertheless, with abstracts, it is possible to define custom array access methods. The [Haxe Standard Library](std) uses this in its `Map` type, where the following two methods can be found:

```haxe
@:arrayAccess
public inline function get(key:K) {
  return this.get(key);
}
@:arrayAccess
public inline function arrayWrite(k:K, v:V):V {
	this.set(k, v);
	return v;
}
```
There are two kinds of array access methods:

* If an `@:arrayAccess` method accepts one argument, it is a getter.
* If an `@:arrayAccess` method accepts two arguments, it is a setter.

The methods `get` and `arrayWrite` seen above then allow the following usage:

[code asset](assets/AbstractArrayAccess.hx)

At this point it should not be surprising to see that calls to the array access fields are inserted in the output:

```js
map.set("foo",1);
console.log(map.get("foo")); // 1
```

##### Order of array access resolving

Due to a bug in Haxe versions before 3.2 the order of checked `:arrayAccess` fields was undefined. This was fixed for Haxe 3.2 so that the fields are now consistently checked from top to bottom:

[code asset](assets/AbstractArrayAccessOrder.hx)

The array access `a[0]` is resolved to the `getInt1` field, leading to lower case `f` being returned. The result might be different in Haxe versions before 3.2.

Fields which are defined earlier take priority even if they require an [implicit cast](types-abstract-implicit-casts).



<!--label:types-abstract-enum-->
#### Enum abstracts

##### since Haxe 3.1.0

By adding the `:enum` metadata to an abstract definition, that abstract can be used to define finite value sets:

[code asset](assets/AbstractEnum.hx)

The Haxe Compiler replaces all field access to the `HttpStatus` abstract with their values, as evident in the JavaScript output:

```js
Main.main = function() {
	var status = 404;
	var msg = Main.printStatus(status);
};
Main.printStatus = function(status) {
	switch(status) {
	case 404:
		return "Not found";
	case 405:
		return "Method not allowed";
	}
};
```

This is similar to accessing [variables declared as inline](class-field-inline), but has several advantages:

* The typer can ensure that all values of the set are typed correctly.
* The pattern matcher checks for [exhaustiveness](lf-pattern-matching-exhaustiveness) when [matching](lf-pattern-matching) an enum abstract.
* Defining fields requires less syntax.

##### since Haxe 4.0.0

Since Haxe 4, it is possible to declare enum abstracts without using the `:enum` metadata, instead using the more natural syntax `enum abstract`. Additionally, if the underlying type is `String` or `Int`, the values for the enum cases can be omitted and are deduced by the compiler:

* For `Int` abstracts, the deduced values increment the last user-defined value or start at zero if no value was declared yet.
* For `String` abstracts, the deduced value is the identifier of the enum case.

[code asset](assets/AbstractEnum2.hx)



<!--label:types-abstract-forward-->
#### Forwarding abstract fields

##### since Haxe 3.1.0

When wrapping an underlying type, it is sometimes desirable to "keep" parts of its functionality. Because writing forwarding functions by hand is cumbersome, Haxe allows adding the `:forward` metadata to an abstract type:

[code asset](assets/AbstractExpose.hx)

The `MyArray` abstract in this example wraps `Array`. Its `:forward` metadata has two arguments which correspond to the field names to be forwarded to the underlying type. In this example, the `main` method instantiates `MyArray` and accesses its `push` and `pop` methods. The commented line demonstrates that the `length` field is not available.

As usual we can look at the JavaScript output to see how the code is being generated:

```js
Main.main = function() {
	var myArray = [];
	myArray.push(12);
	myArray.pop();
};
```

It is also possible to use `:forward` without any arguments in order to forward all fields. Of course, the Haxe Compiler still ensures that the field actually exists on the underlying type.

> ##### Trivia: Implemented as macro
>
> Both the `:enum` and `:forward` functionality were originally implemented using [build macros](macro-type-building). While this worked nicely in non-macro code, it caused issues if these features were used from within macros. The implementation was subsequently moved to the compiler.



<!--label:types-abstract-core-type-->
#### Core-type abstracts

The Haxe Standard Library defines a set of basic types as core-type abstracts. They are identified by the `:coreType` metadata and the lack of an underlying type declaration. These abstracts can still be understood to represent a different type. Still, that type is native to the Haxe target. 

Introducing custom core-type abstracts is rarely necessary in user code as it requires the Haxe target to be able to make sense of it. However, there could be interesting use-cases for authors of macros and new Haxe targets.

In contrast to opaque abstracts, core-type abstracts have the following properties:

* They have no underlying type.
* They are considered nullable unless they are annotated with `:notNull` metadata.
* They are allowed to declare [array access](types-abstract-array-access) functions without expressions.
* [Operator overloading fields](types-abstract-operator-overloading) that have no expression are not forced to adhere to the Haxe type semantics.





<!--label:types-monomorph-->
### Monomorph

A monomorph is a type which may, through [unification](type-system-unification), morph into a different type later. We shall see details about this type when talking about [type inference](type-system-type-inference).


