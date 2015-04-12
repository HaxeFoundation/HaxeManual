## 10.3.5 Map

The `map` method of a regular expression object can be used to replace matched substrings using a custom function. This function takes a regular expression object as its first argument so we may use it to get additional information about the match being done and do conditional replacement. For example:

```haxe
class Main {
  static function main() {
    var r = ~/(dog|fox)/g;
    var s = "The quick brown fox jumped over the lazy dog.";
    var s2 = r.map(s, function(r) {
        var match = r.matched(0);
        switch (match) {
            case 'dog': return 'fox';
            case 'fox': return 'dog';
            default: throw 'Unknown animal: $match';
        };
    });
    trace(s2); // The quick brown dog jumped over the lazy fox.
  }
}
```

---

Previous section: [Split](std-regex-split.md)

Next section: [Implementation Details](std-regex-implementation-details.md)