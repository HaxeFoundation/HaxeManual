## 2.6.1 Optional Arguments

Optional arguments are declared by prefixing an argument identifier with a question mark `?`:

```haxe
class OptionalArguments {
	static public function main() {
		$type(test); // ?i : Int -> ?s : String -> String
		trace(test()); // i: null, s: null
		trace(test(1)); // i: 1, s: null
		trace(test(1, "foo")); // i: 1, s: foo
		trace(test("foo")); // i: null, s: foo
	}
	
	static function test(?i:Int, ?s:String):String {
		return "i: " +i + ", s: " +s;
	}
}
```
Function `test` has two optional arguments `i` of type `Int` and `s` of `String`. This is directly reflected in the function type, which line 3 outputs. 
This example program calls `test` four times and prints its return value.



1. the first call is made without any arguments
2. the second call is made with a singular argument `1`
3. the third call is made with two arguments `1` and `"foo"`
4. the fourth call is made with a singular argument `"foo"`


The output shows that optional arguments which are omitted from the call have a value of `null`. This implies that the type of these arguments must admit `null` as value, which raises the question of its [nullability](types-nullability.md). The haxe compiler ensures that optional basic type arguments are nullable by inferring their type as `Null<T>` when compiling to a [static target](dictionary.md#static-target).

While the first three calls are intuitive, the fourth one might come as a surprise: It is indeed allowed to skip optional arguments if the supplied value is assignable to a later argument.

---

Previous section: [Function](types-function.md)

Next section: [Default values](types-function-default-values.md)