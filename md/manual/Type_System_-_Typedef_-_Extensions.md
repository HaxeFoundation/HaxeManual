% TODO: move to structures? %
Extensions are used to express that a structure has all the fields of a given type in addition to some more:

```
typedef IterableWithLength<T> = {
	> Iterable<T>,
	var length(default, null):Int; // read only property
}

class Extension {
	static public function main() {
		var array = [1, 2, 3];
		var t:IterableWithLength<Int> = array;
	}
}
```
The greater-than operator `>` denotes that an extension of `Iterable$<$T$>$` is being created, with the additional class fields following. In this case, a read-only [manual/Property] `length` of type `Int` is required.

In order to be compatible with `IterableWithLength$<$T$>$`, a type then must be compatible with `Iterable$<$T$>$` and also provide a read-only `length` property of type `Int`. The example assigns an [manual/Array], which happens to fulfill these requirements.

There may only be a single extension on a structure, so extensions can be understood as an [manual/Inheritance] mechanism for structures.