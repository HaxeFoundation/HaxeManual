## 2.8.1 Implicit Casts

Unlike classes, abstracts allow defining implicit casts. There are two kinds of implicit casts:



* Direct: Allows direct casting of the abstract type to or from another type. This is defined by adding `to` and `from` rules to the abstract type, and is only allowed for types which unify with the underlying type of the abstract.
* Class field: Allows casting via calls to special cast functions. These functions are defined using `@:to` and `@:from` metadata. This kind of cast is allowed for all types.


The following code example shows an example of **direct** casting:

```haxe
abstract MyAbstract(Int) from Int to Int {
	inline function new(i:Int) {
		this = i;
	}
}

class ImplicitCastDirect {
	static public function main() {
		var a:MyAbstract = 12;
		var b:Int = a;
	}
}
```
We declare `MyAbstract` as being `from Int` and `to Int`, meaning it can be assigned from `Int` and assigned to `Int`. This is shown in lines 9 and 10, where we first assign the `Int` `12` to variable `a` of type `MyAbstract` (this works due to the `from Int` declaration) and then that abstract back to variable `b` of type `Int` (this works due to the `to Int` declaration).

Class field casts have the same semantic, but are defined completely differently:

```haxe
abstract MyAbstract(Int) {
	inline function new(i:Int) {
		this = i;
	}
	
	@:from static public function fromString(s:String) {
		return new MyAbstract(Std.parseInt(s));
	}
	
	@:to public function toArray() {
		return [this];
	}
}

class ImplicitCastField {
	static public function main() {
		var a:MyAbstract = "3";
		var b:Array<Int> = a;
		trace(b); // [3]
	}
}
```
By adding `@:from` to a static function, that function qualifies as implicit cast function from its argument type to the abstract. These functions must return a value of the abstract type. They must also be declared `static`.

Similarly, adding `@:to` to a function qualifies it as implicit cast function from the abstract to its return type. These functions are typically member-functions, but they can be made `static` and then serve as [selective function](types-abstract-selective-functions.md).

In the example, the method `fromString` allows the assignment of value `"3"` to variable `a` of type `MyAbstract`, while the method `toArray` allows assigning that abstract to variable `b` of type `Array<Int>`.

When using this kind of cast, calls to that functions are inserted were required. This becomes obvious when looking at the Javascript output:

```haxe
var a = _ImplicitCastField.MyAbstract_Impl_.fromString("3");
var b = _ImplicitCastField.MyAbstract_Impl_.toArray(a);
```
This can be further optimized by [inlining](class-field-inline.md) both cast functions, turning the output to this:

```haxe
var a = Std.parseInt("3");
var b = [a];
```
The **selection algorithm** when assigning a type `A` to a type `B` with at least one of them being an abstract is simple:



1. If `A` is not an abstract, go to 3.
2. If `A` defines a **to**-conversions that admits `B`, go to 6.
3. If `B` is not an abstract, go to 5.
4. If `B` defines a **from**-conversions that admits `A`, go to 6.
5. Stop, unification fails.
6. Stop, unification succeeds.


By design, implicit casts are **not transitive**, as the following example shows:

```haxe
abstract A(Int) {
	public function new() this = 0;
	@:to public function toB() return new B();
}

abstract B(Int) {
	public function new() this = 0;
	@:to public function toC() return new C();	
}

abstract C(Int) {
	public function new() this = 0;	
}

class Main {
	static public function main() {
		var a = new A();
		var b:B = a; // valid, uses A.toB
		var c:C = b; // valid, uses B.toC
		var c:C = a; // error, A should be C
	}
}
```
While the individual casts from `A` to `B` and from `B` to `C` are allowed, a transitive cast from `A` to `C` is not. This is to avoid ambiguous cast-paths and retain a simple selection algorithm.

---

Previous section: [Abstract](types-abstract.md)

Next section: [Operator Overloading](types-abstract-operator-overloading.md)