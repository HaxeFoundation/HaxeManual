## 4.2.1 Common accessor identifier combinations

The next example shows common access identifier combinations for properties:

```haxe
class Main {
	// read from outside, write only within Main
	public var ro(default, null):Int;
	
	// write from outside, read only within Main
	public var wo(null, default):Int;
	
	// access through getter get_x and setter set_x
	public var x(get, set):Int;
	
	// read access through getter, no write access
	public var y(get, never):Int;
	
	// required by field x
	function get_x() return 1;
	
	// required by field x
	function set_x(x) return x;
	
	// required by field y
	function get_y() return 1;
	
	function new() {
		var v = x;
		x = 2;
		x += 1;
	}
	
	static public function main() {
		new Main();
	}
}
```

The Javascript output helps understand what the field access in the `main`-method is compiled to:

```haxe
var Main = function() {
	var v = this.get_x();
	this.set_x(2);
	var _g = this;
	_g.set_x(_g.get_x() + 1);
};
```

As specified, the read access generates a call to `get_x()`, while the write access generates a call to `set_x(2)` where `2` is the value being assigned to `x`. The way the `+=` is being generated might look a little odd at first, but can easily be justified by the following example:

```haxe
class Main {
	public var x(get, set):Int;
	function get_x() return 1;
	function set_x(x) return x;
	
	public function new() { }
	
	static public function main() {
		new Main().x += 1;
	}
}
```

What happens here is that the expression part of the field access to `x` in the `main` method is **complex**: It has potential side-effects, such as the construction of `Main` in this case. Thus, the compiler cannot generate the `+=` operation as `new Main().x = new Main().x + 1` and has to cache the complex expression in a local variable:

```haxe
Main.main = function() {
	var _g = new Main();
	_g.set_x(_g.get_x() + 1);
}
```

---

Previous section: [Property](class-field-property.md)

Next section: [Impact on the type system](class-field-property-type-system-impact.md)