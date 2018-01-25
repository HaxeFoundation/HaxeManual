## 12.8.3 Haxe/C# Defines

Besides `-D net-ver` and `-D net-target`:

* `-D dll` compile to a .NET assembly instead of an executable file. Added automatically when no `-main` is specified.
* `-D real-position` don't generate #line directives that map C# expression positions to original .hx files. Useful for tracking down issues related to code generation.
* `-D no-root` generate package-less haxe types in the haxe.root namespace to avoid conflicts with other types in the root namespace
* `-D erase-generics` fully erase type parameters from generated C# files and generate non-generic classes. This is useful in some cases, like working with .NET Micro Framework or preventing generics-related issues with Unity3D AOT compiler.
* `-D no-compilation` only generate C# sources and don't invoke C# compiler on them.
* `-D keep-old-output` by default haxe cleans up stale generated source files from the output directory. This define disables that behaviour.
* `-D dll-import`

Haxe automatically adds `NET_xx` defines where xx is major and minor version numbers .NET versions up to selected one. For example, when using .NET 4.0 (by providing `-D net-ver=40`), we have the following defines set automatically: `NET_20`, `NET_21`, `NET_30`, ` NET_35` and `NET_40`. If we had `-D net-ver=30`, we would only have `NET_20`, `NET_21` and `NET_30`.

---

Previous section: [.NET version and external libraries](target-cs-external-libraries.md)

Next section: [Haxe/C# Metadata](target-cs-metadata.md)