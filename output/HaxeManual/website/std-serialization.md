## 10.8 Serialization

Many runtime values can be serialized and deserialized using the [haxe.Serializer](http://api.haxe.org/haxe/Serializer.html) and [haxe.Unserializer](http://api.haxe.org/haxe/Unserializer.html) classes. Both support two usages:

1. Create an instance and continuously call the `serialize`/`unserialize` method to handle multiple values.
2. Call their static `run` method to serialize/deserialize a single value.

The following example demonstrates the first usage:

```haxe
import haxe.Serializer;
import haxe.Unserializer;

class Main {
  static function main() {
    var serializer = new Serializer();
    serializer.serialize("foo");
    serializer.serialize(12);
    var s = serializer.toString();
    trace(s); // y3:fooi12

    var unserializer = new Unserializer(s);
    trace(unserializer.unserialize()); // foo
    trace(unserializer.unserialize()); // 12
  }
}
```

The result of the serialization (here stored in local variable `s`) is a [String](std-String.md) and can be passed around at will, even remotely. Its format is described in [Serialization format](std-serialization-format.md).

##### Supported values

* `null`
* `Bool`, `Int` and `Float` (including infinities and `NaN`)
* `String`
* `Date`
* `haxe.io.Bytes` (encoded as base64)
* [`Array`](std-Array.md) and [`List`](std-List.md)
* `haxe.ds.StringMap`, `haxe.ds.IntMap` and `haxe.ds.ObjectMap`
* [anonymous structures](types-anonymous-structure.md)
* Haxe [class instances](types-class-instance.md) (not native ones)
* [enum instances](types-enum-instance.md)

##### Serialization configuration

Serialization can be configured in two ways. For both a static variable can be set to influence all [haxe.Serializer](http://api.haxe.org/haxe/Serializer.html) instances, and a member variable can be set to only influence a specific instance:

* `USE_CACHE`, `useCache`: If true, repeated structures or class/ enum instances are serialized by reference. This can avoid infinite loops for recursive data at the expense of longer serialization time. By default, object caching is disabled; strings however are always cached.
* `USE_ENUM_INDEX`, `useEnumIndex`: If true, enum constructors are serialized by their index instead of their name. This can make the resulting string shorter, but breaks if enum constructors are inserted into the type before deserialization. This behavior is disabled by default.

##### Deserialization behavior

If the serialization result is stored and later used for deserialization, care has to be taken to maintain compatibility when working with class and enum instances. It is then important to understand exactly how unserialization is implemented.

* The type has to be available in the runtime where the deserialization is made. If [dead code elimination](cr-dce.md) is active, a type which is used only through serialization might be removed.
* Each `Unserializer` has a member variable `resolver` which is used to resolve classes and enums by name. Upon creation of the `Unserializer` this is set to `Unserializer.DEFAULT_RESOLVER`. Both that and the instance member can be set to a custom resolver.
* Classes are resolved by name using `resolver.resolveClass(name)`. The instance is then created using `Type.createEmptyInstance`, which means that the class constructor is not called. Finally, the instance fields are set according to the serialized value.
* Enums are resolved by name using `resolver.resolveEnum(name)`. The enum instance is then created using `Type.createEnum`, using the serialized argument values if available. If the constructor arguments were changed since serialization, the result is unspecified.

##### Custom (de)serialization

If a class defines the member method `hxSerialize`, that method is called by the serializer and allows custom serialization of the class. Likewise, if a class defines the member method `hxUnserialize` it is called by the deserializer:

```haxe
import haxe.Serializer;
import haxe.Unserializer;

class Main {

  var x:Int;
  var y:Int;

  static function main() {
    var s = Serializer.run(new Main(1, 2));
    var c:Main = Unserializer.run(s);
    trace(c.x); // 1
    trace(c.y); // -1
  }

  function new(x, y) {
    this.x = x;
    this.y = y;
  }

  @:keep
  function hxSerialize(s:Serializer) {
    s.serialize(x);
  }

  @:keep
  function hxUnserialize(u:Unserializer) {
    x = u.unserialize();
    y = -1;
  }
}
```

In this example we decide that we want to ignore the value of member variable `y` and do not serialize it. Instead we default it to `-1` in `hxUnserialize`. Both methods are annotated with the `@:keep` metadata to prevent [dead code elimination](cr-dce.md) from removing them as they are never properly referenced in the code.

See [Serializer](http://api.haxe.org/haxe/Serializer.html) and [Unserializer](http://api.haxe.org/haxe/Unserializer.html) API documentation for details.

---

Previous section: [Reflection](std-reflection.md)

Next section: [Serialization format](std-serialization-format.md)