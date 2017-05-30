## 13.4 Debugging in JavaScript

##### Console

Beside [trace](debugging-trace-log.md) Haxe exposes most of the browsers console functions, which can be accessed using [`js.Browser.console`](http://api.haxe.org/v/dev/js/html/Console.html):

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
In Haxe the same can be done with [`js.Lib.debug`](http://api.haxe.org/v/js/Lib.html#debug) function; this inserts a `debugger` statement that will make a breakpoint if a debugger is available. If no debugging functionality is available, this statement has no effect. 

* Read more on the [debugger statement](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Statements/debugger).

##### Source Maps

Haxe is able to generate source maps, allowing JS debuggers to map from generated JS back to the original Haxe source. This makes reading error stack traces, debugging with breakpoints, and profiling much easier.

When JavaScript gets an error, the developer is helped out by showing them where the error occurred in the original Haxe source file. This saves the developer time every single time they hit an error. The web console log messages also include links to the line that generated the log message, so these messages could link back to the original source lines as well. 

Compiling with the `-debug` flag will create a source map (.map) alongside the .js file. 
This file is pure for debugging purposes. In the generated JavaScript the last line will have a reference to the source-map that looks like this:

```haxe
//# sourceMappingURL=Main.js.map
```

Make sure to enable 'JS source maps' in the browser developer tool settings. 

* [Chrome source-maps](https://developers.google.com/web/tools/chrome-devtools/debug/readability/source-maps)
* [Firefox source-maps](https://developer.mozilla.org/en-US/docs/Tools/Debugger/How_to/Use_a_source_map)
* [Safari source-maps](https://developer.apple.com/library/safari/documentation/AppleApplications/Conceptual/Safari_Developer_Guide/ResourcesandtheDOM/ResourcesandtheDOM.html#//apple_ref/doc/uid/TP40007874-CH3-SW2)

---

Previous section: [Tracing types](debugging-type-function.md)