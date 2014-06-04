## 2.7.2 Implementing Dynamic

Classes can [implement](types-interfaces.md) `Dynamic` and `Dynamic<T>`, which enables arbitrary field access. In the former case, fields can have any type, in the latter they are constrained to be compatible with the parameter type:

```haxe
class ImplementsDynamic implements Dynamic<String> {
	public var present:Int;
	public function new() {}
}

class Main {
	static public function main() {
		var c = new ImplementsDynamic();
		c.present = 1; // valid, present is an existing field
		c.stringField = "foo"; // valid, assigned value is a String
		//c.intField = 1; // error, Int should be String
	}
}
```

Implementing `Dynamic` does not satisfy the requirements of other implemented interfaces. The expected fields still have to be implemented explicitly.

Classes that implement `Dynamic` (with or without type parameter) can also utilize a special method named `resolve`. If a [read access](dictionary.md#read-access) is made and the field in question does not exists, the `resolve` method is called with the field name as argument:

```haxe
class Resolve implements Dynamic<String> {
	public var present:Int;
	public function new() {}
	function resolve(field:String) {
		return "Tried to resolve " +field;
	}
}

class Main {
	static public function main() {
		var c = new Resolve();
		c.present = 2;
		trace(c.present);
		trace(c.resolveMe);
	}
}
```

---

Previous section: [Dynamic with Type Parameter](types-dynamic-with-type-parameter.md)

Next section: [Abstract](types-abstract.md)

Contribute: [fileAndLines](https://github.com/HaxeFoundation/HaxeManual/blob/master/02-types.tex#L583-583)