## 9.2.1 ExprOf

Since `Expr` is compatible with any possible input, Haxe provides the type `haxe.macro.ExprOf<T>`. For the most part, this type is identical to `Expr`, but it allows constraining the type of accepted expressions. This is useful when combining macros with [static extensions](lf-static-extension.md):

```haxe
import haxe.macro.Expr;
using Main;

class Main {
	static public function main() {
		identity("foo");
		identity(1);
		"foo".identity();
		//1.identity(); // Int has no field identity
	}
	
	macro static function identity(e:ExprOf<String>) {
		return e;
	}
}
```

The two direct calls to `identity` are accepted, even though the argument is declared as `ExprOf<String>`. It might come as a surprise that the `Int` `1` is accepted, but it is a logical consequence of what was explained about [macro arguments](macro-arguments.md): The argument expressions are never typed, so it is not possible for the compiler to check their compatibility by [unifying](type-system-unification.md).

This is different for the next two lines which are using static extensions (note the `using Main`): For these it is mandatory to type the left side (`"foo"` and `1`) first in order to make sense of the `identity` field access. This makes it possible to check the types against the argument types, which causes `1.identity()` to not consider `Main.identity()` as a suitable field.

---

Previous section: [Arguments](macro-arguments.md)

Next section: [Constant Expressions](macro-constant-arguments.md)