## 2.8 Abstract

An abstract type is a type which is, at runtime, actually a different type. It is a compile-time feature which defines types "over" concrete types in order to modify or augment their behavior:

```haxe
abstract AbstractInt(Int) {
	inline public function new(i:Int) {
		this = i;
	}
}
```
We can derive the following from this example:



* The keyword `abstract` denotes that we are declaring an abstract type.
* `Abstract` is the name of the abstract and could be anything conforming to the rules for type identifiers.
* Enclosed in parenthesis `()` is the **underlying type** `Int`.
* Enclosed in curly braces `{}` are the fields,
* which is a constructor function `expressionnew` accepting one argument `i` of type `Int`.



> ##### Define: Underlying Type
>
> The underlying type of an abstract is the type which is used to represent said abstract at runtime. It is usually a concrete (i.e. non-abstract) type, but could be another abstract type as well.


The syntax is reminiscent of classes and the semantics are indeed similar. In fact, everything in the "body" of an abstract (that is everything after the opening curly brace) is parsed as class fields. Abstracts may have [method](class-field-method.md) fields and non-[physical](dictionary.md#physical-field) [property](class-field-property.md) fields.

Furthermore, abstracts can be instantiated and used just like classes:

```haxe
class MyAbstract {
	static public function main() {
		var a = new AbstractInt(12);
		trace(a); //12
	}
}
```
As mentioned before, abstracts are a compile-time feature, so it is interesting to see what the above actually generates. A suitable target for this is Javascript, which tends to generate concise and clean code. Compiling the above (using `haxe -main MyAbstract -js myabstract.js`) shows this Javascript code:

```haxe
var a = 12;
console.log(a);
```
The abstract type `Abstract` completely disappeared from the output and all that is left is a value of its underlying type, `Int`. This is because the constructor of `Abstract` is inlined, something we shall learn about later in section [Inline](class-field-inline.md), and its inlined expression assigns a value to `this`. This might be shocking when thinking in terms of classes, but it is precisely what we want to express in the context of abstracts. Any **inlined member method** of an abstract can assign to `this`, and thus modify the "internal value".

A good question at this point is what happens if a member function is not declared inline, because the code obviously has to go somewhere. Haxe creates a private class, known to be the **implementation class**, which has all the abstract member functions as static functions accepting an additional first argument `this` of the underlying type. While this technically is an implementation detail, it can be used for [selective functions](types-abstract-selective-functions.md).



> ##### Trivia: Basic Types and abstracts
>
> Before the advent of abstract types, all basic types were implemented as extern classes or enums. While this nicely took care of some aspects such as `Int` being a "child class" of `Float`, it caused issues elsewhere. For instance, with `Float` being an extern class, it would unify with the empty structure `{}`, making it impossible to constrain a type to accepting only real objects.

---

Previous section: [Implementing Dynamic](types-dynamic-implemented.md)

Next section: [Implicit Casts](types-abstract-implicit-casts.md)