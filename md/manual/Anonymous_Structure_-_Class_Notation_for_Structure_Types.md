When defining a structure type, haxe allows using the same syntax as described in [[manual/Class_Fields]]. The following [[manual/Typedef]] declares a `Point` type with variable fields `x` and `y` of type `Int`:

```
typedef Point = {
    var x : Int;
    var y : Int;
}
```