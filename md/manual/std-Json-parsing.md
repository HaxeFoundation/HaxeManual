## 10.8.1 Parsing JSON

Use the `haxe.Json.parse` static method to parse **JSON** data and obtain a Haxe value from it:
```haxe
class Main {
    static function main() {
        var s = '{"rating": 5}';
        var o = haxe.Json.parse(s);
        trace(o); // { rating: 5 }
    }
}

```

Note that the type of the object returned by `haxe.Json.parse` is `Dynamic`, so if the structure of our data is well-known, we may want to specify a type using [anonymous structures](types-anonymous-structure.md). This way we provide compile-time checks for accessing our data and most likely more optimal code generation, because compiler knows about types in a structure:
```haxe
typedef MyData = {
    var name:String;
    var tags:Array<String>;
}

class Main {
    static function main() {
        var s = '{"name": "Haxe", "tags": ["awesome"]}';
        var o:MyData = haxe.Json.parse(s);
        trace(o.name); // Haxe (a string)
        trace(o.tags[0]); // awesome (a string in an array)
    }
}

```

---

Previous section: [Json](std-Json.md)

Next section: [Encoding JSON](std-Json-encoding.md)