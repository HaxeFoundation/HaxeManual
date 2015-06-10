## 8.3.6 Position completion

##### since Haxe 3.2.0

Position completion is enabled by using the `"position"` mode argument (see [Overview](cr-completion-overview.md)). We demonstrate it using a field. Note that it would work with local variables and types the same way:

```haxe
class Main {
  static public function main() {
    "foo".split.|
}
```

If this file is saved to Main.hx, the completion can be invoked using the command `haxe --display Main.hx@0@position`. The output looks like this:

```haxe
<list>
<pos>std/string.hx:124: characters 1-54</pos>
</list>
```

> ##### Trivia: Effects of omitting a target specifier
>
> In this example the compiler reports the standard String.hx definition which does not actually have an implementation. This happens because we did not specify any target, which is allowed in completion-mode. If the command line arguments included, say, `-neko neko.n`, the reported position would instead be `std/neko/_std/string.hx:84: lines 84-98`.

---

Previous section: [Usage completion](cr-completion-usage.md)

Next section: [Top-level completion](cr-completion-top-level.md)