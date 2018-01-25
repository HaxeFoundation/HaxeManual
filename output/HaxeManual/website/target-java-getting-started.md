## 12.7.1 Getting started with Haxe/Java

To get started with Haxe/Java, create a new folder and save this class as `Main.hx`.

```haxe
class Main {
  static public function main():Void {
    trace("Hello World");
  }
}
```

To compile Haxe to Java we need two obvious prerequisites installed:

* [hxjava haxelib](http://lib.haxe.org/p/hxjava). This is the support library for the Java backend of the Haxe compiler.
* [JRE - Java Runtime Environment](https://java.com/download/).

Run the following from the command line:

```haxe
haxe -java bin -main Main
```

Another possibility is to create and run (double-click) a file called `compile.hxml`. In this example the hxml-file should be in the same directory as the example class.

```haxe
-java bin
-main Main
```

The compiler outputs in the given **bin**-folder, which contains the generated sources / .jar files which prints the traced message when you execute it. 

To execute, run the following command:

```haxe
java -jar bin/Main.jar
```

##### More information

* [Haxe/Java API docs](https://api.haxe.org/java/)
* [Java Platform Documentation](https://docs.oracle.com/javase/)

---

Previous section: [Java](target-java.md)

Next section: [C#](target-cs.md)