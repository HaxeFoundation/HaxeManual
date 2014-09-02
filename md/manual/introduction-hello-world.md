## 1.3 Hello World

The following program prints "Hello World" after being compiled and run:

```haxe
class HelloWorld {
  static public function main():Void {
    trace("Hello World");
  }
}
```
This can be tested by saving the above code to a file named `HelloWorld.hx` and invoking the Haxe Compiler like so: `haxe -main HelloWorld --interp`. It then generates the following output: `HelloWorld.hx:3: Hello world`. There are several things to learn from this:

* Haxe programs are saved in files with an extension of `.hx`.
* The Haxe Compiler is a command-line tool which can be invoked with parameters such as `-main HelloWorld` and `--interp`.
* Haxe programs have classes (`HelloWorld`, upper-case), which have functions (`main`, lower-case).

---

Previous section: [Authors and contributions](introduction-authors-and-contributions.md)

Next section: [History](introduction-haxe-history.md)