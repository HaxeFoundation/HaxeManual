## 12.4.1 Getting started with Haxe/PHP

To get started with Haxe/PHP, create a new folder and save this class as `Main.hx`.

```haxe
import php.Lib;

class Main {
  static function main() {
    Lib.println('Haxe is great!');
  }
}

```

To compile, either run the following from the command line:

```haxe
haxe -php bin -main Main
```

Another possibility is to create and run (double-click) a file called `compile.hxml`. In this example the hxml-file should be in the same directory as the example class.

```haxe
-php bin
-main Main
```

The compiler outputs in the given **bin**-folder, which contains the generated PHP classes that prints the traced message when you run it. The generated PHP-code runs for version 5.1.0 and later.

###### More information

* [Haxe PHP API docs](http://api.haxe.org/php/)
* [PHP.net Documentation](http://php.net/docs.php)
* [PHP to Haxe tool](http://phptohaxe.haqteam.com/code.php)

---

Previous section: [PHP](target-php.md)

Next section: [C++](target-cpp.md)