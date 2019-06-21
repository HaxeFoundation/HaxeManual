<!--label:type-system-->
## Type System

We learned about the different kinds of types in [Types](types) and it is now time to see how they interact with each other. We start off easy by introducing [typedef](type-system-typedef), a mechanism to give a name (or alias) to a more complex type. Among other things, this will come in handy when working with types having [type parameters](type-system-type-parameters).

A lot of type-safety is achieved by checking if two given types of the type groups above are compatible. Meaning, the compiler tries to perform **unification** between them as detailed in [Unification](type-system-unification).

All types are organized in **modules** and can be addressed through **paths**. [Modules and Paths](type-system-modules-and-paths) will give a detailed explanation of the related mechanics.

<!--label:type-system-typedef-->
### Typedef

We briefly looked at typedefs while talking about [anonymous structures](types-anonymous-structure) and saw how we could shorten a complex [structure type](types-anonymous-structure) by giving it a name. This is precisely what typedefs are good for. Giving names to structure types might even be considered their primary use. In fact, it is so common that the distinction appears somewhat blurry and many Haxe users consider typedefs to actually **be** the structure.

A typedef can give a name to any other type:

```haxe
typedef IA = Array<Int>;
```
This enables us to use `IA` in places where we would normally use `Array<Int>`. While this saves only a few keystrokes in this particular case, it can make a much bigger difference for more complex, compound types. Again, this is why typedef and structures seem so connected:

```haxe
typedef User = {
  var age : Int;
  var name : String;
}
```
A typedef is not a textual replacement but actually a real type. It can even have [type parameters](type-system-type-parameters) as the `Iterable` type from the Haxe Standard Library demonstrates:

```haxe
typedef Iterable<T> = {
  function iterator() : Iterator<T>;
}
```



<!--label:type-system-type-parameters-->
### Type Parameters

Haxe allows parametrization of a number of types, as well as [class fields](class-field) and [enum constructors](types-enum-constructor). Type parameters are defined by enclosing comma-separated type parameter names in angle brackets `<>`. A simple example from the Haxe Standard Library is `Array`:

```haxe
class Array<T> {
  function push(x : T) : Int;
}
```
Whenever an instance of `Array` is created, its type parameter `T` becomes a [monomorph](types-monomorph). That is, it can be bound to any type, but only one at a time. This binding can happen

* explicitly by invoking the constructor with explicit types (`new Array<String>()`) or
* implicitly by [type inference](type-system-type-inference), e.g. when invoking `arrayInstance.push("foo")`.

Inside the definition of a class with type parameters, these type parameters are an unspecific type. Unless [constraints](type-system-type-parameter-constraints) are added, the compiler has to assume that the type parameters could be used with any type. As a consequence, it is not possible to access fields of type parameters or [cast](expression-cast) to a type parameter type. It is also not possible to create a new instance of a type parameter type, unless the type parameter is [generic](type-system-generic) and constrained accordingly. 

The following table shows where type parameters are allowed:

Parameter on | Bound upon | Notes 
 --- | --- | ---
Class | instantiation | Can also be bound upon member field access. 
Enum | instantiation | 
Enum Constructor | instantiation | 
Function | invocation | Allowed for methods and named local lvalue functions. 
Structure | instantiation | 
 

With function type parameters being bound upon invocation, such a type parameter (if unconstrained) accepts any type. However, only one type per invocation is accepted. This can be utilized if a function has multiple arguments:

[code asset](assets/FunctionTypeParameter.hx)

Both arguments `expected` and `actual` of the `equals` function have type `T`. This implies that for each invocation of `equals` the two arguments must be of the same type. The compiler admits the first call (both arguments being of `Int`) and the second call (both arguments being of `String`) but the third attempt causes a compiler error.

> ##### Trivia: Type parameters in expression syntax
>
> We often get the question why a method with type parameters cannot be called as `method<String>(x)`. The error messages the compiler gives are not very helpful. However, there is a simple reason for that: The above code is parsed as if both `<` and `>` were binary operators, yielding `(method < String) > (x)`.

