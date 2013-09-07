An abstract type is a type which is, at runtime, actually a different type. It is a compile-time feature which defines types "over" concrete types in order to modify or augment their behavior:

```
abstract Abstract(Int) {
	inline public function new(i:Int) {
		this = i;
	}
}

class MyAbstract {
	static public function main() {
		var a = new Abstract(12);
		trace(a);
	}
}
```
We can derive the following from this example:



* The keyword `abstract` denotes that we are declaring an abstract type.
* `Abstract` is the name of the abstract and could be anything conforming to the rules for type identifiers.
* Enclosed in parenthesis `()` is the **underlying type** `Int`.
* Enclosed in curly braces `{}` are the fields,
* which is a constructor function `new` accepting one argument `i` of type `Int`.



> Define: Underlying Type

>
> The underlying type of an abstract is the type which is used to represent said abstract at runtime. It is usually a concrete (i.e. non-abstract) type, but could be another abstract type as well.

The syntax is reminiscent of classes and the semantics are indeed similar. In fact, everything in the "body" of an abstract (that is everything after the opening curly brace) is parsed as class fields. Furthermore, abstracts can be instantiated and used just like classes:

```
abstract Abstract(Int) {
	inline public function new(i:Int) {
		this = i;
	}
}

class MyAbstract {
	static public function main() {
		var a = new Abstract(12);
		trace(a);
	}
}
```
As mentioned before, abstracts are a compile-time feature, so it is interesting to see what the above actually generates. A suitable target for this is Javascript, which tends to generate concise and clean code. Compiling the above (using `haxe -main MyAbstract -js myabstract.js`) shows this Javascript code:

```
var a = 12;
console.log(a);
```
The abstract type `Abstract` completely disappeared from the output and all that is left is a value of its underlying type, `Int`. This is because the constructor of `Abstract` is inlined, something we shall learn about later in [manual/Inline], and its inlined expression assigns a value to `this`. This might be shocking when thinking in terms of classes, but it is precisely what we want to express in the context of abstracts. Any **inlined member method** of an abstract can assign to `this`, and thus modify the "internal value".

A good question at this point is what happens if a member function is not declared inline, because the code obviously has to go somewhere. Haxe creates a private class, known to be the **implementation class**, which has all the abstract member functions as static functions accepting an additional first argument `this` of the underlying type. While this technically is an implementation detail, it can be used for [manual/Selective_Functions].

> Trivia: Basic Types and abstracts
>
> Before the advent of abstract types, all basic types were implemented as extern classes or enums. While this nicely took care of some aspects such as `Int` being a "child class" of `Float`, it caused issues elsewhere. For instance, with `Float` being an extern class, it would unify with the empty structure `{}`, making it impossible to constrain a type to accepting only real objects.