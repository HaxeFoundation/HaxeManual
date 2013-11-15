## 8.1 Dead Code Elimination

Dead Code Elimination, or **DCE**, is a compiler feature which removes unused code from the output. After typing, the compiler evaluates the DCE entry-points (usually the main-method) and recursively determines which fields and types are used. Used fields are marked accordingly and unmarked fields are then removed from their classes.

DCE has three modes which are set when invoking the command line:



* -dce std: Only classes in the haxe standard library are affected by DCE. This is the default setting on all targets but Javascript.
* -dce no: No DCE is performed.
* -dce full: All classes are affected by DCE. This is the default setting when targeting Javascript.


The DCE-algorithm works well with typed code, but may fail when [dynamic](types-dynamic.md) or [reflection](std-reflection.md) is involved. This may require explicit marking of fields or classes as being used by attributing the following metadata:



* `@:keep`: If used on a class, the class along with all fields is unaffected by DCE. If used on a field, that field is unaffected by DCE.
* `@:keepSub`: If used on a class, it works like `@:keep` on the annotated class as well as all subclasses.
* `@:keepInit`: Usually, a class which had all fields removed by DCE (or is empty to begin with) is removed from the output. By using this metadata, empty classes are kept.


The compiler automatically defines the flag `dce` with a value of either `"std"`, `"no"` or `"full"` depending on the active mode. This can be used in [conditional compilation](lf-condition-compliation.md).

> ##### Trivia: DCE-rewrite
>
> DCE was originally implemented in haxe 2.07. This implementation considered a function to be used when it was explicitly typed. The problem with that was that several features, most importantly interfaces, would cause all class fields to be typed in order to verify type-safety. This effectively subverted DCE completely, prompting the rewrite for haxe 2.10.

> ##### Trivia: DCE and try.haxe.org
>
> DCE for the `Javascript` target saw vast improvements when the website [http://try.haxe.org](http://try.haxe.org) was published. Initial reception of the generated Javascript code was mixed, leading to a more fine-grained selection of which code to eliminate.

---

Previous section: [Compiler Features](cr-features.md)

Next section: [Completion](cr-completion.md)