## 6.12 Logging and Trace

Haxe provides developers with a powerful trace system. Simply call `trace` within functions:

```haxe
trace("Hello world!");
```

In most Haxe targets trace will be printed to stdout. JavaScript uses `console.log`. Each trace is displayed with the filename and line number information where the trace occurred:

```haxe
Test.hx:11: Hello world!
```

To trace without the default position information `haxe.Log.trace (msg, null)` can be used.

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

##### Extra Position Parameter

[haxe.PosInfos](http://api.haxe.org/haxe/PosInfos.html) is a magic type which can be used to generate position information into the output for debugging use.
If a function has a final optional argument of this type, i.e. `(..., ?pos:haxe.PosInfos)`, each call to that function which does not assign a value to that argument has its position added as call argument. 

It is sometimes useful to define a custom method that does some traces in some case. The following usage is possible since in Haxe when the `haxe.PosInfos` optional parameter is not set, its default value will always be replaced by the compiler:

```haxe
class Main {
  static function assert(cond:Bool, ?pos:haxe.PosInfos) {
    if (!cond)
      haxe.Log.trace("Assert in "+pos.className+"::"+pos.methodName,pos);
  }

  static function main() {
    assert( 1 == 1 ); // nothing
    assert( 0 == 3 ); // trace "Assert in Test::main"
  }
}

```

##### Tracing types

`$type` is a **compile-time** mechanism being called like a function, with a single argument. The compiler evaluates the argument expression and then outputs the type of that expression.

```haxe
var myValue = "foo";
$type(myValue); // String
```

---

Previous section: [Inline constructors](lf-inline-constructor.md)

Next section: [Compiler Usage](compiler-usage.md)