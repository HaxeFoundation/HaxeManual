## 2.7.3 Dynamic access

`DynamicAccess` is an [abstract type](types-abstract.md) for working with [anonymous structures](types-anonymous-structure.md) that are intended to hold collections of objects by the string key. Basically `DynamicAccess` wraps `Reflect`std-reflection calls in a Map-like interface.

```haxe
class Main {
  static public function main() {
    var user:DynamicAccess<Dynamic> = {};

    // Sets values for specified keys.
    user.set("name", "Mark");
    user.set("age", 25);

    // Returns values by specified keys.
    trace(user.get("name")); // "Mark"
    trace(user.get("age")); // 25

    // Tells if the structure contains a specified key
    trace(user.exists("name")); // true
  }
}
```

```haxe
```

---

Previous section: [Implementing Dynamic](types-dynamic-implemented.md)

Next section: [Any type](types-dynamic-any.md)