<!--label:debugging-->
## Debugging

<!--subtoc-->

<!--label:debugging-trace-log-->
### Logging and Trace

Haxe provides developers with a powerful logging/trace system. Simply call `trace` within functions:

```haxe
trace("Hello world!");
```

In most Haxe targets trace will be printed to stdout. JavaScript uses `console.log`. Each trace is displayed with the filename and line number information where the trace occurred:

```
Test.hx:11: Hello world!
```

To trace without the default position information `haxe.Log.trace(msg, null)` can be used.

##### Custom trace

The trace can have a custom output by changing the `Log.trace` method where all trace calls are redirected. 

[code asset](assets/CustomTrace.hx)

The `v` argument is the first parameter of the trace call. It can be a `String` or any other value. The optional `infos` argument contains extra position parameter, see below.

The `infos.customParams` array contains all extra arguments that were given to the original trace. If no extra parameters are passed, it will be `null`. 

As illustration, the previous example will be compiled as if it was calling the following:

```js
haxe.Log.trace("hello", {
	fileName : "Test.hx", 
	lineNumber : 6, 
	className : "Test", 
	methodName : "main", 
	customParams : ["warning",123]
});
```

##### Removing traces

You can simply remove all trace informations by compiling your project with `--no-traces` argument. This will remove all trace calls as if they were not present in the program.



<!--label:debugging-posinfos-->
### Position Information Parameter

[`haxe.PosInfos`](http://api.haxe.org/haxe/PosInfos.html) is a magic type which can be used to generate position information into the output for debugging use.
If a function has a final optional argument of this type, i.e. `(..., ?pos:haxe.PosInfos)`, each call to that function which does not assign a value to that argument has its position added as call argument. 

It is sometimes useful to define a custom method that does some traces in some case. The following usage is possible since in Haxe when the `haxe.PosInfos` optional parameter is not set, its default value will always be replaced by the compiler:

[code asset](assets/AssertTrace.hx)



<!--label:debugging-type-function-->
### Tracing Types

`$type` is a **compile-time** mechanism being called like a function, with a single argument. The compiler evaluates the argument expression and then outputs the type of that expression.

This is useful to evaluate if an expression has a certain type, mostly when dealing with [Type inference](type-system-type-inference), which leaves the definition of the type up to the compiler.

```haxe
var myValue = "foo";
$type(myValue); // String
```



<!--label:debugging-ide-integration-->
### IDE Integration

Haxe is supported in a [number of editors and IDEs](https://haxe.org/documentation/introduction/editors-and-ides.html). Some IDEs, such as Visual Studio Code (with the vshaxe extension), support debugging of Haxe code with breakpoints, stack tracing, etc. More information is available on the [vshaxe wiki](https://github.com/vshaxe/vshaxe/wiki/Debugging).



<!--label:debugging-javascript-->
### Debugging in JavaScript

##### Console

Beside [trace](debugging-trace-log) Haxe exposes most of the browsers console functions, which can be accessed using [`js.Browser.console`](http://api.haxe.org/v/dev/js/html/Console.html):

```haxe
js.Browser.console.log("Hello world"); 
js.Browser.console.info("Haxe is great!"); 
js.Browser.console.warn("Something could be wrong"); 
js.Browser.console.error("Something went wrong"); 
```

* More info about the [browser console functions](https://developer.mozilla.org/en-US/docs/Web/API/Console).

##### Breakpoints

In most browser developer tools breakpoints can be set to pause the code execution and start debugging. This mostly can be done by clicking near the line numbers. At each breakpoint JavaScript will stop executing and let the current values be inspected. After examining the values, the execution of code can be resumed (typically with a play button).

In JavaScript a developer can use the `debugger` statement functionality to do the same from code.
In Haxe the same can be done with [`js.Lib.debug()`](https://api.haxe.org/js/Lib.html#debug) function; this inserts a `debugger` statement that will make a breakpoint if a debugger is available. If no debugging functionality is available, this statement has no effect. 

* Read more on the [debugger statement](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Statements/debugger).



<!--label:debugging-source-map-->
### Source Maps

Haxe is able to generate source maps, allowing debuggers to map from generated source back to the original Haxe source. This makes reading error stack traces, debugging with breakpoints, and profiling much easier.

When an error occurs, the developer is helped out by showing them where the error occurred in the original Haxe source file. This saves the developer time every single time they hit an error. The web console log messages also include links to the line that generated the log message, so these messages could link back to the original source lines as well. 

Compiling with the `-debug` flag will create a source map (.map) alongside the .js file. Source maps can also be generated for release builds with `-D js-source-map`.

<!--label:debugging-source-map-javascript-->
#### Source Maps in JavaScript

In the generated JavaScript the last line will have a reference to the source map that looks like this:

```haxe
//# sourceMappingURL=Main.js.map
```

To include the hx sources as part of the JS source map, compile with `-D source-map-content`.

Make sure to enable 'JS source maps' in the browser developer tool settings. 

* [Chrome source-maps](https://developers.google.com/web/tools/chrome-devtools/debug/readability/source-maps)
* [Firefox source-maps](https://developer.mozilla.org/en-US/docs/Tools/Debugger/How_to/Use_a_source_map)
* [Safari source-maps](https://developer.apple.com/library/safari/documentation/AppleApplications/Conceptual/Safari_Developer_Guide/ResourcesandtheDOM/ResourcesandtheDOM.html#//apple_ref/doc/uid/TP40007874-CH3-SW2)



<!--label:debugging-sourcemap-php7-->
#### Source Maps in Php7

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
-L jstack
```

The output will have more informative stack trace for exceptions:

```
$ php build/index.php
Terrible error
Called from Main.terribleError (src/Main.hx line 7)
Called from Main.main (src/Main.hx line 3)
Called from build/index.php line 13
```




