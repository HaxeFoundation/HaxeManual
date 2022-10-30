<!--label:class-field-->
## Class Fields

> ##### Define: Class Field
>
> A class field is a variable, property or method of a class which can either be static or non-static. Non-static fields are referred to as **member** fields, so we speak of e.g. a **static method** or a **member variable**.

So far we have seen how types and Haxe programs, in general, are structured. This section about class fields concludes the structural part and at the same time bridges to the behavioral part of Haxe. This is because class fields are the place where [expressions](expression) are at home.

There are three kinds of class fields:

* Variable: A [variable](class-field-variable) class field holds a value of a certain type, which can be read or written.
* Property: A [property](class-field-property) class field defines a custom access behavior for something that, outside the class, looks like a variable field.
* Method: A [method](class-field-method) is a function which can be called to execute code.

Strictly speaking, a variable could be considered to be a property with certain access modifiers. Indeed, the Haxe Compiler does not distinguish variables and properties during its typing phase, but they remain separated at the syntax level.

Regarding terminology, a method is a (static or non-static) function belonging to a class. Other functions, such as a [local functions](expression-arrow-function) in expressions, are not considered methods.

<!--label:class-field-variable-->
### Variable

We have already seen variable fields in several code examples of previous sections. Variable fields hold values, a characteristic which they share with most (but not all) properties:

[code asset](assets/VariableField.hx)

We can learn from this that a variable

1. has a name (here: `example`),
2. has a type (here: `String`),
3. may have a constant initialization (here: `"bar"`) and
4. may have [access modifiers](class-field-access-modifier) (here: `static`)

The example first prints the initialization value of `example`, then sets it to `"foo"` before printing its new value. The effect of access modifiers is shared by all three class field kinds and explained in a separate section.

It should be noted that the explicit type is not required if there is an initialization value. The compiler will [infer](type-system-type-inference) it in this case.

![](assets/figures/class-field-variable-init-values.svg)

_Figure: Initialization values of a variable field._



<!--label:class-field-property-->
### Property

Next to [variables](class-field-variable), properties are the second option for dealing with data on a class. Unlike variables, however, they offer more control of which kind of field access should be allowed and how it should be generated. Common use cases include:

* Have a field which can be read from anywhere but only be written from within the defining class.
* Have a field which invokes a **getter**-method upon read-access.
* Have a field which invokes a **setter**-method upon write-access.

When dealing with properties, it is important to understand the two kinds of access:

> ##### Define: Read Access
>
> A read access to a field occurs when a right-hand side [field access expression](expression-field-access) is used. This includes calls in the form of `obj.field()`, where `field` is accessed to be read.

> ##### Define: Write Access
>
> A write access to a field occurs when a [field access expression](expression-field-access) is assigned a value in the form of `obj.field = value`. It may also occur in combination with [read access](define-read-access) for special assignment operators such as `+=` in expressions like `obj.field += value`.
 

Read access and write access are directly reflected in the syntax, as the following example shows:

[code asset](assets/Property.hx)

For the most part, the syntax is similar to variable syntax, and the same rules indeed apply. Properties are identified by

* the opening parenthesis `(` after the field name,
* followed by a special **access identifier** (here: `default`),
* with a comma `,` separating
* another special access identifier (here: `null`)
* before a closing parenthesis `)`.

The access identifiers define the behavior when the field is read (first identifier) and written (second identifier). The accepted values are:

* `default`: Allows normal field access if the field has public visibility, otherwise equal to `null` access.
* `null`: Allows access only from within the defining class.
* `get`/`set`: Access is generated as a call to an **accessor method**. The compiler ensures that the accessor is available.
* `dynamic`: Like `get`/`set` access, but does not verify the existence of the accessor field.
* `never`: Allows no access at all.

> ##### Define: Accessor method
>
> An **accessor method** (or short **accessor**) for a field named `field` of type `T` is a **getter** named `get_field` of type `Void->T` or a **setter** named `set_field` of type `T->T`.

> ##### Trivia: Accessor names
>
> In Haxe 2, arbitrary identifiers were allowed as access identifiers and would lead to custom accessor method names to be admitted. This made parts of the implementation quite tricky to deal with. In particular, `Reflect.getProperty()` and `Reflect.setProperty()` had to assume that any name could have been used, requiring the target generators to generate meta-information and perform lookups.
> 
> We disallowed these identifiers and went for the `get_` and `set_` naming convention which greatly simplified implementation. This was one of the breaking changes between Haxe 2 and 3.

