## 4.3.1 Overriding Methods

Overriding fields is instrumental for creating class hierarchies. Many design patterns utilize it, but here we will explore only the basic functionality. In order to use overrides in a class, it is required that this class has a [parent class](types-class-inheritance.md). Let us consider the following example:

```haxe
class Base {
	public function new() { }
	public function myMethod() {
		return "Base";
	}
}

class Child extends Base {
	public override function myMethod() {
		return "Child";
	}
}

class Main {
	static public function main() {
		var child:Base = new Child();
		trace(child.myMethod()); // Child
	}
}

```

The important components here are



* the class `Base` which has a field `method` and a constructor,
* the class `Child` which `extends Base` and also has a field `method` being declared with `override`, and
* the `Main` class whose `main` method creates an instance of `Child`, assigns it to a variable `child` of explicit type `Base` and calls `method()` on it.



The variable `child` is explicitly typed as `Base` to highlight an important difference: At compile-time the type is known to be `Base`, but the runtime still finds the correct field `method` on class `Child`. It is then obvious that the field access is resolved dynamically at runtime.

---

Previous section: [Method](class-field-method.md)

Next section: [Effects of variance and access modifiers](class-field-override-effects.md)