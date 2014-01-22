## 9.6.3 Build Order

The build order of types is unspecified and this extends to the execution order of [build-macros](macro-type-building.md). While certain rules can be determined, we strongly recommend to not rely on the execution order of build-macros. If type building requires multiple passes, this should be reflected directly in the macro code. In order to avoid multiple build-macro execution on the same type, state can be stored in static variables or added as [metadata](lf-metadata.md) to the type in question:

```haxe
import haxe.macro.Context;
import haxe.macro.Expr;

#if !macro
@:autoBuild(MyMacro.build())
#end
interface I1 { }

#if !macro
@:autoBuild(MyMacro.build())
#end
interface I2 { }

class C implements I1 implements I2 { }

class MyMacro {
	macro static public function build():Array<Field> {
		var c = Context.getLocalClass().get();
		if (c.meta.has(":processed")) return null;
		c.meta.add(":processed",[],c.pos);
		// process here
		return null;
	}
}

class Main {
	static public function main() { }
}
```

With both interfaces `I1` and `I2` having `:autoBuild` metadata, the build macro is executed twice for class `C`. We guard against duplicate processing by adding a custom `:processed` metadata to the class, which can be checked during the second macro execution.

---

Previous section: [Static extension](macro-limitations-static-extension.md)

Next section: [Standard Library](std.md)