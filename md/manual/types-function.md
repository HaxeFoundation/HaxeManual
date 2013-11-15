## 2.6 Function

The function type, along with the [monomorph](types-monomorph.md), is a type which is usually well-hidden from Haxe users, yet present everywhere. We can make it surface by using `$type`, a special Haxe identifier which outputs the type its expression has during compilation :

```haxe
class FunctionType {
	static public function main() {
		$type(test); // i : Int -> s : String -> Bool
		$type(test(1, "foo")); // Bool
	}
	
	static function test(i:Int, s:String):Bool {
		return true;
	}
}
```

There is a strong resemblance between the declaration of function `test` and the output of the first `$type` expression, yet also a subtle difference:



* **Function arguments** are separated by the special arrow token `->` instead of commas, and
* the **function return type** appears at the end after another `->`.


In either notation, it is obvious that the function `test` accepts a first argument of type `Int`, a second argument of type `String` and returns a value of type `Bool`. If a call to this function is made, such as `test(1, "foo")` within the second `$type` expression, the haxe typer checks if `1` can be assigned to `Int` and if `"foo"` can be assigned to `String`. The type of the call is then equal to the type of the value `test` returns, which is `Bool`.

---

Previous section: [Impact on Performance](types-structure-performance.md)

Next section: [Optional Arguments](types-function-optional-arguments.md)