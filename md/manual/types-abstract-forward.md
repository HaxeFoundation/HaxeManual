## 2.8.6 Forwarding abstract fields

##### since Haxe 3.1.0



When wrapping an underlying type, it is sometimes desirable to "keep" parts of its functionality. Because writing forwarding functions by hand is cumbersome, Haxe allows adding the `:forward` metadata to an abstract type:

```haxe
@:forward(push, pop)
abstract MyArray<S>(Array<S>) {
	public inline function new() {
		this = [];
	}
}

class Main {
	static public function main() {
		var myArray = new MyArray();
		myArray.push(12);
		myArray.pop();
		//myArray.length; // MyArray<Int> has no field length
	}
}
```

The `MyArray` abstract in this example wraps `Array`. Its `:forward` metadata has two arguments which correspond to the field names to be forwarded to the underlying type. In this example, the `main` method instantiates `MyArray` and accesses its `push` and `pop` methods. The commented line demonstrates that the `length` field is not available.

As usual we can look at the Javascript output to see how the code is being generated:

```haxe
Main.main = function() {
	var myArray = [];
	myArray.push(12);
	myArray.pop();
};
```

It is also possible to use `:forward` without any arguments in order to forward all fields. Of course the Haxe compiler still ensures that the field actually exists on the underlying type.

> ##### Trivia: Implemented as macro
>
> Both the `:enum` and `:forward` functionality were originally implemented using [build macros](macro-type-building.md). While this worked nicely in non-macro code, it caused issues if these features were used from within macros. The implementation was subsequently moved to the compiler.

---

Previous section: [Enum abstracts](types-abstract-enum.md)

Next section: [Core-type abstracts](types-abstract-core-type.md)

Contribute: [fileAndLines](https://github.com/HaxeFoundation/HaxeManual/blob/master/02-types.tex#L800-800)