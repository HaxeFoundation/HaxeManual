## 2.4.1 Enum Constructor

Similar to classes and their constructors, enums provide a way of instantiating them by using one of their constructors. However, unlike classes, enums provide multiple constructors which can easily be used through their name:

```haxe
var a = Red;
var b = Green;
var c = Rgb(255, 255, 0);
```
In this code, the type of variables `a`, `b` and `c` is instance of enum `Color`. Variable `c` is initialized using the `Rgb` constructor with arguments.

All enum instances can be assigned to a special type named `EnumValue`.
> ##### Define: EnumValue
>
> EnumValue is a special type which unifies with all enum instances. It is used by the standard library to provide some operations for all enum instances, and can be employed in user-code accordingly.


It is important to distinguish enum types and enum constructors, as this example demonstrates:

```haxe
import Color;

class EnumUnification {
	static public function main() {
		var ec:EnumValue = Red; // valid
		var en:Enum<Color> = Color; // valid
		//var x:Enum<Color> = Red; // Compile Error: Color should be Enum<Color>
	}
}

```
If line 7 is uncommented, the program does not compile because `Red` (an enum constructor) cannot be assigned to a variable of type `Enum<Color>` (an enum type). The relation is analogous to a class and its instance.

---

Previous section: [Enum Instance](types-enum-instance.md)

Next section: [Anonymous Structure](types-anonymous-structure.md)