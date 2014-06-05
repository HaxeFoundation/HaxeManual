## 2.4.1 Enum Constructor

Similar to classes and their constructors, enums provide a way of instantiating them by using one of their constructors. However, unlike classes, enums provide multiple constructors which can easily be used through their name:

```haxe
var a = Red;
var b = Green;
var c = Rgb(255, 255, 0);
```
In this code, the type of variables `a`, `b` and `c` is `Color`. Variable `c` is initialized using the `Rgb` constructor with arguments.

All enum instances can be assigned to a special type named `EnumValue`.

> ##### Define: EnumValue
>
> EnumValue is a special type which unifies with all enum instances. It is used by the Haxe Standard Library to provide some operations for all enum instances, and can be employed in user-code accordingly in cases where an API requires **an** enum instance, but not a specific one.


It is important to distinguish enum types and enum constructors, as this example demonstrates:

```haxe
enum Color {
  Red;
  Green;
  Blue;
  Rgb(r:Int, g:Int, b:Int);
}

class Main {
  static public function main() {
    var ec:EnumValue = Red; // valid
    var en:Enum<Color> = Color; // valid
    // Error: Color should be Enum<Color>
    //var x:Enum<Color> = Red;
  }
}

```

If the commented line uncommented, the program does not compile because `Red` (an enum constructor) cannot be assigned to a variable of type `Enum<Color>` (an enum type). The relation is analogous to a class and its instance.

> ##### Trivia: Concrete type parameter for `Enum<T>`
>
> One of the reviewers of this manual was confused about the difference between `Color` and `Enum<Color>` in the example above. Indeed, using a concrete type parameter there is pointless and only has the purpose of demonstration. Usually we would omit the type there and let [type inference](type-system-type-inference.md) deal with it.
> 
> However, the inferred type would be different from `Enum<Color>`. The compiler infers a pseudo-type which has the enum constructors as "fields". As of Haxe 3.2.0, it is not possible to express this type in syntax, but it is also never necessary to do that.

---

Previous section: [Enum Instance](types-enum-instance.md)

Next section: [Using enums](types-enum-using.md)

Contribute: [fileAndLines](https://github.com/HaxeFoundation/HaxeManual/blob/master/02-types.tex#L352-352)