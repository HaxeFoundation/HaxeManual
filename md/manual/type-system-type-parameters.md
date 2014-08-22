## 3.2 Type Parameters

Haxe allows parametrization of a number of types, as well as [class fields](class-field.md) and [enum constructors](types-enum-constructor.md). Type parameters are defined by enclosing comma-separated type parameter names in angle brackets `<>`. A simple example from the Haxe Standard Library is `Array`:

```haxe
class Array<T> {
	function push(x : T) : Int;
}
```
Whenever an instance of `Array` is created, its type parameter `T` becomes a [monomorph](types-monomorph.md). That is, it can be bound to any type, but only one at a time. This binding can happen

* explicitly by invoking the constructor with explicit types (`new Array<String>()`) or
* implicitly by [type inference](type-system-type-inference.md), e.g. when invoking `arrayInstance.push("foo")`.

Inside the definition of a class with type parameters, these type parameters are an unspecific type. Unless [constraints](type-system-type-parameter-constraints.md) are added, the compiler has to assume that the type parameters could be used with any type. As a consequence, it is not possible to access fields of type parameters or [cast](expression-cast.md) to a type parameter type. It is also not possible to create a new instance of a type parameter type, unless the type parameter is [generic](type-system-generic.md) and constrained accordingly. 

The following table shows where type parameters are allowed:

Parameter on  | Bound upon  | Notes 
 --- | --- | ---
Class  | instantiation  | Can also be bound upon member field access. 
Enum  | instantiation  | 
Enum Constructor  | instantiation  | 
Function  | invocation  | Allowed for methods and named local lvalue functions. 
Structure  | instantiation  | 
 

With function type parameters being bound upon invocation, such a type parameter (if unconstrained) accepts any type. However, only one type per invocation is accepted, which can be utilized if a function has multiple arguments:

```haxe
class FunctionTypeParameter {
  static public function main() {
    equals(1, 1);
    // runtime message: bar should be foo
    equals("foo", "bar");
    // compiler error: String should be Int
    equals(1, "foo");
  }

  static function
  equals<T>(expected:T, actual:T) {
    if (actual != expected) {
      trace('$actual should be $expected');
    }
  }
}
```

Both arguments `expected` and `actual` of the `equals` function have type `T`. This implies that for each invocation of `equals`, the two arguments must be of the same type. The compiler admits the first call (both arguments being of `Int`) and the second call (both arguments being of `String`), but the third attempt causes a compiler error.

> ##### Trivia: Type parameters in expression syntax
>
> We often get the question why a method with type parameters cannot be called as `method<String>(x)`. The error messages the compiler gives are not quite helpful, but there is a simple reason for that: The above code is parsed as if both `<` and `>` were binary operators, yielding `(method < String) > (x)`.

---

Previous section: [Extensions](type-system-extensions.md)

Next section: [Constraints](type-system-type-parameter-constraints.md)