<!--label:type-system-type-parameter-constraints-->
#### Constraints

Type parameters can be constrained to multiple types:

[code asset](assets/Constraints.hx)

Type parameter `T` of method `test` is constrained to the types `Iterable<String>` and `Measurable`. The latter is defined using a [typedef](type-system-typedef) for convenience and requires compatible types to have a read-only [property](class-field-property) named `length` of type `Int`. The constraints then say that a type is compatible if

* it is compatible with `Iterable<String>` and
* has a `length`-property of type `Int`.

We can see that invoking `test` with an empty array in line 7 and an `Array<String>` in line 8 works fine. This is because `Array` has both a `length`-property and an `iterator`-method. However, passing a `String` as argument in line 9 fails the constraint check because `String` is not compatible with `Iterable<T>`. 

When constraining to a single type, the parentheses can be omitted:

[code asset](assets/Constraints2.hx)

##### since Haxe 4.0.0

One of the breaking changes between versions 3 and 4 is the multiple type constraint syntax. As the first example above shows, in Haxe 4 the constraints are separated by a `&` symbol instead of a comma. This is similar to the new [structure extension](types-structure-extensions) syntax.





<!--label:type-system-generic-->
### Generic

Usually, the Haxe Compiler generates only a single class or function even if it has type parameters. This results in a natural abstraction where the code generator for the target language has to assume that a type parameter could be of any type. The generated code then might have to perform some type checks which can be detrimental to performance.

A class or function can be made **generic** by attributing it with the `:generic` [metadata](lf-metadata). This causes the compiler to emit a distinct class/function per type parameter combination with mangled names. A specification like this can yield a boost in performance-critical code portions on [static targets](define-static-target) at the cost of a larger output size:

[code asset](assets/GenericClass.hx)

It seems unusual to see the explicit type `MyValue<String>` here as we usually let [type inference](type-system-type-inference) deal with this. Nonetheless, it is indeed required in this case. The compiler has to know the exact type of a generic class upon construction. The JavaScript output shows the result:

```js
(function () { "use strict";
var Test = function() { };
Test.main = function() {
	var a = new MyValue_String("Hello");
	var b = new MyValue_Int(5);
};
var MyValue_Int = function(value) {
	this.value = value;
};
var MyValue_String = function(value) {
	this.value = value;
};
Test.main();
})();
```

We can identify that `MyValue<String>` and `MyValue<Int>` have become `MyValue_String` and `MyValue_Int` respectively. This is similar for generic functions:

[code asset](assets/GenericFunction.hx)

Again, the JavaScript output makes it obvious:

```js
(function () { "use strict";
var Main = function() { }
Main.method_Int = function(t) {
}
Main.method_String = function(t) {
}
Main.main = function() {
	Main.method_String("foo");
	Main.method_Int(1);
}
Main.main();
})();
```

<!--label:type-system-generic-type-parameter-construction-->
#### Construction of generic type parameters

> ##### Define: Generic Type Parameter
>
> A type parameter is said to be generic if its containing class or method is generic.

It is not possible to construct normal type parameters, e.g. `new T()` is a compiler error. The reason for this is that Haxe generates only a single function and the construct makes no sense in that case. This is different when the type parameter is generic: Since we know that the compiler will generate a distinct function for each type parameter combination, it is possible to replace the `T` `new T()` with the real type.

[code asset](assets/GenericTypeParameter.hx)

It should be noted that [top-down inference](type-system-top-down-inference) is used here to determine the actual type of `T`. There are two requirements for this kind of type parameter construction to work: The constructed type parameter must be

1. generic and
2. be explicitly [constrained](type-system-type-parameter-constraints) to having a [constructor](types-class-constructor).

