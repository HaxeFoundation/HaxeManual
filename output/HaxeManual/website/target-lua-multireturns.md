## 12.10.4 Multireturns

Lua allows for multiple values to be returned from a given function.  Haxe
does not support this by default, but can allow extern definitions to reference
multireturn values through the `@:multiReturn` metadata.

```haxe
class Main {
    static function main() {
        var strfind = NativeString.find("foobar", "bar");
        trace(strfind.begin);
        trace(strfind.end);
    }
}

@:native("string")
extern class NativeString {
	public static function find(str : String, target : String): StringFind;
}

@:multiReturn extern class StringFind {
	var begin : Int;
	var end : Int;
}
```

This example has three parts:

* The extern class `NativeString` which is an extern for the base `string` library in Lua.
* The `StringFind` class which is marked as `@:multiReturn` that describes the return values.
* The Main class that invokes the string method as a simple example.

The multireturn behavior in Haxe is optimized based on usage.  If fields are
only accessed directly, the Haxe compiler will allocate the multireturn to
individual variables.  But, if you pass or assign the entire multireturn value,
the compiler will wrap all values into a table object.  This operation ensures
that multireturn variable handling only carries as much overhead as needed.

---

Previous section: [Version flags](target-lua-flags.md)

Next section: [Debugging](debugging.md)