## 4.2.2 Impact on the type system

The presence of properties has several consequences on the type system. Most importantly, it is necessary to understand that properties are a compile-time feature and thus **require the types to be known**. If we were to assign a class with properties to `Dynamic`, field access would **not** respect accessor methods. Likewise, access restrictions no longer apply and all access is virtually public.

When using `get` or `set` access identifier, the compiler ensures that the getter and setter actually exists. The following problem does not compile:

```haxe
class Main {
	public var x(get, null):Int; // Method get_x required by property x is missing
	
	static public function main() {}
}
```

The method `get_x` is missing, but it need not be declared on the class defining the property itself as long as a parent class defines it:

```haxe
class Base {
	public function get_x() return 1;
}

class Main extends Base {
	public var x(get, null):Int; // ok, get_x is declared by parent class
	
	static public function main() {}
}
```

The `dynamic` access modifier works exactly like `get` or `set`, but does not check for the existence

---

Previous section: [Common accessor identifier combinations](class-field-property-common-combinations.md)

Next section: [Rules for getter and setter](class-field-property-rules.md)