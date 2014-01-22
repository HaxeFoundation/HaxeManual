## 2.8.6 Exposing abstracts

##### since Haxe 3.1.0



When wrapping an underlying type, it is sometimes desirable to "keep" parts of its functionality. Because writing forwarding functions by hand is cumbersome, Haxe allows adding the `:expose` metadata to an abstract type:

```haxe
@:expose(push, pop => read)
abstract MyArray<S>(Array<S>) {
	public inline function new() {
		this = [];
	}
}

class Main {
	static public function main() {
		var myArray = new MyArray();
		myArray.push(12);
		myArray.read();
	}
}
```

The `MyArray` abstract in this example wraps `Array`. Its `:expose` metadata has two arguments which demonstrate the two allowed ways of specifying exposed fields:



* With a plain identifier (here: `push`) to expose the field as is.
* Using the `=>` notation (here: `pop => read`) to expose the underlying field on the left side (here: `pop`) as the field name on the right side (here: `read`).



In this example, the `main` function instantiates `MyArray` and accesses its `pop` and `read` function. As usual we can look at the Javascript output to see how the code is being generated:

```haxe
Main.main = function() {
	var myArray = [];
	myArray.push(12);
	myArray.pop();
};
```

> ##### Trivia: Implemented as macro
>
> Both the `:enum` and `:expose` functionality are implemented using [macros](macro.md). The implementations can be found in the file `haxe/macro/Build.hx`. The compiler rewrites both metadata as a `:build` metadata which calls the implementations. See [type building](macro-type-building.md) for details.

---

Previous section: [Enum abstracts](types-abstract-enum.md)

Next section: [Core-type abstracts](types-abstract-core-type.md)