Here, 1. is given by `make` having the `@:generic` metadata, and 2. by `T` being constrained to `Constructible`. The constraint holds for both `String` and `haxe.Template` as both have a constructor accepting a singular `String` argument. Sure enough, the relevant JavaScript output looks as expected:

```js
var Main = function() { }
Main.__name__ = true;
Main.make_haxe_Template = function() {
	return new haxe.Template("foo");
}
Main.make_String = function() {
	return new String("foo");
}
Main.main = function() {
	var s = Main.make_String();
	var t = Main.make_haxe_Template();
}
```





<!--label:type-system-variance-->
### Variance

While variance is also relevant in other places, it occurs particularly often with type parameters and comes as a surprise in this context. Additionally, it is very easy to trigger variance errors:

[code asset](assets/Variance.hx)

Apparently, an `Array<Child>` cannot be assigned to an `Array<Base>`, even though `Child` can be assigned to `Base`. The reason for this might be somewhat unexpected: It is not allowed because arrays can be written to, e.g. via their `push()` method. It is easy to generate problems by ignoring variance errors:

[code asset](assets/Variance2.hx)

Here we subvert the type checker by using a [cast](expression-cast), thus allowing the assignment after the commented line. With that we hold a reference `bases` to the original array, typed as `Array<Base>`. This allows pushing another type compatible with `Base` (`OtherChild`) onto that array. However, our original reference `children` is still of type `Array<Child>` and things go bad when we encounter the `OtherChild` instance in one of its elements while iterating.

If `Array` had no `push()` method and no other means of modification, the assignment would be safe because no incompatible type could be added to it. In Haxe, we can achieve this by restricting the type accordingly using [structural subtyping](type-system-structural-subtyping):

[code asset](assets/Variance3.hx)

We can safely assign with `b` being typed as `MyArray<Base>` and `MyArray` only having a `pop()` method. There is no method defined on `MyArray` which could be used to add incompatible types, it is thus said to be **covariant**.

> ##### Define: Covariance
>
> A [compound type](define-compound-type) is considered covariant if its component types can be assigned to less specific components, i.e. if they are only read, but never written.

> ##### Define: Contravariance
>
> A [compound type](define-compound-type) is considered contravariant if its component types can be assigned to less generic components, i.e. if they are only written, but never read.



<!--label:type-system-unification-->
### Unification

Unification is the heart of the type system and contributes immensely to the robustness of Haxe programs. It describes the process of checking if a type is compatible to another type.

> ##### Define: Unification
>
> Unification between two types A and B is a directional process which answers the question if A **can be assigned to** B. It may **mutate** either type if it is or has a [monomorph](types-monomorph).

Unification errors are very easy to trigger:

```haxe
class Main {
  static public function main() {
    // Int should be String
    var s:String = 1;
  }
}
```
We try to assign a value of type `Int` to a variable of type `String`, which causes the compiler to try and **unify Int with String**. This is, of course, not allowed and makes the compiler emit the error `Int should be String`.

In this particular case, the unification is triggered by an **assignment**, a context in which the "is assignable to" definition is intuitive. It is one of several cases where unification is performed:

* Assignment: If `a` is assigned to `b`, the type of `a` is unified with the type of `b`.
* Function call: We have briefly seen this one while introducing the [function](types-function) type. In general, the compiler tries to unify the first given argument type with the first expected argument type, the second given argument type with the second expected argument type and so on until all argument types are handled.
* Function return: Whenever a function has a `return e` expression, the type of `e` is unified with the function return type. If the function has no explicit return type, it is inferred to the type of `e` and subsequent `return` expressions are inferred against it.
* Array declaration: The compiler tries to find a minimal type between all given types in an array declaration. Refer to [Common Base Type](type-system-unification-common-base-type) for details.
* Object declaration: If an object is declared "against" a given type, the compiler unifies each given field type with each expected field type.
* Operator unification: Certain operators expect certain types which the given types are unified against. For instance, the expression `a && b` unifies both `a` and `b` with `Bool` and the expression `a == b` unifies `a` with `b`.

