Since the compiler promotes abstract member functions to static functions, it is possible to define static functions by hand and use them on an abstract instance. The semantics here are similar to those of [manual/Using-Mixins], where the type of the first function argument determines for which types a function is defined:

```
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
The method `getString` of abstract `MyAbstract` is defined to accept a first argument of `MyAbstract$<$String$>$`. This causes it to be available on variable `a` on line 14 (because the type of `a` is `MyAbstract$<$String$>$`), but not on variable `b` whose type is `MyAbstract$<$Int$>$`.