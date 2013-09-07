In haxe, structural subtyping is only possible when assigning a class instance to a structure. The following example is part of the [[manual/Lambda]] class of the Haxe standard library ([[manual/Standard_Library]]):

```
public static function empty<T>(it : Iterable<T>) : Bool {
return !it.iterator().hasNext();
}
```
The `empty`-method checks if an `Iterable` has an element. For this purpose, it is not necessary to know anything about the argument type other than the fact that it is considered an iterable. This allows calling the `empty`-method with any type that unifies with `Iterable$<$T$>$`, which applies to a lot of types in the Haxe Standard Library.

This kind of typing can be very convenient, but extensive use may be detrimental to performance on static targets, which is detailed in [[manual/Impact_on_Performance]].