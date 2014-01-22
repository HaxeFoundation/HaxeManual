## 9.3.3 Class Reification

It is also possible to use reification to obtain an instance of `haxe.macro.Expr.TypeDefinition`. This is indicated by the `macro class` syntax as shown here:

```haxe
class Main {
	macro static function generateClass(funcName:String) {
		var c = macro class MyClass {
			public function new() { }
			public function $funcName() {
				trace($v{funcName} + " was called");
			}
		}
		haxe.macro.Context.defineType(c);
		return macro new MyClass();
	}
	
    public static function main() {
		var c = generateClass("myFunc");
		c.myFunc();
    }
}
```

The generated `TypeDefinition` instance is typically passed to `haxe.macro.Context.defineType` in order to add a new type to the calling context (not the macro context itself).

This kind of reification can also be useful to obtain instances of `haxe.macro.Expr.Field`, which are available from the `fields` array of the generated `TypeDefinition`.

---

Previous section: [Type Reification](macro-reification-type.md)

Next section: [Tools](macro-tools.md)