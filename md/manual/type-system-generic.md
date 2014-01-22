## 3.3 Generic

Usually, the Haxe Compiler generates only a single class or function, even if it has type parameters. This results in a natural abstraction, where the code generator for the target language has to assume that a type parameter could be of any type. The generated code then might have to perform some type checks, which can be detrimental to performance.

A class or function can be made **generic** by attributing it with the `:generic` [metadata](lf-metadata.md). This causes the compiler to emit a distinct class/function per type parameter combination with mangled names. A specification like this can yield a boost in performance-critical code portions on [static targets](dictionary.md#static-target) at the cost of a larger output size:

```haxe
@:generic
class MyArray<T> {
	public function new() { }
}

class Main {
	static public function main() {
		var a = new MyArray<String>();
	}
}
```

It seems unusual to see the explicit type `MyArray<String>` here as we usually let [type inference](type-system-type-inference.md) deal with this, but here it is indeed required. The compiler has to know the exact type of a generic class upon construction. The Javascript output shows the result:

```haxe
(function () { "use strict";
var Main = function() { }
Main.main = function() {
	var a = new MyArray_String();
	var b = new MyArray_Int();
}
var MyArray_Int = function() {
};
var MyArray_String = function() {
};
Main.main();
})();
```

We can identify that `MyArray<String>` and `MyArray<Int>` have become `MyArray_String` and `MyArray_Int` respectively. This is similar for generic functions:

```haxe
class Main {
	static public function main() {
		method("foo");
		method(1);
	}
	
	@:generic static function method<T>(t:T) { }
}
```

Again, the Javascript output makes it obvious:

```haxe
(function () { "use strict";
var Main = function() { }
Main.method_Int = function(t) {
}
Main.method_String = function(t) {
}
Main.main = function() {
	Main.method_String("foo");
	Main.method_Int(1);
}
Main.main();
})();
```

---

Previous section: [Constraints](type-system-type-parameter-constraints.md)

Next section: [Construction of generic type parameters](type-system-generic-type-parameter-construction.md)