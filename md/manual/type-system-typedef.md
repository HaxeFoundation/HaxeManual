## 3.1 Typedef

We briefly looked at typedefs while talking about [anonymous structures](types-anonymous-structure.md) and saw how we could shorten a complex structure type by giving it a name. This is precisely what typedefs are good for, and giving names to structure types might even be considered their primary use. In fact, it is so common that the distinction appears somewhat blurry and many Haxe users consider typedefs to actually **be** the structure.

A typedef can give a name to any other type:

```haxe
typedef IA = Array<Int>;
```
This enables us to use `IA` in places where we would normally use `Array<Int>`. While this saves only a few keystrokes in this particular case, it can make a difference for more complex, compound types. Again, this is why typedef and structures seem so connected:

```haxe
typedef User = {
    var age : Int;
    var name : String;
}
```
A typedef is not a textual replacement, but actually a real type. It can even have [type parameters](type-system-type-parameters.md) as the `Iterable` type from the Haxe Standard Library demonstrates:

```haxe
typedef Iterable<T> = {
	function iterator() : Iterator<T>;
}
```

---

Previous section: [Type System](type-system.md)

Next section: [Extensions](type-system-extensions.md)