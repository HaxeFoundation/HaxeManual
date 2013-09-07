It is also possible to use **JSON**-notation for structures by using **string literals** for the keys:

```
var point = { "x" : 1, "y" : -5 };
```
While any string literal is allowed, the field is only considered part of the type if it is a valid haxe identifier. Otherwise, haxe syntax does not allow expressing access to such a field, and [manual/Reflection] has to be employed through the use of `Reflect.field` and `Reflect.setField`.