<!--label:class-field-property-common-combinations-->
#### Common accessor identifier combinations

The next example shows common access identifier combinations for properties:

[code asset](assets/Property2.hx)

The JavaScript output helps understand what the field access in the `main`-method is compiled to:

```js
var Main = function() {
	var v = this.get_x();
	this.set_x(2);
	var _g = this;
	_g.set_x(_g.get_x() + 1);
};
```

As specified, the read access generates a call to `get_x()`, while the write access generates a call to `set_x(2)` where `2` is the value being assigned to `x`. The way the `+=` is being generated might look a little odd at first, but can easily be justified by the following example:

[code asset](assets/Property3.hx)

What happens here is that the expression part of the field access to `x` in the `main` method is **complex**: It has potential side-effects, such as the construction of `Main` in this case. Thus, the compiler cannot generate the `+=` operation as `new Main().x = new Main().x + 1` and has to cache the complex expression in a local variable:

```js
Main.main = function() {
	var _g = new Main();
	_g.set_x(_g.get_x() + 1);
}
```



<!--label:class-field-property-type-system-impact-->
#### Impact on the type system

The presence of properties has several consequences on the type system. Most importantly, it is necessary to understand that properties are a compile-time feature and thus **require the types to be known**. If we were to assign a class with properties to `Dynamic`, field access would **not** respect accessor methods. Likewise, access restrictions no longer apply and all access is virtually public.

When using `get` or `set` access identifier, the compiler ensures that the getter and setter actually exists. The following code snippet does not compile:

[code asset](assets/Property4.hx)

The method `get_x` is missing, but it need not be declared on the class defining the property itself as long as a parent class defines it:

[code asset](assets/Property5.hx)

The `dynamic` access modifier works exactly like `get` or `set`, but does not check for the existence.



<!--label:class-field-property-rules-->
#### Rules for getter and setter

Visibility of accessor methods has no effect on the accessibility of its property. That is, if a property is `public` and defined to have a getter, that getter may be defined as `private` regardless.

Both getter and setter may access their physical field for data storage. The compiler ensures that this kind of field access does not go through the accessor method when made from within the accessor method itself, thus avoiding infinite recursion:

[code asset](assets/GetterSetter.hx)

However, the compiler assumes that a physical field exists only if at least one of the access identifiers is `default` or `null`.

> ##### Define: Physical field
>
> A field is considered to be **physical** if it is either
> 
> * a [variable](class-field-variable)
> * a [property](class-field-property) with the read-access or write-access identifier being `default` or `null`
> * a [property](class-field-property) with `:isVar` [metadata](lf-metadata)
> 
> 

If this is not the case, access to the field from within an accessor method causes a compilation error:

[code asset](assets/GetterSetter2.hx)

If a physical field is indeed intended, it can be forced by attributing the field in question with the `:isVar` [metadata](lf-metadata):

[code asset](assets/GetterSetter3.hx)

> ##### Trivia: Property setter type
>
> It is not uncommon for new Haxe users to be surprised by the type of a setter being required to be `T->T` instead of the seemingly more natural `T->Void`. After all, why would a **setter** have to return something?
> 
> The rationale is that we still want to be able to use field assignments using setters as right-side expressions. Given a chain like `x = y = 1`, it is evaluated as `x = (y = 1)`. In order to assign the result of `y = 1` to `x`, the former must have a value. If `y` had a setter returning `Void`, this would not be possible.





<!--label:class-field-method-->
### Method

While [variables](class-field-variable) hold data, methods are defining behavior of a program by hosting [expressions](expression). We have seen method fields in every code example of this document with even the initial [Hello World](introduction-hello-world) example containing a `main` method:

[code asset](assets/HelloWorld.hx)

Methods are identified by the `function` keyword. We can also learn that they

1. have a name (here: `main`),
2. have an argument list (here: empty `()`),
3. have a return type (here: `Void`),
4. may have [access modifiers](class-field-access-modifier) (here: `static` and `public`) and
5. may have an expression (here: `{trace("Hello World");}`).

We can also look at the next example to learn more about arguments and return types:

[code asset](assets/MethodField.hx)

Arguments are given by an opening parenthesis `(` after the field name, a comma `,` separated list of argument specifications and a closing parenthesis `)`. Additional information on the argument specification is described in [Function Type](types-function).

The example demonstrates how [type inference](type-system-type-inference) can be used for both argument and return types. The method `myFunc` has two arguments but only explicitly gives the type of the first one, `f`, as `String`. The second one, `i`, is not type-hinted and it is left to the compiler to infer its type from calls made to it. Likewise, the return type of the method is inferred from the `return true` expression as `Bool`.

