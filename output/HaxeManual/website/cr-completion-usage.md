## 8.3.5 Usage completion

##### since Haxe 3.2.0

Usage completion is enabled by using the `"usage"` mode argument (see [Overview](cr-completion-overview.md)). We demonstrate it here using a local variable. Note that it would work with fields and types the same way:

```haxe
class Main {
  public static function main() {
    var a = 1;
    var b = a + 1;
    trace(a);
    a.|
  }
}
```

If this file is saved to Main.hx, the completion can be invoked using the command `haxe --display Main.hx@0@usage`. The output looks like this:

```haxe
<list>
<pos>main.hx:4: characters 9-10</pos>
<pos>main.hx:5: characters 7-8</pos>
<pos>main.hx:6: characters 1-2</pos>
</list>
```

---

Previous section: [Type path completion](cr-completion-type-path.md)

Next section: [Position completion](cr-completion-position.md)