## 9.7 Initialization macros

Initialization macros are invoked from command line by using the `--macro callExpr(args)` command. This registers a callback which the compiler invokes after creating its context, but before typing what was argument to `-main`. This then allows configuring the compiler in some ways.

If the argument to `--macro` is a call to a plain identifier, that identifier is looked up in the class `haxe.macro.Compiler` which is part of the Haxe Standard Library. It comes with several useful initialization macros which are detailed in its [API](http://api.haxe.org//haxe/macro/Compiler.html).

As an example, the `include` macro allows inclusion of an entire package for compilation, recursively if necessary. The command line argument for this would then be `--macro include('some.pack', true)`.

Of course it is also possible to define custom initialization macros to perform various tasks before the real compilation. A macro like this would then be invoked via `--macro some.Class.theMacro(args)`. For instance, as all macros share the same [context](macro-context.md), an initialization macro could set the value of a static field which other macros use as configuration.

---

Previous section: [Build Order](macro-limitations-build-order.md)

Next section: [Standard Library](std.md)