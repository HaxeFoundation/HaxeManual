## 10.8.2 Encoding JSON

Use the `haxe.Json.stringify` static method to encode a Haxe value into a **JSON** string:
```haxe
class Main {
    static function main() {
        var o = {rating: 5};
        var s = haxe.Json.stringify(o);
        trace(s); // {"rating":5}
    }
}

```

---

Previous section: [Parsing JSON](std-Json-parsing.md)

Next section: [Implementation details](std-Json-implementation-details.md)