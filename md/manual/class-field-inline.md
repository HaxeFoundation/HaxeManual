## 4.4.2 Inline

The `inline` keyword allows function bodies to be directly inserted in place of calls to them. This can be a powerful optimization tool, but should be used judiciously as not all functions are good candidates for inline behavior. The following example demonstrates the basic usage:

```haxe
class Main {
	static inline function mid(s1:Int, s2:Int) {
		return (s1 + s2) / 2;
	}
	
	static public function main() {
		var a = 1;
		var b = 2;
		var c = mid(a, b);
	}
}
```

The generated Javascript output reveals the effect of inline:

```haxe
(function () { "use strict";
var Main = function() { }
Main.main = function() {
	var a = 1;
	var b = 2;
	var c = (a + b) / 2;
}
Main.main();
})();
```

As evident, the function body `s1 + s2` of field `mid` was generated in place of the call to `add(a, b)`, with `s1` being replaced by `a` and `s2` being replaced by `b`. This avoids a function call which, depending on the target and frequency of occurrences, may yield noticeable performance improvements.

It is not always easy to judge if a function qualifies for being inline. Short functions that have no writing expressions (such as a `=` assignment) are usually a good choice, but even more complex functions can be candidates. However, in some cases inlining can actually be detrimental to performance, e.g. because the compiler has to create temporary variables for complex expressions.

---

Previous section: [Visibility](class-field-visibility.md)

Next section: [Dynamic](class-field-dynamic.md)