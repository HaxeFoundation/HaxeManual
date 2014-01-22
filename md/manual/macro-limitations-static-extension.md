## 9.6.2 Static extension

The concepts or [static extensions](lf-static-extension.md) and macros are somewhat conflicting: While the former requires a known type in order to determine used functions, macros execute before typing on plain syntax. It is thus not surprising that combining these two features can lead to issues. Haxe 3.0 would try to convert the typed expression back to a syntax expression, which is not always possible and may lose important information. We recommend that it is used with caution.

##### since Haxe 3.1.0



The combination of static extensions and macros was reworked for the 3.1.0 release. The Haxe Compiler does not even try to find the original expression for the macro argument and instead passes a special `@:this this` expression. While the structure of this expression conveys no information, the expression can still be typed correctly:

```haxe
import haxe.macro.Context;
import haxe.macro.Expr;

using Main;
using haxe.macro.Tools;

class Main {
	static public function main() {
		"foo".test();
	}
	
	macro static function test(e:ExprOf<String>) {
		trace(e.toString()); // @:this this
		trace(Context.typeof(e)); // TInst(String,[])
		return e;
	}
}
```

---

Previous section: [Limitations](macro-limitations.md)

Next section: [Build Order](macro-limitations-build-order.md)