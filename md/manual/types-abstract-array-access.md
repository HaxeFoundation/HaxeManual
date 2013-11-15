## 2.8.3 Array Access

Array access describes the particular syntax traditionally used to access the value in an array at a certain offset. This is usually only allowed with arguments of type `Int`, but with abstracts it is possible to define custom array access methods. The [Haxe Standard Library](std.md) uses this in its `Map` type, where the following two methods can be found:

```haxe
@:arrayAccess public inline function get(key:K) return this.get(key);
@:arrayAccess public inline function arrayWrite(k:K, v:V):V {
	this.set(k, v);
	return v;
}
```
There are two kinds of array access methods:



* If an `@:arrayAccess` method accepts one argument, it is a getter.
* If an `@:arrayAccess` method accepts two arguments, it is a setter.


The methods `get` and `arrayWrite` seen above then allow the following usage:

```haxe
class ArrayAccessUsage {
	public static function main(){
		var map = new Map();
		map["foo"] = 1;
		trace(map["foo"]);
	}
}
```
At this point it should not be surprising to see that calls to the array access fields are inserted in the output:

```haxe
map.set("foo",1);
1;
console.log(map.get("foo"));
```

---

Previous section: [Operator Overloading](types-abstract-operator-overloading.md)

Next section: [Selective Functions](types-abstract-selective-functions.md)