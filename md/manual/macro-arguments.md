## 9.2 Arguments

Most of the time, arguments to macros are expressions represented as an instance of enum `Expr`. As such, they are parsed but not typed, meaning they can be anything conforming to Haxe's syntax rules. The macro can then inspect their structure, or (try to) get their type using `haxe.macro.Context.typeof()`.

It is important to understand that arguments to macros are not guaranteed to be evaluated, so any intended side-effect is not guaranteed to occur. On the other hand, it is also important to understand that an argument expression may be duplicated by a macro and used multiple times in the returned expression:

```haxe
import haxe.macro.Expr;

class Main {
	static public function main() {
		var x = 0;
		var b = add(x++);
		trace(x); // 2
	}
	
	macro static function add(e:Expr) {
		return macro $e + $e;
	}
}
```

The macro `add` is called with `x++` as argument and thus returns `x++ + x++` using [expression reification](macro-reification-expression.md), causing `x` to be incremented twice.

---

Previous section: [Macro Context](macro-context.md)

Next section: [ExprOf](macro-ExprOf.md)