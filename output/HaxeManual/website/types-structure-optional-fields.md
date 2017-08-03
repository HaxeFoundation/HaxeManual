## 2.5.3 Optional Fields

Fields of a structure type can be made optional. In the standard notation, this is achieved by prefixing the field name with a `?`:

```haxe
typedef User = {
  age : Int,
  name : String,
  ?phoneNumber : String
}
```

In class notation, the `@:optional` metadata can be used instead:

```haxe
typedef User = {
  var age : Int;
  var name : String;
  @:optional var phoneNumber : String;
}
```

---

Previous section: [Class Notation for Structure Types](types-structure-class-notation.md)

Next section: [Impact on Performance](types-structure-performance.md)