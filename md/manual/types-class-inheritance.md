## 2.3.2 Inheritance

Classes may inherit from other classes, which in Haxe is denoted by the `extends` keyword:

```haxe
class Point3 extends Point {
  var z : Int;
  public function new(x,y,z) {
    super(x,y);
    this.z = z;
  }
}
```
This relation is often described as "is-a": Any instance of class `Point3` is also an instance of `Point`. `Point` is then known as the **parent class** of `Point3`, which is a **child class** of `Point`. A class may have many child classes, but only one parent class. The term "a parent class of class X" usually refers to its direct parent class, the parent class of its parent class and so on.

The code above is very similar to the original `Point` class, with two new constructs being shown:


 * `extends Point` denotes that this class inherits from class `Point`
 * `super(x, y)` is the call to the constructor of the parent class, in this case `Point.new`


It is not necessary for child classes to define their own constructors, but if they do, a call to `super()` is mandatory. Unlike some other object-oriented languages, this call can appear anywhere in the constructor code and does not have to be the first expression.

A class may override [methods](class-field-method.md) of its parent class, which requires the explicit `override` keyword. The effects and restrictions of this are detailed in [Overriding Methods](class-field-overriding.md).

---

Previous section: [Class constructor](types-class-constructor.md)

Next section: [Interfaces](types-interfaces.md)

Contribute: [fileAndLines](https://github.com/HaxeFoundation/HaxeManual/blob/master/02-types.tex#L277-277)