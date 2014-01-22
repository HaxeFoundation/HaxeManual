## 5.10 Local functions

Haxe supports first-class functions and allows declaring local functions in expressions. The syntax follows [class field methods](class-field-method.md):

```haxe
class Main {
	static public function main() {
		var value = 1;
		function myLocalFunction(i) {
			return value + i;
		}
		trace(myLocalFunction(2)); // 3
	}
}
```

We declare `myLocalFunction` inside the [block expression](expression-block.md) of the `main` class field. It takes one argument `i` and adds it to `value`, which is defined in the outside scope.

The scoping is equivalent to that of [variables](expression-var.md) and for the most part writing a named local function can be considered equal to assigning an unnamed local function to a local variable:

```haxe
var myLocalFunction = function(a) { }
```

However, there are some differences related to type parameters and the position of the function. We speak of a "lvalue" function if it is not assigned to anything upon its declaration, and an "rvalue" function otherwise.



* Lvalue functions require a name and can have [type parameters](type-system-type-parameters.md).
* Rvalue functions may have a name, but cannot have type parameters.

---

Previous section: [var](expression-var.md)

Next section: [new](expression-new.md)