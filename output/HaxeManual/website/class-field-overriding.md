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

The important components here are:

* the class `Base` which has a method `myMethod` and a constructor,
* the class `Child` which `extends Base` and also has a method `myMethod` being declared with `override`, and
* the `Main` class whose `main` method creates an instance of `Child`, assigns it to a variable `child` of explicit type `Base` and calls `myMethod()` on it.

The variable `child` is explicitly typed as `Base` to highlight an important difference: At compile-time the type is known to be `Base`, but the runtime still finds the correct method `myMethod` on class `Child`. This is because field access is resolved dynamically at runtime.

The `Child` class can access methods it has overridden by calling `super.methodName()`:

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

  public function callHome() {
    return super.myMethod();
  }

}

class Main {
  static public function main() {
    var child = new Child();
    trace(child.callHome()); // Base
  }
}

```

The section on [Inheritance](types-class-inheritance.md) explains the use of `super()` from within a `new` constructor.

---

Previous section: [Method](class-field-method.md)

Next section: [Effects of variance and access modifiers](class-field-override-effects.md)