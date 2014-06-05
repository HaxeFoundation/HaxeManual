## 2.5.1 JSON for Structure Values

It is also possible to use **JavaScript Object Notation** for structures by using **string literals** for the keys:

```haxe
var point = { "x" : 1, "y" : -5 };
```
While any string literal is allowed, the field is only considered part of the type if it is a valid [Haxe identifier](dictionary.md#define-identifier). Otherwise, Haxe syntax does not allow expressing access to such a field, and [reflection](std-reflection.md) has to be employed through the use of `Reflect.field` and `Reflect.setField`.

---

Previous section: [Anonymous Structure](types-anonymous-structure.md)

Next section: [Class Notation for Structure Types](types-structure-class-notation.md)

Contribute: [fileAndLines](https://github.com/HaxeFoundation/HaxeManual/blob/master/02-types.tex#L447-447)