## 3.3.1 Construction of generic type parameters

> ##### Define: Generic Type Parameter
>
> A type parameter is said to be generic if its containing class or method is generic.


With normal type parameter, it is not possible to construct them, i.e. `new T()` is a compiler error. This is because Haxe generates only a single function and the construct then makes no sense. This is different when the type parameter is generic: Since we know that the compiler will generate a distinct function for each type parameter combination, it is possible to replace the `T` `new T()` with the real type.

```haxe
typedef Constructible = {
	public function new(s:String):Void;
}

class Main {
	static public function main() {
		var s:String = make();
		var t:haxe.Template = make();
	}

	@:generic
	static function make<T:Constructible>():T {
		return new T("foo");
	}
}
``` 

It should be noted that [top-down inference](type-system-top-down-inference.md) is used here to determine the actual type of `T`. There are two requirements for this kind of type parameter construction to work. The constructed type parameter must be



1. generic and
2. be explicitly [constrained](type-system-type-parameter-constraints.md) to having a [constructor](types-class-constructor.md).



Here, 1. is given by `make` having the `@:generic` metadata, and 2. by `T` being constrained to `Constructible`. The constraint holds for both `String` and `haxe.Template` as both have a constructor accepting a singular `String` argument. Sure enough, the relevant Javascript output looks as expected:

```haxe
var Main = function() { }
Main.__name__ = true;
Main.make_haxe_Template = function() {
	return new haxe.Template("foo");
}
Main.make_String = function() {
	return new String("foo");
}
Main.main = function() {
	var s = Main.make_String();
	var t = Main.make_haxe_Template();
}
```

---

Previous section: [Generic](type-system-generic.md)

Next section: [Variance](type-system-variance.md)