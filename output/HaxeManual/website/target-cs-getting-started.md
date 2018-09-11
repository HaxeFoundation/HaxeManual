## 12.8.1 Getting started with Haxe/C#

Haxe can be used as a language for .NET platform through its C# target. Let's make a simple program using .NET Console class:

```haxe
class Main {
  static public function main():Void {
    trace("Hello World");
  }
}
```

To compile Haxe to C# we need two obvious prerequisites installed:

* [hxcs haxelib](http://lib.haxe.org/p/hxcs). This is the support library for the C# backend of the Haxe compiler.
* [.NET development framework (either Microsoft.NET or Mono)](https://www.microsoft.com/net)

After that we can compile to C# using the `-cs` option from either the command line or an hxml-file:

```hxml
haxe -cs out -main Main
```

The compiler will output C# sources into  **out/src** folder, then call C# compiler to build  **Main.exe** file into  **out/bin** folder.

##### More information

* [Haxe/C# API docs](https://api.haxe.org/cs/)
* [C# Documentation](https://msdn.microsoft.com/en-us/library/kx37x362.aspx)

---

Previous section: [C#](target-cs.md)

Next section: [.NET version and external libraries](target-cs-external-libraries.md)