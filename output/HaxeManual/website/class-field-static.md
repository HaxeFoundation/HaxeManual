## 4.4.5 Static

All fields are member fields unless the modifier `static` is used. Static fields are used "on the class" whereas non-static fields are used "on a class instance":

```haxe
class Main {
  static function main() {
    Main.staticField; // static read
    Main.staticField = 2; // static write
  }

  static var staticField:Int;
}
```

Static [variable](class-field-variable.md) and [property](class-field-property.md) fields can have arbitrary initialization [expressions](expression.md).

---

Previous section: [Override](class-field-override.md)

Next section: [Expressions](expression.md)