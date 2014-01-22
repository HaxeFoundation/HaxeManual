## 10.3.2 Groups

Specific information can be extracted from a matched string by using **groups**. If `match()` returns true, we can get groups using the `matched(X)` method, where X is the number of a group defined by regular expression pattern:

```haxe
class Main {
    static function main() {
        var str = "Nicolas is 26 years old";
        var r = ~/([A-Za-z]+) is ([0-9]+) years old/;
        r.match(str);
        trace(r.matched(1)); // "Nicolas"
        trace(r.matched(2)); // "26"
    }
}

```

Note that group numbers start with 1 and `r.matched(0)` will always return the whole matched substring.

The `r.matchedPos()` will return the position of this substring in the original string:

```haxe
class Main {
    static function main() {
        var str = "abcdeeeeefghi";
        var r = ~/e+/;
        r.match(str);
        trace(r.matched(0)); // "eeeee"
        trace(r.matchedPos()); // { pos : 4, len : 5 }
    }
}

```

Additionally, `r.matchedLeft()` and `r.matchedRight()` can be used to get substrings to the left and to the right of the matched substring:

```haxe
class Main {
    static function main() {
        var r = ~/b/;
        r.match("abc");
        trace(r.matchedLeft()); // a
        trace(r.matched(0)); // b
        trace(r.matchedRight()); // c
    }
}

```

---

Previous section: [Matching](std-regex-match.md)

Next section: [Replace](std-regex-replace.md)