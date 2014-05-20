## 10.3.1 Matching

Probably one of the most common uses for regular expressions is checking whether a string matches the specific pattern. The `match` method of a regular expression object can be used to do that:
```haxe
class Main {
    static function main() {
        var r = ~/world/;
        var str = "hello world";
        trace(r.match(str)); // true : 'world' was found in the string
        trace(r.match("hello !")); // false
    }
}

```

---

Previous section: [Regular Expressions](std-regex.md)

Next section: [Groups](std-regex-groups.md)