<!--label:type-system-unification-between-classes-and-interfaces-->
#### Between Class/Interface

When defining unification behavior between classes, it is important to remember that unification is directional: We can assign a more specialized class (e.g. a child class) to a generic class (e.g. a parent class) but the reverse is not valid.

The following assignments are allowed:

* child class to parent class
* class to implementing interface
* interface to base interface

These rules are transitive, meaning that a child class can also be assigned to the base class of its base class, an interface its base class implements, the base interface of an implementing interface and so on.



<!--label:type-system-structural-subtyping-->
#### Structural Subtyping

> ##### Define: Structural Subtyping
>
> Structural subtyping defines an implicit relation between types that have the same structure.

Structural sub-typing in Haxe is allowed when unifying

* a [class](types-class-instance) with a [structure](types-anonymous-structure) and
* a structure with another structure.

The following example is part of the `Lambda` class of the [Haxe Standard Library](std):

```haxe
public static function empty<T>(it : Iterable<T>):Bool {
  return !it.iterator().hasNext();
}
```
The `empty`-method checks if an `Iterable` has an element. For this purpose, it is not necessary to know anything about the argument type other than the fact that it is considered an iterable. This allows calling the `empty`-method with any type that unifies with `Iterable<T>` which applies to a lot of types in the Haxe Standard Library.

This kind of typing can be very convenient but extensive use may be detrimental to performance on static targets, which  is detailed in [Impact on Performance](types-structure-performance).



<!--label:type-system-monomorphs-->
#### Monomorphs

Unification of types having or being a [monomorph](types-monomorph) is detailed in [Type Inference](type-system-type-inference).



<!--label:type-system-unification-function-return-->
#### Function Return

Unification of function return types may involve the [`Void`-type](types-void) and requires a clear definition of what unifies with `Void`. With `Void` describing the absence of a type, it is not assignable to any other type, not even `Dynamic`. This means that if a function is explicitly declared as returning `Dynamic`, it cannot return `Void`.

The opposite applies as well: If a function declares a return type of `Void`, it cannot return `Dynamic` or any other type. However, this direction of unification is allowed when assigning function types:

```haxe
var func:Void->Void = function() return "foo";
```

The right-hand function clearly is of type `Void->String`, yet we can assign it to the variable `func` of type `Void->Void`. This is because the compiler can safely assume that the return type is irrelevant, given that it could not be assigned to any non-`Void` type.



<!--label:type-system-unification-common-base-type-->
#### Common Base Type

Given a set of multiple types, a **common base type** is a type which all types of the set unify against:

[code asset](assets/UnifyMin.hx)

Although `Base` is not mentioned, the Haxe Compiler manages to infer it as the common type of `Child1` and `Child2`. The Haxe Compiler employs this kind of unification in the following situations:

* array declarations
* `if`/`else`
* cases of a `switch`





<!--label:type-system-type-inference-->
### Type Inference

The effects of type inference have been seen throughout this document and will continue to be important. A simple example shows type inference at work:

[code asset](assets/TypeInference.hx)

The special construct `$type` was previously mentioned in order to simplify the explanation of the [Function Type](types-function) type, so let us now introduce it officially:

> ##### Define: `$type`
>
> `$type` is a compile-time mechanism being called like a function, with a single argument. The compiler evaluates the argument expression and then outputs the type of that expression.

In the example above, the first `$type` prints `Unknown<0>`. This is a [monomorph](types-monomorph), a type that is not yet known. The next line `x = "foo"` assigns a `String` literal to `x`, which causes the [unification](type-system-unification) of the monomorph with `String`. We then see that the type of `x` indeed has changed to `String`.

Whenever a type other than [Dynamic](types-dynamic) is unified with a monomorph, that monomorph **becomes** that type: it **morphs** into that type. Therefore it cannot morph into a different type afterwards, a property expressed in the **mono** part of its name.

