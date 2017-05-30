## 13.1 Logging and Trace

Haxe provides developers with a powerful logging/trace system. Simply call `trace` within functions:

```haxe
trace("Hello world!");
```

In most Haxe targets trace will be printed to stdout. JavaScript uses `console.log`. Each trace is displayed with the filename and line number information where the trace occurred:

```haxe
Test.hx:11: Hello world!
```

To trace without the default position information `haxe.Log.trace(msg, null)` can be used.

##### Custom trace

The trace can have a custom output by changing the `Log.trace` method where all trace calls are redirected. 

```haxe
class Main {
  static function main() {
    haxe.Log.trace = function(v:Dynamic, ?infos:haxe.PosInfos) { 
      //custom trace function here
    }
    trace("hello","warning",123);
  }
}

```

The `v` argument is the first parameter of the trace call. It can be a `String` or any other value. The optional `infos` argument contains extra position parameter, see below.

The `infos.customParams` array contains all extra arguments that were given to the original trace. If no extra parameters are passed, it will be `null`. 

As illustration, the previous example will be compiled as if it was calling the following:

```haxe
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

---

Previous section: [Debugging](debugging.md)

Next section: [Position Information Parameter](debugging-posinfos.md)