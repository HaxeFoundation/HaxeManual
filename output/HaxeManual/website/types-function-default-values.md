## 2.6.2 Default values

Haxe allows default values for arguments by assigning a **constant value** to them:

```haxe
class Main {
  static public function main() {
    // ?i : Int -> ?s : String -> String
    $type(test);
    trace(test()); // i: 12, s: bar
    trace(test(1)); // i: 1, s: bar
    trace(test(1, "foo")); // i: 1, s: foo
    trace(test("foo")); // i: 12, s: foo
  }

  static function test(?i = 12, s = "bar") {
    return "i: " +i + ", s: " +s;
  }
}
```
This example is very similar to the one from [Optional Arguments](types-function-optional-arguments.md), with the only difference being that the values `12` and `"bar"` are assigned to the function arguments `i` and `s` respectively. The effect is that the default values are used instead of `null` should an argument be omitted from the call.

Default values in Haxe are not part of the type and are not replaced at call-site (unless the function is [inlined](class-field-inline.md), which can be considered as a more typical approach. On some targets the compiler may still pass `null` for omitted argument values and generate code similar to this into the function:
```haxe
	static function test(i = 12, s = "bar") {
		if (i == null) i = 12;
		if (s == null) s = "bar";
		return "i: " +i + ", s: " +s;
	}
```
This should be considered in performance-critical code where a solution without default values may sometimes be more viable.

---

Previous section: [Optional Arguments](types-function-optional-arguments.md)

Next section: [Dynamic](types-dynamic.md)