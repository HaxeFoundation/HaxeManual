## 2.7.1 Dynamic with Type Parameter

`Dynamic` is a special type because it allows explicit declaration with and without a [type parameter](type-system-type-parameters.md). If such a type parameter is provided, the semantics described in [Dynamic](types-dynamic.md) are constrained to all fields being compatible with the parameter type:

```haxe
var att : Dynamic<String> = xml.attributes;
att.name = "Nicolas"; // valid, value is a String
att.age = "26"; // dito (this documentation is quite old)
att.income = 0; // error, value is not a String
```

---

Previous section: [Dynamic](types-dynamic.md)

Next section: [Implementing Dynamic](types-dynamic-implemented.md)