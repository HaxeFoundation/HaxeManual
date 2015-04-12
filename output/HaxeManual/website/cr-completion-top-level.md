## 8.3.7 Top-level completion

Top-level completion displays all identifiers which the Haxe Compiler knows about at a given compilation position. This is the only completion method for which we need a real position argument in order to demonstrate its effect:

```haxe
class Main {
  static public function main() {
    var a = 1;
  }
}

enum MyEnum {
  MyConstructor1;
  MyConstructor2(s:String);
}
```

If this file is saved to Main.hx, the completion can be invoked using the command `haxe --display Main.hx@63@toplevel`. The output looks similar to this (we omit several entries for brevity):

```haxe
<il>
<i k="local" t="Int">a</i>
<i k="static" t="Void -&gt; Unknown&lt;0&gt;">main</i>
<i k="enum" t="MyEnum">MyConstructor1</i>
<i k="enum" t="s : String -&gt; MyEnum">MyConstructor2</i>
<i k="package">sys</i>
<i k="package">haxe</i>
<i k="type" p="Int">Int</i>
<i k="type" p="Float">Float</i>
<i k="type" p="MyEnum">MyEnum</i>
<i k="type" p="Main">Main</i>
</il>
```

The structure of the XML depends on the `k` attribute of each entry. In all cases the node value of the `i` nodes contains the relevant name.

* `local`, `member`, `static`, `enum`, `global`: The `t` attribute holds the type of the variable or field.
* `global`, `type`: The `p` attribute holds the path of the module which contains the type or field.

---

Previous section: [Position completion](cr-completion-position.md)

Next section: [Completion server](cr-completion-server.md)