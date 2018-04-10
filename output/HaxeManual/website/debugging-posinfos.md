## 13.2 Position Information Parameter

[`haxe.PosInfos`](http://api.haxe.org/haxe/PosInfos.html) is a magic type which can be used to generate position information into the output for debugging use.
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

---

Previous section: [Logging and Trace](debugging-trace-log.md)

Next section: [Tracing types](debugging-type-function.md)