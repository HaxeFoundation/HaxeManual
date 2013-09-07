The effects of type inference have been seen throughout this document and will continue to be important. A simple example shows type inference at work:

```
class TypeInference {
	public static function main() {
		var x = null;
		$type(x); // Unknown<0>
		x = "foo";
		$type(x); // String
	}
}
```
The special construct `$type` was previously mentioned in order to simplify the explanation of the [manual/Function] type, so let us introduce it officially now:

%TODO: $type
```
Define: type

type is a compile-time mechanism being called like a function, with a single argument. The compiler evaluates the argument expression and then outputs the type of that expression.
```

In the example above, the first `$type` prints `Unknown<0>`. This is a [manual/Monomorph], a type that is not yet known. The next line `x = "foo"` assigns a `String` literal to `x`, which causes the [manual/Unification] of the monomorph with `String`. We then see that the type of `x` indeed has changed to `String`.

Whenever a type other than [manual/Dynamic] is unified with a monomorph, that monomorph **becomes** that type: it **morphs** into that type. Therefore it cannot morph into a different type afterwards, a property expressed in the **mono** part of its name.

Following the rules of unification, type inference can occur in compound types:

```
class TypeInference2 {
	public static function main() {
		var x = [];
		$type(x); // Array<Unknown<0>>
		x.push("foo");
		$type(x); // Array<String>
	}
}
```
Variable `x` is first initialized to an empty [manual/Array]. At this point we can tell that the type of `x` is an array, but we do not yet know the type of the array elements. Consequentially, the type of `x` is `Array<Unknown<0>>`. It is only after pushing a `String` onto the array that we know the type to be `Array<String>`.