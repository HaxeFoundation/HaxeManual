## 8.2 Dead Code Elimination

Dead Code Elimination or **DCE** is a compiler feature which removes unused code from the output. After typing, the compiler evaluates the DCE entry-points (usually the main-method) and recursively determines which fields and types are used. Used fields are marked accordingly and unmarked fields are then removed from their classes.

DCE has three modes which are set when invoking the command line:

* -dce std: Only classes in the Haxe Standard Library are affected by DCE. This is the default setting on all targets.
* -dce no: No DCE is performed.
* -dce full: All classes are affected by DCE.

The DCE-algorithm works well with typed code, but may fail when [dynamic](types-dynamic.md) or [reflection](std-reflection.md) is involved. This may require explicit marking of fields or classes as being used by attributing the following metadata:

* `@:keep`: If used on a class, the class along with all fields is unaffected by DCE. If used on a field, that field is unaffected by DCE.
* `@:keepSub`: If used on a class, it works like `@:keep` on the annotated class as well as all subclasses.
* `@:keepInit`: Usually, a class which had all fields removed by DCE (or is empty to begin with) is removed from the output. By using this metadata, empty classes are kept.

If a class needs to be marked with `@:keep` from the command line instead of editing its source code, there is a compiler macro available for doing so: `--macro keep('type dot path')` See the [haxe.macro.Compiler.keep API](http://api.haxe.org/haxe/macro/Compiler.html#keep) for details of this macro. It will mark package, module or sub-type to be kept by DCE and includes them for compilation.
 
The compiler automatically defines the flag `dce` with a value of either `"std"`, `"no"` or `"full"` depending on the active mode. This can be used in [conditional compilation](lf-condition-compilation.md).

> ##### Trivia: DCE-rewrite
>
> DCE was originally implemented in Haxe 2.07. This implementation considered a function to be used when it was explicitly typed. The problem with that was that several features, most importantly interfaces, would cause all class fields to be typed in order to verify type-safety. This effectively subverted DCE completely, prompting the rewrite for Haxe 2.10.

> ##### Trivia: DCE and try.haxe.org
>
> DCE for the `JavaScript` target saw vast improvements when the website <http://try.haxe.org> was published. Initial reception of the generated JavaScript code was mixed, leading to a more fine-grained selection of which code to eliminate.

---

Previous section: [Built-in Compiler Metadata](cr-metadata.md)

Next section: [Compiler Services](cr-completion.md)