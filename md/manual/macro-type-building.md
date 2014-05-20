## 9.5 Type Building

Type-building macros are different from expression macros in several ways:



* They do not return expressions, but an array of class fields. Their return type must be set explicitly to `Array<haxe.macro.Expr.Field>`.
* Their [context](macro-context.md) has no local method and no local variables.
* Their context does have build fields, available from `haxe.macro.Context.getBuildFields()`.
* They are not called directly, but are argument to a `@:build` or `@:autoBuild` [metadata](lf-metadata.md) on a [class](types-class-instance.md) or [enum](types-enum-instance.md) declaration.



The following example demonstrates type building. Note that it is split up into two files for a reason: If a module contains a `macro` function, it has to be typed into macro context as well. This is often a problem for type-building macros because the type to be built could only be loaded in its incomplete state, before the building macro has run. We recommend to always define type-building macros in their own module.

```haxe
import haxe.macro.Context;
import haxe.macro.Expr;

class TypeBuildingMacro {
	macro static public function build(fieldName:String):Array<Field> {
		var fields = Context.getBuildFields();
		var newField = {
			name: fieldName,
			doc: null,
			meta: [],
			access: [AStatic, APublic],
			kind: FVar(macro : String, macro "my default"),
			pos: Context.currentPos()
		};
		fields.push(newField);
		return fields;
	}
}
```
```haxe
@:build(TypeBuildingMacro.build("myFunc"))
class Main {
	static public function main() {
		trace(Main.myFunc); // my default
	}
}
```

The `build` method of `TestBuildingMacro` performs three steps:



1. It obtains the build fields using `Context.getBuildFields()`.
2. It declares a new `haxe.macro.expr.Field` field using the `funcName` macro argument as field name. This field is a `String` [variable](class-field-variable.md) with a default value `"my default"` (from the `kind` field) and is public and static (from the `access` field).
3. It adds the new field to the build field array and returns it.



This macro is argument to the `@:build` metadata on the `Main` class. As soon as this type is required, the compiler does the following:



1. It parses the module file, including the class fields.
2. It sets up the type, including its relation to other types through [inheritance](types-class-inheritance.md) and [interfaces](types-interfaces.md).
3. It executes the type-building macro according to the `@:build` metadata.
4. It continues typing the class normally with the fields returned by the type-building macro.



This allows adding and modifying class fields at will in a type-building macro. In our example, the macro is called with a `"myFunc"` argument, making `Main.myFunc` a valid field access.

If a type-building macro should not modify anything, the macro can return `null`. This indicates to the compiler that no changes are intended and is preferable to returning `Context.getBuildFields()`.

---

Previous section: [Tools](macro-tools.md)

Next section: [Enum building](macro-enum-building.md)