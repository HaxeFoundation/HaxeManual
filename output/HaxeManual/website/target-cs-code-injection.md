## 12.8.5 Injecting raw C# code

##### Expression injection

In some cases it may be needed to inject raw C# code into Haxe-generated code. This is possible by using  `untyped __cs__` call, for example:

```haxe
public function isBool(v:Dynamic):Bool {
    return untyped __cs__("v is bool");
}
```
The  `untyped __cs__` syntax also supports code interpolation which means that you can insert Haxe expressions into injected C# code. For example, the example above could have been made inline, but because it always generates  `v is bool`, it won't work when the given argument is not named  `v` in the calling scope. To deal with that, we could rewrite our function using code interpolation, as follows:

```haxe
public inline function isBool(v:Dynamic):Bool {
    return untyped __cs__("{0} is bool", v);
}
```

##### Class code injection

TODO: @:classCode

##### Function code injection

We can use `@:functionCode` metadata for a method to generate raw C# code inside a method body. It completely replaces any haxe expressions in method body. For example:

```haxe
@:functionCode("return (v is int);")
function isInt(v:Dynamic):Bool {
    return false;
}
```

Which will generate:

```haxe
public virtual bool isInt(object v) {
    return (v is int);
}
```

---

Previous section: [Haxe/C# Metadata](target-cs-metadata.md)

Next section: [Lua](target-lua.md)