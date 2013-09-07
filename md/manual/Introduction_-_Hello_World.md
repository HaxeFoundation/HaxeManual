The following program prints "Hello World" after being compiled and run:

```
class HelloWorld {
	static public function main():Void {
		trace("Hello World");
	}
}
```
This can be tested by saving above code to a file named `HelloWorld.hx` and invoking the haxe compiler like so: `haxe -main HelloWorld --interp`. This outputs `HelloWorld.hx:3: Hello world`. There are several things to learn from this:



* Haxe programs are saved in files with an extension of `.hx`.
* The haxe compiler is a command-line tool which can be invoked with parameters such as `-main HelloWorld` and `--interp`.
* Haxe programs have classes (`HelloWorld`, upper-case), which have functions (`main`, lower-case).