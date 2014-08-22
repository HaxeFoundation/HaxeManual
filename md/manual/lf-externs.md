## 6.2 Externs

Externs can be used to describe target-specific interaction in a type-safe manner. They are defined like normal classes, except that

* the `class` keyword is preceded by the `extern` keyword,
* [methods](class-field-method.md) have no expressions and
* all argument and return types are explicit.

A common example from the [Haxe Standard Library](std.md) is the `Math` class, as an excerpt shows:

```haxe
extern class Math
{
	static var PI(default,null) : Float;
	static function floor(v:Float):Int;
}
```

We see that externs can define both methods and variables (actually, `PI` is declared as a read-only [property](class-field-property.md)). Once this information is available to the compiler, it allows field access accordingly and also knows the types:

```haxe
class Main {
  static public function main() {
    var pi = Math.floor(Math.PI);
    $type(pi); // Int
  }
}
```

This works because the return type of method `floor` is declared to be `Int`.

The Haxe Standard Library comes with many externs for the Flash and Javascript target. They allow accessing the native APIs in a type-safe manner and are instrumental for designing higher-level APIs. There are also externs for many popular native libraries on [haxelib](haxelib.md).

The Flash, Java and C# targets allow direct inclusion of native libraries from [command line](compiler-reference.md). Target-specific details are explained in the respective sections of [Target Details](#).

Some targets such as Python or JavaScript may require generating additional "import" code that loads an `extern` class from a native module. Haxe provides ways to declare such dependencies also described in respective sections [Target Details](#).

---

Previous section: [Conditional Compilation](lf-condition-compilation.md)

Next section: [Static Extension](lf-static-extension.md)