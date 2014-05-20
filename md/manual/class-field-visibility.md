## 4.4.1 Visibility

Fields are by default **private**, meaning that only the class and its sub-classes may access them. They can be made **public** by using the `public` access modifier, allowing access from anywhere.

```haxe
class MyClass {
	static public function available() {
		unavailable();
	}
	static private function unavailable() { }
}

class Main {
	static public function main() {
		MyClass.available();
		MyClass.unavailable(); // Cannot access private field unavailable
	}
}
```

Access to field `available` of class `MyClass` is allowed from within `Main` because it is denoted as being `public`. However, while access to field `unavailable` is allowed from within class `MyClass`, it is not allowed from within class `Main` because it is `private` (explicitly, although this identifier is redundant here).

The example demonstrates visibility through **static** fields, but the rules for member fields are equivalent. The following example demonstrates visibility behavior for when [inheritance](types-class-inheritance.md) is involved.

```haxe
class Base {
	public function new() { }
	private function baseField() { }
}

class Child1 extends Base {
	private function child1Field() { }
}

class Child2 extends Base {
	public function child2Field() {
		var child1 = new Child1();
		child1.baseField();
		child1.child1Field(); // Cannot access private field child1Field
	}
}

class Main {
	static public function main() { }
}
```

We can see that access to `child1.baseField()` is allowed from within `Child2` even though `child1` is of a different type, `Child1`. This is because the field is defined on their common ancestor class `Base`, contrary to field `child1Field` which can not be accessed from within `Child2`.

Omitting the visibility modifier usually defaults the visibility to `private`, but there are exceptions where it becomes `public` instead:



1. If the class is declared as `extern`.
2. If the field id declared on an [interface](types-interfaces.md).
3. If the field [overrides](class-field-overriding.md) a public field.



> ##### Trivia: Protected
>
> Haxe has no notion of a `protected` keyword known from Java, C++ and other object-oriented languages. However, its `private` behavior is equal to those language's protected behavior, so Haxe actually lacks their real private behavior.

---

Previous section: [Access Modifier](class-field-access-modifier.md)

Next section: [Inline](class-field-inline.md)