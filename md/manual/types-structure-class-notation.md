## 2.5.2 Class Notation for Structure Types

When defining a structure type, haxe allows using the same syntax as described in [Class Fields](class-field.md). The following [typedef](type-systemtypedef.md) declares a `Point` type with variable fields `x` and `y` of type `Int`:

```haxe
typedef Point = {
    var x : Int;
    var y : Int;
}
```

---

Previous section: [JSON-Notation for Structure Values](types-structure-json-notation.md)

Next section: [Optional Fields](types-structure-optional-fields.md)