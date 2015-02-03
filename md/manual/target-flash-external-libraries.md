## 12.2.3 Using external Flash libraries

To embed external `.swf` or `.swc` libraries, use the following [compilation options](http://haxe.org/documentation/introduction/compiler-usage.html):

* `-swf-lib <file>` Embeds the SWF library in the compiled SWF.
* `-swf-lib-extern <file>` Adds the SWF library for type checking but doesn't include it in the compiled SWF.

The standard compilation options also provide more Haxe sources to be added to the project:

* To add another class path use `-cp <directory>`.
* To add a [Haxelib library](haxelib.md) use `-lib <library-name>`.
* To force a whole package to be included in the project, use `--macro include('mypackage')` which will include all the classes declared in the given package and subpackages.

---

Previous section: [Embedding resources](target-flash-resources.md)

Next section: [Flash target Metatags](target-flash-metatags.md)