<!--label:class-field-overriding-->
#### Overriding Methods

Overriding fields is instrumental for creating class hierarchies. Many design patterns utilize it, but here we will explore only the basic functionality. In order to use overrides in a class, it is required that this class has a [parent class](types-class-inheritance). Let us consider the following example:

[code asset](assets/Override.hx)

The important components here are:

* the class `Base` which has a method `myMethod` and a constructor,
* the class `Child` which `extends Base` and also has a method `myMethod` being declared with `override`, and
* the `Main` class whose `main` method creates an instance of `Child`, assigns it to a variable `child` of explicit type `Base` and calls `myMethod()` on it.

The variable `child` is explicitly typed as `Base` to highlight an important difference: At compile-time the type is known to be `Base`, but the runtime still finds the correct method `myMethod` on class `Child`. This is because field access is resolved dynamically at runtime.

The `Child` class can access methods it has overridden by calling `super.methodName()`:

[code asset](assets/OverrideCallParent.hx)

The section on [Inheritance](types-class-inheritance) explains the use of `super()` from within a `new` constructor.



<!--label:class-field-override-effects-->
#### Effects of variance and access modifiers

Overriding adheres to the rules of [variance](type-system-variance). That is, their argument types allow **contravariance** (less specific types) while their return type allows **covariance** (more specific types):

[code asset](assets/OverrideVariance.hx)

Intuitively, this follows from the fact that arguments are "written to" the function and the return value is "read from" it.

The example also demonstrates how [visibility](class-field-visibility) may be changed: An overriding field may be `public` if the overridden field is `private`, but not the other way around.

It is not possible to override fields which are declared as [`inline`](class-field-inline). This is due to the conflicting concepts: While inlining is done at compile-time by replacing a call with the function body, overriding fields necessarily have to be resolved at runtime.





<!--label:class-field-access-modifier-->
### Access Modifier

<!--subtoc-->

<!--label:class-field-visibility-->
#### Visibility

Fields are by default **private**, meaning that only the class and its sub-classes may access them. They can be made **public** by using the `public` access modifier, allowing access from anywhere.

[code asset](assets/Visibility.hx)

Access to field `available` of class `MyClass` is allowed from within `Main` because it is denoted as being `public`. However, while access to field `unavailable` is allowed from within class `MyClass`, it is not allowed from within class `Main` because it is `private` (explicitly, although this identifier is redundant here).

The example demonstrates visibility through **static** fields, but the rules for member fields are equivalent. The following example demonstrates visibility behavior for when [inheritance](types-class-inheritance) is involved.

[code asset](assets/Visibility2.hx)

We can see that access to `child1.baseField()` is allowed from within `Child2` even though `child1` is of a different type, `Child1`. This is because the field is defined on their common ancestor class `Base`, contrary to field `child1Field` which can not be accessed from within `Child2`.

Omitting the visibility modifier usually defaults the visibility to `private`, but there are exceptions where it becomes `public` instead:

1. If the class is declared as `extern`.
2. If the field is declared on an [interface](types-interfaces).
3. If the field [overrides](class-field-overriding) a public field.
4. If the class has metadata `@:publicFields`, which forces all class fields of inheriting classes to be public.

> ##### Trivia: Protected
>
> Haxe does not support the `protected` keyword known from many other object-oriented programming languages like Java and C++. However, Haxe's `private` behaves similarly to `protected` in other languages, but does not allow access from non-inheriting classes in the same package.



<!--label:class-field-inline-->
#### Inline

##### Inline functions

The `inline` keyword allows function bodies to be directly inserted in place of calls to them. This can be a powerful optimization tool but should be used judiciously as not all functions are good candidates for inline behavior. The following example demonstrates the basic usage:

[code asset](assets/Inline.hx)

The generated JavaScript output reveals the effect of inline:

```js
(function () { "use strict";
var Main = function() { }
Main.main = function() {
	var a = 1;
	var b = 2;
	var c = (a + b) / 2;
}
Main.main();
})();
```

As evident, the function body `(s1 + s2) / 2` of field `mid` was generated in place of the call to `mid(a, b)`, with `s1` being replaced by `a` and `s2` being replaced by `b`. This avoids a function call which, depending on the target and frequency of occurrences, may yield noticeable performance improvements.

It is not always easy to judge if a function qualifies for being inline. Short functions that have no writing expressions (such as a `=` assignment) are usually a good choice, but even more complex functions can be candidates. However, in some cases, inlining can actually be detrimental to performance, e.g. because the compiler has to create temporary variables for complex expressions.