Following the rules of unification, type inference can occur in compound types:

[code asset](assets/TypeInference2.hx)

Variable `x` is first initialized to an empty `Array`. At this point we can tell that the type of `x` is an array, but we do not yet know the type of the array elements. Consequentially, the type of `x` is `Array<Unknown<0>>`. It is only after pushing a `String` onto the array that we know the type to be `Array<String>`.

<!--label:type-system-top-down-inference-->
#### Top-down Inference

Most of the time, types are inferred on their own and may then be unified with an expected type. In a few places, however, an expected type may be used to influence inference. We then speak of **top-down inference**.

> ##### Define: Expected Type
>
> Expected types occur when the type of an expression is known before that expression has been typed, e.g. because the expression is argument to a function call. They can influence typing of that expression through what is called [top-down inference](type-system-top-down-inference).

A good example are arrays of mixed types. As mentioned in [Dynamic](types-dynamic), the compiler refuses `[1, "foo"]` because it cannot determine an element type. Employing top-down inference, this can be overcome:

[code asset](assets/TopDownInference.hx)

Here, the compiler knows while typing `[1, "foo"]` that the expected type is `Array<Dynamic>`, so the element type is `Dynamic`. Instead of the usual unification behavior where the compiler would attempt (and fail) to determine a [common base type](type-system-unification-common-base-type), the individual elements are typed against and unified with `Dynamic`.

We have seen another interesting use of top-down inference when [construction of generic type parameters](type-system-generic-type-parameter-construction) was introduced:

[code asset](assets/GenericTypeParameter.hx)

The explicit types `String` and `haxe.Template` are used here to determine the return type of `make`. This works because the method is invoked as `make()`, so we know the return type will be assigned to the variables. Utilizing this information, it is possible to bind the unknown type `T` to `String` and `haxe.Template` respectively.



<!--label:type-system-inference-limitations-->
#### Limitations

Type inference saves a lot of manual type hints when working with local variables, but sometimes the type system still needs some help. In fact, it does not even try to infer the type of a [variable](class-field-variable) or [property](class-field-property) field unless it has a direct initialization.

There are also some cases involving recursion where type inference has limitations. If a function calls itself recursively while its type is not (completely) known yet, type inference may infer a wrong, too specialized type.

A different kind of limitation involves the readability of code. If type inference is overused it might be difficult to understand parts of a program due to the lack of visible types. This is particularly true for method signatures. It is recommended to find a good balance between type inference and explicit type hints.





<!--label:type-system-modules-and-paths-->
### Modules and Paths

> ##### Define: Module
>
> All Haxe code is organized in modules, which are addressed using paths. In essence, each .hx file represents a module which may contain several types. A type may be `private`, in which case only its containing module can access it.

The distinction of a module and its containing type of the same name is blurry by design. In fact, addressing `haxe.ds.StringMap<Int>` can be considered shorthand for `haxe.ds.StringMap.StringMap<Int>`. The latter version consists of four parts:

1. the package `haxe.ds`
2. the module name `StringMap`
3. the type name `StringMap`
4. the type parameter `Int`

If the module and type name are equal, the duplicate can be removed, leading to the `haxe.ds.StringMap<Int>` short version. However, knowing about the extended version helps with understanding how [module sub-types](type-system-module-sub-types) are addressed.

Paths can be shortened further by using an [import](type-system-import), which typically allows omitting the package part of a path. This may lead to usage of unqualified identifiers, for which understanding the [resolution order](type-system-resolution-order) is required.

> ##### Define: Type path
>
> The (dot-)path to a type consists of the package, the module name and the type name. Its general form is `pack1.pack2.packN.ModuleName.TypeName`.

<!--label:type-system-module-sub-types-->
#### Module Sub-Types

A module sub-type is a type declared in a module with a different name than that module. This allows a single .hx file to contain multiple types, which can be accessed unqualified from within the module, and by using `package.Module.Type` from other modules:

