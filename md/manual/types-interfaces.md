## 2.3.3 Interfaces

An interface can be understood as the signature of a class because it describes the public fields of a class. Interfaces do not provide implementations, but rather pure structural information:

```haxe
interface Printable {
	public function toString():String;
}
```
The syntax is similar to classes, with the following exceptions:



* `interface` keyword is used instead of `class` keyword
* functions do not have any [expressions](expression.md)
* every field must have an explicit type


Interfaces, unlike [structural subtyping](type-system-structural-subtyping.md), describe a **static relation** between classes. A given class is only considered to be compatible to an interface if it explicitly states so:

```haxe
class Point implements Printable { }
```
The `implements` keyword here denotes that `Point` has a "is-a" relationship to `Printable`, i.e. each instance of `Point` is also an instance of `Printable`. While a class may only have one parent class, it may implement multiple interfaces through multiple `implements` keywords:

```haxe
class Point implements Printable implements Serializable
```

The compiler checks if the `implements` assumption holds. That is, it makes sure the class actually does implement all the fields required by the interface. A field is considered implemented if the class or any of its parent classes provide an implementation.

Interface fields are not limited to methods, they can be variables and properties as well:

```haxe
interface Placeable {
	public var x:Float;
	public var y:Float;
}

class Main implements Placeable {
	public var x:Float;
	public var y:Float;
	static public function main() { }
}
```

> ##### Trivia: Implements Syntax
>
> Haxe versions prior to 3.0 required multiple `implements` keywords to be separated by a comma. We decided to adhere to the de-facto standard of Java and got rid of the comma. This was one of the breaking changes between Haxe 2 and 3.

---

Previous section: [Inheritance](types-class-inheritance.md)

Next section: [Enum Instance](types-enum-instance.md)

Contribute: [fileAndLines](https://github.com/HaxeFoundation/HaxeManual/blob/master/02-types.tex#L275-275)