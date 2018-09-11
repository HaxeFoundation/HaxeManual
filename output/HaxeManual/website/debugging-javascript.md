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

---

Previous section: [Tracing Types](debugging-type-function.md)

Next section: [Source Maps](debugging-source-map.md)