Inline is not guaranteed to be done. The compiler might cancel inlining for various reasons or a user could supply the `--no-inline` command line argument to disable inlining. The only exception is if the class is [extern](lf-externs) or if the class field has the [`extern`](class-field-extern) access modifier, in which case inline is forced. If it cannot be done, the compiler emits an error.

It is important to remember this when relying on inline:

[code asset](assets/InlineRelying.hx)

If the call to `error` is inlined the program compiles correctly because the control flow checker is satisfied due to the inlined [throw](expression-throw) expression. If inline is not done, the compiler only sees a function call to `error` and emits the error `A return is missing here`.

Since Haxe 4 it is also possible to inline specific calls to a function or constructor, see [`inline` expression](expression-inline).

##### Inline variables

The `inline` keyword can also be applied to variables, but only when used together with `static`. An inline variable must be initialized to a [constant](expression-constants), otherwise the compiler emits an error. The value of the variable is used everywhere in place of the variable itself.

The following code demonstrates the usage of an inline variable:

[code asset](assets/InlineVariable.hx)

The generated JavaScript shows that the `language` variable is not present anymore:

```js
(function ($global) { "use strict";
var Main = function() { };
Main.main = function() {
	console.log("root/program/Main.hx:5:","Haxe");
};
Main.main();
})({});
```

Note that even though we call such kind of fields "variables", inline variables can never be reassigned as the value must be known at compile-time to be inlined at the place of usage. This makes inline variables a subset of [`final` fields](class-field-final), hence the usage of the `final` keyword in the code example above.

> ##### Trivia: `inline var`
>
> Prior to Haxe 4, there was no `final` keyword. The inline variables feature however was present for a long time, using the `var` keyword instead of `final`. Using `inline var` still works in Haxe 4 but might be deprecated in the future, because `final` is more appropriate.

<!--label:class-field-dynamic-->
#### Dynamic

Methods can be denoted with the `dynamic` keyword to make them (re-)bindable:

[code asset](assets/DynamicFunction.hx)

The first call to `test()` invokes the original function which returns the `String` `"original"`. In the next line, `test` is **assigned** a new function. This is precisely what `dynamic` allows: Function fields can be assigned a new function. As a result, the next invocation of `test()` returns the `String` `"new"`.

Dynamic fields cannot be `inline` for obvious reasons: While inlining is done at compile-time, dynamic functions necessarily have to be resolved at runtime.



<!--label:class-field-override-->
#### Override

The access modifier `override` is required when a field is declared which also exists on a [parent class](types-class-inheritance). Its purpose is to ensure that the author of a class is aware of the override as this may not always be obvious in large class hierarchies. Likewise, having `override` on a field which does not actually override anything (e.g. due to a misspelt field name) triggers an error.

The effects of overriding fields are detailed in [Overriding Methods](class-field-overriding). This modifier is only allowed on [method](class-field-method) fields.



<!--label:class-field-static-->
#### Static

All fields are member fields unless the modifier `static` is used. Static fields are used "on the class" whereas non-static fields are used "on a class instance":

[code asset](assets/StaticField.hx)

Static [variable](class-field-variable) and [property](class-field-property) fields can have arbitrary initialization [expressions](expression).



<!--label:class-field-extern-->
#### Extern

##### since Haxe 4.0.0

The `extern` keyword causes the compiler to not generate the field in the output. This can be used in combination with the [`inline`](class-field-inline) keyword to force a field to be inlined (or cause an error if this is not possible). Forcing inline may be desirable in abstracts or extern classes.

> ##### Trivia: `:extern` metadata
>
> Prior to Haxe 4, this access modifier could only be applied to a field using the `:extern` [metadata](lf-metadata).



<!--label:class-field-final-->
#### Final

##### since Haxe 4.0.0

The `final` keyword can be used on class fields with the following effects:

* `final function ...` to make a function non-overridable in subclasses.
* `final x = ...` to declare a constant that must be initialized immediately or in the constructor and cannot be written to.
* `inline final x = ...` is the same but [inlines](class-field-inline) the value wherever it is used. Only constant values can be assigned.

`static final` fields must be initialized immediately by providing an expression. If a class has non-static `final` variables which are not initialized immediately, it requires a constructor which has to assign values to all such fields. `final` does not affect [visibility](class-field-visibility) and it is not supported on [properties](class-field-property). The `final` keyword can also be added to the class declaration preventing it from being extended.