```haxe
var e:haxe.macro.Expr.ExprDef;
```

Here the sub-type `ExprDef` within module `haxe.macro.Expr` is accessed. 

An example sub-type declaration would look like the following :

```haxe
// a/A.hx
package a;

class A { public function new() {} }
// sub-type
class B { public function new() {} }
```

```haxe
// Main.hx
import a.A;

class Main {
    static function main() {
        var subtype1 = new a.A.B();

        // these are also valid, but require import a.A or import a.A.B :
        var subtype2 = new B();
        var subtype3 = new a.B();
    }
}
```

The sub-type relation is not reflected at run-time. That is, public sub-types become a member of their containing package, which could lead to conflicts if two modules within the same package tried to define the same sub-type. Naturally, the Haxe compiler detects these cases and reports them accordingly. In the example above `ExprDef` is generated as `haxe.macro.ExprDef`.

Sub-types can also be made private:

```haxe
private class C { ... }
private enum E { ... }
private typedef T { ... }
private abstract A { ... }
```

> ##### Define: Private type
>
> A type can be made private by using the `private` modifier. As a result, the type can only be directly accessed from within the [module](define-module) it is defined in.
> 
> Private types, unlike public ones, do not become a member of their containing package.

The accessibility of types can be controlled more fine-grained by using [access control](lf-access-control).



<!--label:type-system-import-->
#### Import

If a type path is used multiple times in a .hx file, it might make sense to use an `import` to shorten it. This allows omitting the package when using the type:

[code asset](assets/Import.hx)

With `haxe.ds.StringMap` being imported in the first line, the compiler is able to resolve the unqualified identifier `StringMap` in the `main` function to this package. The module `StringMap` is said to be **imported** into the current file.

In this example, we are actually importing a **module**, not just a specific type within that module. This means that all types defined within the imported module are available:

[code asset](assets/Import2.hx)

The type `Binop` is an [enum](types-enum-instance) declared in the module `haxe.macro.Expr`, and thus available after the import of said module. If we were to import only a specific type of that module, e.g. `import haxe.macro.Expr.ExprDef`, the program would fail to compile with `Class not found : Binop`.

There are several aspects worth knowing about importing:

* The bottommost import takes priority (detailed in [Resolution Order](type-system-resolution-order)).
* The [static extension](lf-static-extension) keyword `using` implies the effect of `import`.
* If an enum is imported (directly or as part of a module import), all its [enum constructors](types-enum-constructor) are also imported (this is what allows the `OpAdd` usage in the above example).

Furthermore, it is also possible to import [static fields](class-field) of a class and use them unqualified:

[code asset](assets/Import3.hx)

Special care has to be taken with field names or local variable names that conflict with a package name: Since they take priority over packages, a local variable named `haxe` blocks off usage of the entire `haxe` package.

##### Wildcard import

Haxe allows using `.*` to allow import of all modules in a package, all types in a module or all static fields in a type. It is important to understand that this kind of import only crosses a single level as we can see in the following example:

[code asset](assets/ImportWildcard.hx)

Using the wildcard import on `haxe.macro` allows accessing `Expr` which is a module in this package, but it does not allow accessing `ExprDef` which is a sub-type of the `Expr` module. This rule extends to static fields when a module is imported.

When using wildcard imports on a package the compiler does not eagerly process all modules in that package. This means that these modules are never actually seen by the compiler unless used explicitly and are then not part of the generated output.

##### Import with alias

If a type or static field is used a lot in an importing module it might help to alias it to a shorter name. This can also be used to disambiguate conflicting names by giving them a unique identifier.

[code asset](assets/ImportAlias.hx)

Here we import `String.fromCharCode` as `f` which allows us to use `f(65)` and `f(66)`. While the same could be achieved with a local variable, this method is compile-time exclusive and guaranteed to have no run-time overhead.

##### since Haxe 3.2.0

