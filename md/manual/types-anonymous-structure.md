## 2.5 Anonymous Structure

Anonymous structures can be used to group data without explicitly creating a type. The following example creates a structure with two fields `x` and `name`, and initializes their values to `12` and `"foo"` respectively:

```haxe
class Structure {
  static public function main() {
    var myStructure = { x: 12, name: "foo"};
  }
}
```
The general syntactic rules follow:

1. A structure is enclosed in curly braces `{}` and
2. Has a **comma-separated** list of key-value-pairs.
3. A **colon** separates the key, which must be a valid [identifier](dictionary.md#define-identifier), from the value.
4. The value can be any Haxe expression.

Rule 4 implies that structures can be nested and complex, e.g.:

```haxe
var user = {
  name : "Nicolas",
	age : 32,
	pos : [
	  { x : 0, y : 0 },
		{ x : 1, y : -1 }
  ],
};
```
Fields of structures, like classes, are accessed using a **dot** (`.`) like so:

```haxe
// get value of name, which is "Nicolas"
user.name;
// set value of age to 33
user.age = 33;
```
It is worth noting that using anonymous structures does not subvert the typing system. The compiler ensures that only available fields are accessed, which means the following program does not compile:

```haxe
class Test {
  static public function main() {
    var point = { x: 0.0, y: 12.0 };
    // { y : Float, x : Float } has no field z
    point.z;
  }
}
```
The error message indicates that the compiler knows the type of `point`: It is a structure with fields `x` and `y` of type `Float`. Since it has no field `z`, the access fails.
The type of `point` is known through [type inference](type-system-type-inference.md), which thankfully saves us from using explicit types for local variables. However, if `point` was a field, explicit typing would be necessary:

```haxe
class Path {
    var start : { x : Int, y : Int };
    var target : { x : Int, y : Int };
    var current : { x : Int, y : Int };
}
```
To avoid this kind of redundant type declaration, especially for more complex structures, it is advised to use a [typedef](type-system-typedef.md):

```haxe
typedef Point = { x : Int, y : Int }

class Path {
    var start : Point;
    var target : Point;
    var current : Point;
}
```

---

Previous section: [Using enums](types-enum-using.md)

Next section: [JSON for Structure Values](types-structure-json.md)