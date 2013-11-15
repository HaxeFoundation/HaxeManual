## 2.5.2 Class Notation for Structure Types

When defining a structure type, haxe allows using the same syntax as described in [Class Fields](class_fields.md). The following [typedef](typedef.md) declares a `Point` type with variable fields `x` and `y` of type `Int`:

```haxe
typedef Point = {
    var x : Int;
    var y : Int;
}
```

---

Previous section: [JSON-Notation for Structure Values](json-notation_for_structure_values.md)

Next section: [Optional Fields](optional_fields.md)