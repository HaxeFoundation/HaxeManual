## 6.3.9 Extractors

##### since Haxe 3.1.0



Extractors allow applying transformations to values being matched. This is often useful when a small operation is required on a matched value before matching can continue:

```haxe
enum Test {
	TString(s:String);
	TInt(i:Int);
}

class Main {
	static public function main() {
		var e = TString("fOo");
		switch(e) {
			case TString(temp):
				switch(temp.toLowerCase()) {
					case "foo": true;
					case _: false;
				}
			case _: false;
		}
	}
}
```

Here we have to capture the argument value of the `TString` enum constructor in a variable `temp` and use a nested switch on `temp.toLowerCase()`. Obviously, we want matching to succeed if `TString` holds a value of `"foo"` regardless of its casing. This can be simplified with extractors:

```haxe
enum Test {
	TString(s:String);
	TInt(i:Int);
}

class Main {
	static public function main() {
		var e = TString("fOo");
		var success = switch(e) {
			case TString(toLowerCase => "foo"): true;
			case _: false;
		}
	}
}
```

Extractors are identified by the `extractorExpression => match` expression. The compiler generates code which is similar to the previous example, but the original syntax was greatly simplified. The way extractors are treated depends on the expression left of the `=>` operator. If it is



* any identifier `i`, the generated code is equal to `matchedValue.i()`,
* otherwise for arbitrary expressions `e`, it is equal to `e(matchedValue)`.



The distinction is made because interpreting a plain identifier like that can be quite convenient, as the `toLowerCase()` example above demonstrated. It also allows bringing extractors into context through [static extensions](lf-static-extension.md).

Any expression can be used as extractor expression and the typer ensures that it is of function type `S->T`, where `S` is the type of the currently matched value and `T` is equal to the type of the expression right of the `=>` operator. With that, extractors can be combined with other features such as [function binding](lf-function-bindings.md):

```haxe
enum Test {
	TString(s:String);
	TInt(i:Int);
}

class Main {
	static public function main() {
		var e = TInt(4);
		var success = switch(e) {
			case TInt(lessThan.bind(_, 5) => true): true;
			case _: false;
		}
		trace(success);
	}
	
	static function lessThan(lhs:Int, rhs:Int) {
		return lhs < rhs;
	}
}
```

In this particular case, the extractor is called as `lessThan(4, 5)`, yielding true.

A lcurrent imitation with regards to extractors is that they disable [useless pattern checks](lf-pattern-matching-unused.md).

---

Previous section: [Match on multiple values](lf-pattern-matching-tuples.md)

Next section: [Exhaustiveness checks](lf-pattern-matching-exhaustiveness.md)