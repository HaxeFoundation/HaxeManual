## 12.8.2 .NET version and external libraries

By default, Haxe uses basic .NET 2.0 API provided by hxcs library (it ships mscorlib.dll and System.dll from the Mono project). We can specify different .NET version by providing `-D net-ver=xx` define, where xx is major and minor digits of .NET version number, i.e. `-D net-ver=40` for setting .NET version to 4.0. Note that currently, hxcs library only ships DLL files for .NET 2.0 and 4.0.

##### Using custom .NET distribution

We can make Haxe use a custom set of DLL files as standard .NET framework. To do that, we need to first learn about how Haxe finds standard .NET libraries. Haxe/C# looks for .DLL files in a directory path, constructed from three components:

* .NET version (set by `-D net-ver=xx`, defaults to `20` as described above)
* .NET target (by default set to `net`, but could be changed using `-D net-target=xxx`, where `xxx` could be `micro`, `compact` or some other).
* .NET std path (set by -net-std option, by default points to netlib directory inside hxcs library)

The resulting search path will be **<net_std_path>/<net_target>-<net_ver>/**, taking in the consideration default values described above, without any specific configuration haxe will load all .NET DLL files found in **<hxcs_install_path>/netlib/net-20/**.

Now if we provide the following options:

```haxe
-D net-target=micro -D net-ver=35 -net-std=/dotnet
```

Haxe will load all .NET DLL files found in **/dotnet/micro-35/**.

##### Using external libraries

Haxe can directly load .NET assembly files (.DLL) and convert its type definitions for use as Haxe types. To load a .NET assembly, use `-net-lib library.dll` compiler option. Haxe will then automatically parse types defined in that assembly file and make them available for import as Haxe types.

Some changes are performed to type naming of C# classes to make them fit into Haxe type system, namely:

* Namespaces are lowercased to follow Haxe package naming rules, so i.e. `UnityEngine` becomes `unityengine` (note that `System` namespace is also prefixed with `cs`, so  `System.Core` becomes  `cs.system.core`)
* Inner classes are generated as `OuterClassName_InnerClassName` and placed into the `OuterClassName` module. So for example for an inner class `B` inside a class `A` inside a namespace `Something`, the full Haxe type path will be `something.A.A_B`. Note however, that if you do `import something.A`, both `A` and `A_B` class will be available within your module as per standard Haxe import mechanism.
* Classes with type parameters have numbers of type params appended to their name, for example `Dictionary<K,V>` becomes `Dictionary_2<K,V>`

---

Previous section: [Getting started with Haxe/C#](target-cs-getting-started.md)

Next section: [Haxe/C# Defines](target-cs-defines.md)