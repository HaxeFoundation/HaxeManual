Classes may inherit from other classes, which in haxe is denoted by the `extends` keyword:

```
class Point3 extends Point {
	var z : Int;
	public function new(x,y,z) {
		super(x,y);
		this.z = z;
	}
}
```
This relation is often described as "is-a": Any instance of class `Point3` is also an instance of `Point`. `Point` is then known as the **parent class** of `Point3`, which is a **child class** of `Point`. A class may have many child classes, but only one parent class.

The code above is very similar to the original `Point` class, with two new constructs being shown:


 * `extends Point` denotes that this class inherits from class `Point`
 * `super(x, y)` is the call to the constructor of the parent class, in this case `Point.new`


It is not necessary for child classes to define their own constructors, but if they do a call to `super()` is mandatory. Unlike some other object-oriented languages, this call can appear anywhere in the constructor code and does not have to be the first expression.

A class may override [[manual/Method]] of its base class, which requires the explicit `override` keyword. The effects and restrictions of this are detailed in [[manual/Overriding_Fields]].