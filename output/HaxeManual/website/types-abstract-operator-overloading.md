## 2.8.2 Operator Overloading

Abstracts allow overloading of unary and binary operators by adding the `@:op` metadata to class fields:

```haxe
abstract MyAbstract(String) {
  public inline function new(s:String) {
    this = s;
  }

  @:op(A * B)
  public function repeat(rhs:Int):MyAbstract {
    var s:StringBuf = new StringBuf();
    for (i in 0...rhs)
      s.add(this);
    return new MyAbstract(s.toString());
  }
}

class Main {
  static public function main() {
    var a = new MyAbstract("foo");
    trace(a * 3); // foofoofoo
  }
}
```
By defining `@:op(A * B)`, the function `repeat` serves as operator method for the multiplication `*` operator when the type of the left value is `MyAbstract` and the type of the right value is `Int`. The usage is shown in line 17, which turns into this when compiled to JavaScript:

```haxe
console.log(_AbstractOperatorOverload.
  MyAbstract_Impl_.repeat(a,3));
```
Similar to [implicit casts with class fields](types-abstract-implicit-casts.md), a call to the overload method is inserted where required.

The example `repeat` function is not commutative: While `MyAbstract * Int` works, `Int * MyAbstract` does not. If this should be allowed as well, the `@:commutative` metadata can be added. If it should work **only** for `Int * MyAbstract`, but not for `MyAbstract * Int`, the overload method can be made static, accepting `Int` and `MyAbstract` as first and second type respectively.

Overloading unary operators is analogous:

```haxe
abstract MyAbstract(String) {
  public inline function new(s:String) {
    this = s;
  }

  @:op(++A) public function pre()
    return "pre" + this;
  @:op(A++) public function post()
    return this + "post";
}

class Main {
  static public function main() {
    var a = new MyAbstract("foo");
    trace(++a); // prefoo
    trace(a++); // foopost
  }
}
```
Both binary and unary operator overloads can return any type.

##### Exposing underlying type operations

It is also possible to omit the method body of a `@:op` function, but only if the underlying type of the abstract allows the operation in question and if the resulting type can be assigned back to the abstract.

```haxe
abstract MyAbstractInt(Int) from Int to Int {
  // The following line exposes the (A > B) operation from the underlying Int
  // type. Note that no function body is used:
  @:op(A > B) static function gt( a:MyAbstractInt, b:MyAbstractInt ) : Bool;
}

class Main {
  static function main() {
    var a:MyAbstractInt = 42;
    if(a > 0) trace('Works fine, > operation implemented!');

    // The < operator is not implemented.
    // This will cause an 'Cannot compare MyAbstractInt and Int' error:
    if(a < 100) { }
  }
}

```

---

Previous section: [Implicit Casts](types-abstract-implicit-casts.md)

Next section: [Array Access](types-abstract-array-access.md)