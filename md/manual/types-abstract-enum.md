## 2.8.5 Enum abstracts

##### since Haxe 3.1.0



By adding the `:enum` metadata to an abstract definition, that abstract can be used to define finite value sets:

```haxe
@:enum
abstract HttpStatus(Int) {
	var NotFound = 404;
	var MethodNotAllowed = 405;
}

class Main {
	static public function main() {
		var status = HttpStatus.NotFound;
		var msg = printStatus(status);
	}
	
	static function printStatus(status:HttpStatus) {
		return switch(status) {
			case NotFound: "Not found";
			case MethodNotAllowed: "Method not allowed";
		}
	}
}
```

The Haxe Compiler replaces all field access to the `HttpStatus` abstract with their values, as evident in the Javascript output:

```haxe
Main.main = function() {
	var status = 404;
	var msg = Main.printStatus(status);
};
Main.printStatus = function(status) {
	switch(status) {
	case 404:
		return "Not found";
	case 405:
		return "Method not allowed";
	}
};
```

This is similar to accessing [variables declared as inline](class-field-inline.md), but has several advantages:



* The typer can ensure that all values of the set are typed correctly.
* When [matching](lf-pattern-matching.md) an enum abstract, the pattern matcher checks for [exhaustiveness](lf-pattern-matching-exhaustiveness.md).
* Defining fields requires less syntax.

---

Previous section: [Selective Functions](types-abstract-selective-functions.md)

Next section: [Exposing abstracts](types-abstract-expose.md)