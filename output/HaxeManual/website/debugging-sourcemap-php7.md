## 13.5.2 Source Maps in Php7

Haxe source code positions in call stack and exception stack.

Since 3.4.1 Haxe can generate source maps for PHP target when compiling with `-D php7` and `-D source_map` flags.
Those source maps can be utilized by [JStack](https://lib.haxe.org/p/jstack/) library to automatically transform `haxe.CallStack.callStack()`, `haxe.CallStack.exceptionStack()` and uncaught exceptions to make them point at Haxe sources instead of generated PHP files.

```haxe
class Main {
	static function main() {
		terribleError();
	}

	static function terribleError() {
		throw "Terrible error";
	}
}
```

Building it with flags:

```hxml
-main Main
-D php7
-php build
-debug
```

Running this build will trace the uncaught exception:

```
$ php build/index.php
PHP Fatal error:  Uncaught php/_Boot/HxException: Terrible error in build/lib/Main.php:25
Stack trace:
#0 build/lib/Main.php(16): Main::terribleError()
#1 build/index.php(13): Main::main()
#2 {main}
  thrown in build/lib/Main.php on line 25
```

Install JStack using `haxelib install jstack`. JStack automatically adds `-D source_map` there is no need to add it manually.
Now if JStack is installed, add it to the compilation:

```hxml
-main Main
-D php7
-php build
-debug
-lib jstack
```

The output will have more informative stack trace for exceptions:

```
$ php build/index.php
Terrible error
Called from Main.terribleError (src/Main.hx line 7)
Called from Main.main (src/Main.hx line 3)
Called from build/index.php line 13
```

---

Previous section: [Source Maps in JavaScript](debugging-source-map-javascript.md)