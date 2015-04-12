## 8.3.2 Field access completion

Field completion is triggered after a dot `.` character to list the fields that are available on the given type. The compiler parses and types everything up to the point of completion and then outputs the relevant information to stderr:

```haxe
class Main {
  public static function main() {
    trace("Hello".|
  }
}
```

If this file is saved to Main.hx, the completion can be invoked using the command `haxe --display Main.hx@0`. The output looks similar to this (we omit several fields for brevity and improve the formatting for readability):

```haxe
<list>
<i n="length">
  <t>Int</t>
  <d>
    The number of characters in `this` String.
  </d>
</i>
<i n="charAt">
  <t>index : Int -&gt; String</t>
  <d>
    Returns the character at position `index` of `this` String.
    If `index` is negative or exceeds `this.length`, the empty String
    "" is returned.
  </d>
</i>
<i n="charCodeAt">
  <t>index : Int -&gt; Null&lt;Int&gt;</t>
  <d>
    Returns the character code at position `index` of `this` String.
    If `index` is negative or exceeds `this.length`, null is returned.
    To obtain the character code of a single character, "x".code can
    be used instead to inline the character code at compile time.
    Note that this only works on String literals of length 1.
  </d>
</i>
</list>
```

The XML structure follows:

* The document node `list` encloses several nodes `i`, each representing a field.
* The `n` attribute contains the name of the field.
* The `t` node contains the type of the field.
* the `d` node contains the documentation of the field.

##### since Haxe 3.2.0

When compiling with `-D display-details`, each field additionally has a `k` attribute which can either be `var` or `method`. This allows distinguishing method fields from variable fields that have a function type.

---

Previous section: [Overview](cr-completion-overview.md)

Next section: [Call argument completion](cr-completion-call-argument.md)