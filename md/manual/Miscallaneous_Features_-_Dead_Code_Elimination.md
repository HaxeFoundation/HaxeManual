Dead Code Elimination, or **DCE**, is a compiler feature which removes unused code from the output. After typing, the compiler evaluates the DCE entry-points (usually the main-method) and recursively determines which fields and types are used. Used fields are marked accordingly and unmarked fields are then removed from their classes.

DCE has three modes which are set when invoking the command line:



* Only classes in the haxe standard library are affected by DCE. This is the default setting on all targets but Javascript.
* No DCE is performed.
* All classes are affected by DCE. This is the default setting when targeting Javascript.


The DCE-algorithm works well with typed code, but may fail when [[manual/Dynamic]] or [[manual/Reflection]] is involved. This may require explicit marking of fields or classes as being used by attributing the following metadata:



*: If used on a class, the class along with all fields is unaffected by DCE. If used on a field, that field is unaffected by DCE.
* If used on a class, it works like `@:keep` on the annotated class as well as all subclasses.
* Usually, a class which had all fields removed by DCE (or is empty to begin with) is removed from the output. By using this metadata, empty classes are kept.


The compiler automatically defines the flag `dce` with a value of either `"std"`, `"no"` or `"full"` depending on the active mode. This can be used in [[manual/Conditional_Compilation]].