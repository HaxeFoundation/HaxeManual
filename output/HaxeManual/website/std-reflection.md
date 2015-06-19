## 10.7 Reflection

Haxe supports runtime reflection of types and fields. Special care has to be taken here because runtime representation generally varies between targets. In order to use reflection correctly it is necessary to understand what kind of operations are supported and what is not. Given the dynamic nature of reflection, this can not always be determined at compile-time.

The reflection API consists of two classes:

* Reflect: A lightweight API which work best on [anonymous structures](types-anonymous-structure.md), with limited support for [classes](types-class-instance.md). 
* Type: A more robust API for working with classes and [enums](types-enum-instance.md).

The available methods are detailed in the API for [Reflect](http://api.haxe.org/Reflect.html) and [Type](http://api.haxe.org/Type.html).

Reflection can be a powerful tool, but it is important to understand why it can also cause problems. As an example, several functions expect a [String](std-String.md) argument and try to resolve it to a type or field. This is vulnerable to typing errors:

```haxe
class Main {
  static function main() {
    trace(Type.resolveClass("Mian")); // null
  }
}
```

However, even if there are no typing errors it is easy to come across unexpected behavior:

```haxe
class Main {
  static function main() {
    // null
    trace(Type.resolveClass("haxe.Template"));
  }
}
```

The problem here is that the compiler never actually "sees" the type `haxe.Template`, so it does not compile it into the output. Furthermore, even if it were to see the type there could be issues arising from [dead code elimitation](cr-dce.md) eliminating types or fields which are only used via reflection.

Another set of problems comes from the fact that, by design, several reflection functions expect arguments of type [Dynamic](types-dynamic.md), meaning the compiler cannot check if the passed in arguments are correct. The following example demonstrates a common mistake when working with `callMethod`:

```haxe
class Main {
  static function main() {
    // wrong
    //Reflect.callMethod(Main, "f", []);
    // right
    Reflect.callMethod(Main,
      Reflect.field(Main, "f"), []);
  }

  static function f() {
    trace('Called');
  }
}
```

The commented out call would be accepted by the compiler because it assigns the string `"f"` to the function argument `func` which is specified to be `Dynamic`.

A good advice when working with reflection is to wrap it in a few functions within an application or API which are called by otherwise type-safe code. An example could look like this:

```haxe
typedef MyStructure = {
  name: String,
  score: Int
}

class Main {
  static function main() {
    var data = reflective();
    // At this point data is nicely typed as MyStructure
  }

  static function reflective():MyStructure {
    // Work with reflection here to get some values we want to return.
    return {
      name: "Reflection",
      score: 0
    }
  }
}

```

While the method `reflective` could interally work with reflection (and `Dynamic` for that matter) a lot, its return value is a typed structure which the callers can use in a type-safe manner.

---

Previous section: [Template](std-template.md)

Next section: [Serialization](std-serialization.md)