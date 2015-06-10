## 6.11 Inline constructors

##### since Haxe 3.1.0

If a constructor is declared to be [inline](class-field-inline.md), the compiler may try to optimize it away in certain situations. There are several requirements for this to work:

* The result of the constructor call must be directly assigned to a local variable.
* The expression of the constructor field must only contain assignments to its fields.

The following example demonstrates constructor inlining:

```haxe
class Point {
  public var x:Float;
  public var y:Float;

  public inline function new(x:Float, y:Float) {
    this.x = x;
    this.y = y;
  }
}

class Main {
  static public function main() {
    var pt = new Point(1.2, 9.3);
  }
}
```

A look at the JavaScript output reveals the effect:

```haxe
Main.main = function() {
	var pt_x = 1.2;
	var pt_y = 9.3;
};
```

---

Previous section: [Access Control](lf-access-control.md)

Next section: [Compiler Usage](compiler-usage.md)