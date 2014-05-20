## 3.2.1 Constraints

Type parameters can be constrained to multiple types:

```haxe
typedef Measurable = {
	public var length(default, null):Int;
}

class Constraints {	
	static public function main() {
		trace(test([]));
		trace(test(["bar", "foo"]));
		test("foo"); // String should be Iterable<String>
	}
	
	static function test<T:(Iterable<String>, Measurable)>(a:T) {
		if (a.length == 0) return "empty";
		return a.iterator().next();
	}
}
```
Type parameter `T` of method `test` is constrained to the types `Iterable<String>` and `Measurable`. The latter is defined using a [typedef](type-system-typedef.md) for convenience and requires compatible types to have a read-only [property](class-field-property.md) named `length` of type `Int`. The constraints then say that a type is compatible if



* it is compatible with `Iterable<String>` and
* has a `length`-property of type `Int`.


We can see that invoking `test` with an empty array in line 7 and an `Array<String>` in line 8 works fine. This is because `Array` has both a `length`-property and an `iterator`-method. However, passing a `String` as argument in line 9 fails the constraint check, because `String` is not compatible with `Iterable<T>`.

---

Previous section: [Type Parameters](type-system-type-parameters.md)

Next section: [Generic](type-system-generic.md)