## 2.8.4 Selective Functions

Since the compiler promotes abstract member functions to static functions, it is possible to define static functions by hand and use them on an abstract instance. The semantics here are similar to those of [static extensions](lf-static-extension.md), where the type of the first function argument determines for which types a function is defined:

```haxe
abstract MyAbstract<T>(T) from T {
	public function new(t:T) this = t;
	
	function get() return this;
	
	static public function getString(v:MyAbstract<String>):String {
		return v.get();
	}
}

class SelectiveFunction {
	static public function main() {
		var a = new MyAbstract("foo");
		a.getString();
		var b = new MyAbstract(1);
		b.getString(); // Int should be MyAbstract<String>
	}
}
```
The method `getString` of abstract `MyAbstract` is defined to accept a first argument of `MyAbstract<String>`. This causes it to be available on variable `a` on line 14 (because the type of `a` is `MyAbstract<String>`), but not on variable `b` whose type is `MyAbstract<Int>`.

> ##### Trivia: Accidental Feature
>
> Selective functions were never actually designed, but rather discovered. After the idea was first mentioned, it required only minor adjustments in the compiler to make them work. Their discovery also lead to the introduction of multi-type abstracts, such as Map.

---

Previous section: [Array Access](types-abstract-array-access.md)

Next section: [Enum abstracts](types-abstract-enum.md)