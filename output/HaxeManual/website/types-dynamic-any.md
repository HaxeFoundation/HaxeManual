## 2.7.4 Any type

`Any` is a type that is compatible with any other in both ways. 
It serves one purpose - to hold values of any type, but to actually use that values, an explicit casting is required. That way the code doesn't suddently become dynamically typed and we keep all the static typing goodness, like advanced type system features and optimizations.

The implementation is quite simple:

```haxe
abstract Any(Dynamic) from Dynamic to Dynamic {}
```

This type don't make any assumptions about what the value actually is and whether it supports fields or any operations - this is up to the user.

```haxe
class Main {
  static function setAnyValue(value:Any) {
    trace(value);
  }

  static function getAnyValue():Any {
    return 42;
  }

  static function main() {
    // value of any type works
    setAnyValue("someValue");
    setAnyValue(42);
  
    var value = getAnyValue();
    $type(value); // Any, not Unknown<0>

    // won't compile: no dynamic field access
    // value.charCodeAt(0);

    if (Std.is(value, String)) {
      // explicit promotion, type-safe
      trace((value : String).charCodeAt(0));
    }
  }
}
```

It's a more type-safe alternative to `Dynamic`, because it doesn't support field access or operators and it's bound to monomorphs. So, to work with the actual value, it needs to be explicitly promoted to another type.

---

Previous section: [Dynamic access](types-dynamic-access.md)

Next section: [Abstract](types-abstract.md)