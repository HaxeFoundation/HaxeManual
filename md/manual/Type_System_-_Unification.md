Unification is the heart of the type system and contributes immensely to the robustness of haxe programs. It describes the process of checking if a type is compatible to another type.



Unification errors are very easy to trigger:

```
class Main {
static public function main() {
var s:String = 1; // Int should be String
}
}
```
We try to assign a value of type `Int` to a variable of type `String`, which causes the compiler to try and **unify Int with String**. This is, of course, not allowed and makes the compiler emit the error `Int should be String`.

In this particular case, the unification is triggered by an **assignment**, a context in which the "is assignable to" definition is intuitive. It is one of several cases where unification is performed:



* If `a` is assigned to `b`, the type of `a` is unified with the type of `b`.
* We have briefly seen this one while introducing the [[manual/Function]] type. In general, the compiler tries to unify the first given argument type with the first expected argument type, the second given argument type with the second expected argument type and so on until all argument types are handled.
* Whenever a function has a `return e` expression, the type of `e` is unified with the function return type. If the function has no explicit return type, it is infered to the type of `e` and subsequent `return`-expressions are infered against it.
* The compiler tries to find a minimal type between all given types in an array declaration. Refer to [[manual/Common_Base_Type]] for details.
* If an object is declared "against" a given type, the compiler unifies each given field type with each expected field type.
* Certain operators expect certain types which given types are unified against. For instance, the expression `a && b` unifies both `a` and `b` with `Bool` and the expression `a == b` unifies `a` with `b`.