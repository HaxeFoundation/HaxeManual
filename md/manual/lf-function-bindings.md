## 6.6 Function Bindings

Haxe 3 allows binding functions with partially applied arguments. Each function type can be considered to have a `bind` field, which can be called with the desired number of arguments in order to create a new function. This is demonstrated here:

```haxe
class Bind {
	static public function main() {
		var map = new Map<Int,String>();
		var f = map.set.bind(_, "12");
		$type(map.set); // Int -> String -> Void
		$type(f); // Int -> Void	
		f(1);
		f(2);
		f(3);
		trace(map.toString()); // {1 => 12, 2 => 12, 3 => 12}
	}
}
```
Line 4 binds the function `map.set` to a variable named `f`, and applies `12` as second argument. The underscore `_` is used to denote that this argument is not bound, which is shown by comparing the types of `map.set` and `f`: The bound `String` argument is effectively cut from the type, turning a `Int->String->Void` type into `Int->Void`.

A call to `f(1)` then actually invokes `map.set(1, "12")`, the calls to `f(2)` and `f(3)` are analogous. The last line proves that all three indices indeed are mapped to the value `"12"`.

The underscore `_` can be skipped for trailing arguments, so the the first argument could be bound through `map.set.bind(1)`, yielding a `String->Void` function that sets a new value for index `1` on invocation.

> ##### Trivia: Callback
>
> Prior to haxe 3, haxe used to know a `callback`-keyword which could be called with a function argument followed by any number of binding arguments. The name originated from a common usage were a callback-function is created with the this-object being bound.
> 
> Callback would allow binding of arguments only from left to right as there was no support for the underscore `_`. The choice to use an underscore was controversial and several other suggestions were made, none of which were considered superior. After all, the underscore `_` at least looks like it's saying "fill value in here", which nicely describes its semantics.

---

Previous section: [Array Comprehension](lf-array-comprehension.md)

Next section: [Metadata](lf-metadata.md)