## 10.3.3 Replace

A regular expression can also be used to replace a part of the string:

```haxe
class Main {
    static function main() {
        var str = "aaabcbcbcbz";
        var r = ~/b[^c]/g; // g : replace all instances
        trace(r.replace(str,"xx")); // "aaabcbcbcxx"
    }
}

```

We can use `$X` to reuse a matched group in the replacement:

```haxe
class Main {
    static function main() {
        var str = "{hello} {0} {again}";
        var r = ~/{([a-z]+)}/g;
        trace(r.replace(str,"*$1*")); // "*hello* {0} *again*"
    }
}

```

---

Previous section: [Groups](std-regex-groups.md)

Next section: [Split](std-regex-split.md)