## 9.5.2 @:autoBuild

If a class has the `:autoBuild` metadata, the compiler generates `:build` metadata on all extending classes. If an interface has the `:autoBuild` metadata, the compiler generates `:build` metadata on all implementing classes and all extending interfaces. Note that `:autoBuild` does not imply `:build` on the class/interface itself.

```haxe
import haxe.macro.Context;
import haxe.macro.Expr;

class AutoBuildingMacro {
	macro static public function fromInterface():Array<Field> {
		trace("fromInterface: " +Context.getLocalType());
		return null;
	}
	
	macro static public function fromBaseClass():Array<Field> {
		trace("fromBaseClass: " +Context.getLocalType());
		return null;
	}
}
```
```haxe
@:autoBuild(AutoBuildingMacro.fromInterface())
interface I { }

interface I2 extends I { }

@:autoBuild(AutoBuildingMacro.fromBaseClass())
class Base { }

class Main extends Base implements I2 {
	static public function main() {	}
}
```

This outputs during compilation:

```haxe
AutoBuildingMacro.hx:6: fromInterface: TInst(I2,[])
AutoBuildingMacro.hx:6: fromInterface: TInst(Main,[])
AutoBuildingMacro.hx:11: fromBaseClass: TInst(Main,[])
```

It is important to keep in mind that the order of these macro executions is undefined, which is detailed in [Build Order](macro-limitations-build-order.md).

---

Previous section: [Enum building](macro-enum-building.md)

Next section: [Limitations](macro-limitations.md)