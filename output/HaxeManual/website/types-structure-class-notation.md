## 2.5.2 Class Notation for Structure Types

When defining a structure type, Haxe allows using the same syntax as described in [Class Fields](class-field.md). The following [typedef](type-system-typedef.md) declares a `Point` type with variable fields `x` and `y` of type `Int`:

```haxe
typedef Point = {
    var x : Int;
    var y : Int;
}
```

---

Previous section: [JSON for Structure Values](types-structure-json.md)

Next section: [Optional Fields](types-structure-optional-fields.md)