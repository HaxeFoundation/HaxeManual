## 9.2.3 Rest Argument

If the final argument of a macro is of type `Array<Expr>`, the macro accepts an arbitrary number of extra arguments which are available from that array:

```haxe
import haxe.macro.Expr;

class Main {
	static public function main() {
		myMacro("foo", a, b, c);
	}
	
	macro static function myMacro(e1:Expr, extra:Array<Expr>) {
		for (e in extra) {
			trace(e);
		}
		return macro null;
	}
}
```

---

Previous section: [Constant Expressions](macro-constant-arguments.md)

Next section: [Reification](macro-reification.md)