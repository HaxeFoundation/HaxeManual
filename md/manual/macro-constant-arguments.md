## 9.2.2 Constant Expressions

A macro can be declared to expect [constant](expression-constants.md) arguments:

```haxe
class Main {
	static public function main() {
		const("foo", 1, 1.5, true);
	}
	
	macro static function const(s:String, i:Int, f:Float, b:Bool) {
		trace(s);
		trace(i);
		trace(f);
		trace(b);
		return macro null;
	}
}
```

With these it is not necessary to detour over expressions as the compiler can use the provided constants directly.

---

Previous section: [ExprOf](macro-ExprOf.md)

Next section: [Rest Argument](macro-rest-argument.md)