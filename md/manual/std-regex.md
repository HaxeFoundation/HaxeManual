## 10.3 Regular Expressions

Haxe has built-in support for **regular expressions**. They can be used to verify the format of a string, transform a string or extract some regular data from a given text.

Haxe has special syntax for creating regular expressions. We can create a regular expression object by typing it between the `~/` combination and a single `/` character:

```haxe
var r = ~/haxe/i;
```

Alternatively, we can create regular expression with regular syntax:

```haxe
var r = new EReg("haxe", "i");
```

First argument is a string with regular expression pattern, second one is a string with **flags** (see below).

We can use standard regular expression patterns such as:


    * `.` any character
    * `*` repeat zero-or-more
    * `+` repeat one-or-more
    * `?` optional zero-or-one
    * `[A-Z0-9]` character ranges
    * `[^\\ r\\ n\\ t]` character not-in-range
    * `(...)` parenthesis to match groups of characters
    * `^` beginning of the string (beginning of a line in multiline matching mode)
    * `$` end of the string (end of a line in multiline matching mode)
    * `|` "OR" statement.



For example, the following regular expression match a valid email address:
```haxe
~/[A-Z0-9._%-]+@[A-Z0-9.-]+.[A-Z][A-Z][A-Z]?/i;
```

Please notice that the `i` at the end of the regular expression is a **flag** that enable case-insensitive matching.

The possible flags are the following:


    * `i` case insensitive matching
    * `g` global replace or split, see below
    * `m` multiline matching, `^` and `$` represent the beginning and end of a line
    * `s` the dot `.` will match also newlines **(Neko, C++, PHP and Java targets only)**
    * `u` use UTF-8 matching **(Neko and C++ targets only)**

---

Previous section: [Map](std-Map.md)

Next section: [Matching](std-regex-match.md)