## 9.5.1 Enum building

Building [enums](types-enum-instance.md) is analogous to building classes with a simple mapping:



* Enum constructors without arguments are variable fields `FVar`.
* Enum constructors with arguments are method fields `FFun`.





```haxe
import haxe.macro.Context;
import haxe.macro.Expr;

class EnumBuildingMacro {
	macro static public function build():Array<Field> {
		var noArgs = makeEnumField("A", FVar(null, null));
		var fInt = switch (macro function(value:Int) { }).expr {
			case EFunction(_,f): f;
			case _: throw "false";
		}
		var intArg = makeEnumField("B", FFun(fInt));
		return [noArgs, intArg];
	}
	
	static function makeEnumField(name, kind) {
		return {
			name: name,
			doc: null,
			meta: [],
			access: [],
			kind: kind,
			pos: Context.currentPos()
		}
	}
}
```
```haxe
@:build(EnumBuildingMacro.build())
enum E { }

class Main {
	static public function main() {
		switch(E.A) {
			case A:
			case B(v):
		}
	}
}
```

Because enum `E` is annotated with a `:build` metadata, the called macro builds two constructors `A` and `B` "into" it. The former is added with the kind being `FVar(null, null)`, meaning it is a constructor without argument. For the latter, we use [reification](macro-reification-expression.md) to obtain an instance of `haxe.macro.Expr.Function` with a singular `Int` argument.

The `main` method proves the structure of our generated enum by [matching](lf-pattern-matching.md) it. We can see that the generated type is equivalent to this:

```haxe
enum E {
	A;
	B(value:Int);
}
```

---

Previous section: [Type Building](macro-type-building.md)

Next section: [@:autoBuild](macro-auto-build.md)