Haxe also allows the more natural `as` in place of `in`.



<!--label:type-system-import-defaults-->
#### Import defaults / import.hx

##### since Haxe 3.3.0

This feature allows us to define default imports and usings that will be applied for all modules inside a directory, which is particularly handy for large code bases with a lot of helpers and static extensions because it reduces the amount of imports.

The special named `import.hx` file (note the lowercase name) can be placed in the directory where your code lies. The file can contain import and using statements only. The statements will be applied to all Haxe modules in this directory and its subdirectories.

Default imports of `import.hx` acts as if its contents is placed at the top of each module. 

##### Related content

* [Introduction of `import.hx`](https://haxe.org/blog/importhx-intro/)



<!--label:type-system-resolution-order-->
#### Resolution Order

Resolution order comes into play as soon as unqualified identifiers are involved. These are [expressions](expression) in the form of `foo()`, `foo = 1` and `foo.field`. The last one in particular includes module paths such as `haxe.ds.StringMap`, where `haxe` is an unqualified identifier.  

We describe the resolution order algorithm here, which depends on the following state:

* the declared [local variables](expression-var) (including function arguments)
* the [imported](type-system-import) modules, types and statics
* the available [static extensions](lf-static-extension)
* the kind (static or member) of the current field
* the declared member fields on the current class and its parent classes
* the declared static fields on the current class
* the [expected type](define-expected-type)
* the expression being `untyped` or not

![](assets/graphics/generated/type-system-resolution-order-diagram.png)

_Figure: Resolution order of identifier `i'_

Given an identifier `i`, the algorithm is as follows:

1. If i is `true`, `false`, `this`, `super` or `null`, resolve to the matching constant and halt.
2. If a local variable named `i` is accessible, resolve to it and halt.
3. If the current field is static, go to 6.
4. If the current class or any of its parent classes has a field named `i`, resolve to it and halt.
5. If a static extension with a first argument of the type of the current class is available, resolve to it and halt.
6. If the current class has a static field named `i`, resolve to it and halt.
7. If an enum constructor named `i` is declared on an imported enum, resolve to it and halt.
8. If a static named `i` is explicitly imported, resolve to it and halt.
9. If `i` starts with a lower-case character, go to 11.
10. If a type named `i` is available, resolve to it and halt.
11. If the expression is not in untyped mode, go to 14
12. If `i` equals `__this__`, resolve to the `this` constant and halt.
13. Generate a local variable named `i`, resolve to it and halt.
14. Fail

For step 10, it is also necessary to define the resolution order of types:

1. If a type named `i` is imported (directly or as part of a module), resolve to it and halt.
2. If the current package contains a module named `i` with a type named `i`, resolve to it and halt.
3. If a type named `i` is available at top-level, resolve to it and halt.
4. Fail

For step 1 of this algorithm as well as steps 5 and 7 of the previous one, the order of import resolution is important:

* Imported modules and static extensions are checked from bottom to top with the first match being picked.
* Imports that come from [import.hx](type-system-import-defaults) files are considered to be at the top of affected modules, which means they have lowest priority. If multiple `import.hx` files affect a module, the ones in child directories have priority over the ones in parent directories.
* Within a given module, types are checked from top to bottom.
* For imports, a match is made if the name equals.
* For [static extensions](lf-static-extension), a match is made if the name equals and the first argument [unifies](type-system-unification). Within a given type being used as static extension, the fields are checked from top to bottom.





<!--label:type-system-untyped-->
### untyped

**Important note:** This syntax should be avoided whenever possible. The produced code cannot be properly checked by the Haxe compiler and so it may have type errors or other bugs that would be caught at compile time in regular code. Use only when absolutely necessary and when you know what you are doing.

It is possible to completely circumvent the type checker by prefixing an expression with the keyword `untyped`. The majority of type errors are not emitted inside an untyped expression. This is primarily used with the target-specific [code injection expressions](target-syntax).


