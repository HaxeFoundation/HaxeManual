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

The Flash, Java and C# targets allow direct inclusion of native libraries from [command line](compiler-usage.md). Target-specific details are explained in the respective sections of [Target Details](target-details.md).

Some targets such as Python or JavaScript may require generating additional "import" code that loads an `extern` class from a native module. Haxe provides ways to declare such dependencies also described in respective sections [Target Details](target-details.md).

###### Rest arguments and type choices
##### since Haxe 3.2.0

The haxe.extern package provides two types that help mapping native semantics to Haxe:

* `Rest<T>`: This type can be used as a final function argument to allow passing an arbitrary number of additional call arguments. The type parameter can be used to constrain these arguments to a specific type.
* `EitherType<T1,T2>`: This type allows using either of its parameter types, thus representing a type choice. It can be nested to allow more than two different types.

We demonstrate the usage in this code sample:

```haxe
import haxe.extern.Rest;
import haxe.extern.EitherType;

extern class MyExtern {
  static function f1(s:String, r:Rest<Int>):Void;
  static function f2(e:EitherType<Int, String>):Void;
}

class Main {
  static function main() {
    MyExtern.f1("foo", 1, 2, 3); // use 1, 2, 3 as rest argument
    MyExtern.f1("foo"); // no rest argument
    //MyExtern.f1("foo", "bar"); // String should be Int

    MyExtern.f2("foo");
    MyExtern.f2(12);
    //MyExtern.f2(true); // Bool should be EitherType<Int, String>
  }
}
```

---

Previous section: [Global Compiler Flags](lf-condition-compilation-flags.md)

Next section: [Static Extension](lf-static-extension.md)