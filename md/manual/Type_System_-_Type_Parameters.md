Haxe allows parametrization of a number of types, as well as class fields ([manual/Class_Fields]) and enum constructors ([manual/Enum_Constructors]). Type parameters are defined by enclosing comma-separated type parameter names in angle brackets `$<>$`. A simple example from the standard library is [manual/Array]:

```
class Array<T> {
function push(x : T) : Int;
}
```
Whenever an instance of `Array` is created, its type parameter `T` becomes a [manual/Monomorph]. That is, it can be bound to any type, but only one at a time. This binding can happen



* by invoking the constructor with explicit types (`new Array$<$String$>$()`) or
* by [manual/Type_Inference], e.g. when invoking `arrayInstance.push("foo")`.


Inside the definition of a class with type parameters, these type parameters are an unspecific type. Unless [manual/Constraints] are added, the compiler has to assume that the type parameters could be used with any type. As a consequence, it is not possible to access fields of type parameters or [manual/cast] to a a type parameter type. It is also not possible to create a new instance of a type parameter type, unless the type parameter is [manual/Generic] and constrained accordingly. 

The following table shows where type parameters are allowed:




Parameter on & Bound upon & Notes 
 
Class & instantiation & Can also be bound upon member field access. 

Enum & instantiation & 

Enum Constructor & instantiation & 

Function & invocation & Allowed for methods and named lvalue closures. 

Structure & instantiation & 
 


With function type parameters being bound upon invocation, such a type parameter (if unconstrained) accepts any type. However, only one type per invocation is accepted, which can be utilized if a function has multiple arguments:

```
class FunctionTypeParameter {
	static public function main() {
		equals(1, 1);
		equals("foo", "bar"); // runtime message: bar should be foo
		equals(1, "foo"); // compiler error: String should be Int
	}
	
	static function equals<T>(expected:T, actual:T) {
		if (actual != expected) trace('$actual should be $expected');
	}
}
```
Both arguments `expected` and `actual` of the `equals` function have type `T`. This implies that for each invocation of `equals`, the two arguments must be of the same type. The compiler admits the first call (both arguments being of `Int`) and the second call (both arguments being of `String`), but the third attempts causes a compiler error.