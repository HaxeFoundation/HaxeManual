## 4.4.3 Dynamic

Methods can be denoted with the `dynamic` keyword to make them (re-)bindable:

```haxe
class Main {
	static dynamic function test() {
		return "original";
	}
	
	static public function main() {
		trace(test()); // original
		test = function() { return "new"; }
		trace(test()); // new
	}
}
```

The first call to `test()` invokes the original function which returns the `String` `"original"`. In the next line, `test` is **assigned** a new function. This is precisely what `dynamic` allows: Function fields can be assigned a new function. As a result, the next invocation of `test()` returns the `String` `"new"`.

Dynamic fields cannot be `inline` for obvious reasons: While inlining is done at compile-time, dynamic functions necessarily have to be resolved at runtime.

---

Previous section: [Inline](class-field-inline.md)

Next section: [Override](class-field-override.md)