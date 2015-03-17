## 11.1 Using a Haxe library with the Haxe Compiler

Any installed Haxe library can be made available to the compiler through the `-lib <library-name>` argument. This is very similiar to the `-cp <path>` argument, but expects a library name instead of a directory path. These commands are explained thoroughly in [Compiler Usage](compiler-usage.md).

For our exemplary usage we chose a very simple Haxe library called "random". It provides a set of static convenience methods to achieve various random effects, such as picking a random element from an array.

```haxe
class Main {
  static public function main() {
    var elt = Random.fromArray([1, 2, 3]);
    trace(elt);
  }
}
```

Compiling this without any `-lib` argument causes an error message along the lines of `Unknown identifier : Random`. This shows that installed Haxe libraries are not available to the compiler by default unless they are explicitly added. A working command line for above program is `haxe -lib random -main Main --interp`.

If the compiler emits an error `Error: Library random is not installed : run 'haxelib install random'` the library has to be installed via the `haxelib` command first. As the error message suggests, this is achieved through `haxelib install random`. We will learn more about the `haxelib` command in [Using Haxelib](haxelib-using.md).

---

Previous section: [Haxelib](haxelib.md)

Next section: [haxelib.json](haxelib-json.md)