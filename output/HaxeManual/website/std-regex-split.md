## 10.3.4 Split

A regular expression can also be used to split a string into several substrings:

```haxe
class Main {
  static function main() {
    var str = "XaaaYababZbbbW";
    var r = ~/[ab]+/g;
    // ["X","Y","Z","W"]
    trace(r.split(str));
  }
}

```

---

Previous section: [Replace](std-regex-replace.md)

Next section: [Map](std-regex-map.md)