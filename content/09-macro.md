<!--label:macro-->
## Macros

Macros are without a doubt the most advanced feature in Haxe. They are often perceived as dark magic that only a select few are capable of mastering, yet there is nothing magical (and certainly nothing dark) about them.

> ##### Define: Abstract Syntax Tree (AST)
>
> The AST is the result of **parsing** Haxe code into a typed structure. This structure is exposed to macros through the types defined in the file `haxe/macro/Expr.hx` of the Haxe Standard Library.

![](assets/figures/macro-compilation-role.svg)

_Figure: The role of macros during compilation._

A basic macro is a **syntax-transformation**. It receives zero or more [expressions](expression) and also returns an expression. If a macro is called, it effectively inserts code at the place it was called from. In that respect, it could be compared to a preprocessor like `#define` in C++, but a Haxe macro is not a textual replacement tool.

We can identify different kinds of macros, which are run at specific compilation stages:

* Initialization Macros: These are provided by command line using the `--macro` compiler parameter. They are executed after the compiler arguments were processed and the **typer context** has been created, but before any typing was done (see [Initialization Macros](macro-initialization)).
* Build Macros: These are defined for classes, enums and abstracts through the `@:build` or `@:autoBuild` [metadata](lf-metadata). They are executed per type, after the type has been set up (including its relation to other types, such as inheritance for classes) but before its fields are typed (see [Type Building](macro-type-building)).
* Expression Macros: These are normal functions which are executed as soon as they are typed.

##### Related content

* See the [macro API documentation](http://api.haxe.org/haxe/macro) for details about its tools, classes an methods. 
* See the [macro snippets and tutorials](http://code.haxe.org/category/macros/) section in the Haxe Code Cookbook.

<!--label:macro-context-->
### Macro Context

> ##### Define: Macro Context
>
> The macro context is the environment in which the macro is executed. Depending on the macro type, it can be considered to be a class being built or a function being typed. Contextual information can be obtained through the `haxe.macro.Context` API.

Haxe macros have access to different contextual information depending on the macro type. Other than querying such information, the context also allows some modifications such as defining a new type or registering certain callbacks. It is important to understand that not all information is available for all macro kinds, as the following examples demonstrate:

* Initialization macros will find that the `Context.getLocal*()` methods return `null`. There is no local type or method in the context of an initialization macro.
* Only build macros get a proper return value from `Context.getBuildFields()`. There are no fields being built for the other macro kinds.
* Build macros have a local type (if incomplete), but no local method, so `Context.getLocalMethod()` returns `null`.

The context API is complemented by the `haxe.macro.Compiler` API detailed in [Initialization Macros](macro-initialization). While this API is available to all macro kinds, care has to be taken for any modification outside of initialization macros. This stems from the natural limitation of undefined [build order](macro-limitations-build-order), which could cause e.g. a flag definition through `Compiler.define()` to take effect before or after a [conditional compilation](lf-condition-compilation) check against that flag.

##### Related content

* See the [macro Context API documentation](http://api.haxe.org/haxe/macro/Context.html). 
* See the [macro snippets and tutorials](http://code.haxe.org/category/macros/) section in the Haxe Code Cookbook.



<!--label:macro-arguments-->
### Arguments

Most of the time, arguments to macros are expressions represented as an instance of enum `Expr`. As such, they are parsed but not typed, meaning they can be anything conforming to Haxe's syntax rules. The macro can then inspect their structure, or (try to) get their type using `haxe.macro.Context.typeof()`.

It is important to understand that arguments to macros are not guaranteed to be evaluated, so any intended side-effect is not guaranteed to occur. On the other hand, it is also important to understand that an argument expression may be duplicated by a macro and used multiple times in the returned expression:

[code asset](assets/MacroArguments.hx)

The macro `add` is called with `x++` as argument and thus returns `x++ + x++` using [expression reification](macro-reification-expression), causing `x` to be incremented twice.

<!--label:macro-ExprOf-->
#### ExprOf

Since `Expr` is compatible with any possible input, Haxe provides the type `haxe.macro.ExprOf<T>`. For the most part, this type is identical to `Expr`, but it allows constraining the type of accepted expressions. This is useful when combining macros with [static extensions](lf-static-extension):

[code asset](assets/ExprOf.hx)

The two direct calls to `identity` are accepted, even though the argument is declared as `ExprOf<String>`. It might come as a surprise that the `Int` `1` is accepted, but it is a logical consequence of what was explained about [macro arguments](macro-arguments): The argument expressions are never typed, so it is not possible for the compiler to check their compatibility by [unifying](type-system-unification).

This is different for the next two lines which are using static extensions (note the `using Main`): For these it is mandatory to type the left side (`"foo"` and `1`) first in order to make sense of the `identity` field access. This makes it possible to check the types against the argument types, which causes `1.identity()` to not consider `Main.identity()` as a suitable field.



<!--label:macro-constant-arguments-->
#### Constant Expressions

A macro can be declared to expect [constant](expression-constants) arguments:

[code asset](assets/MacroArgumentsConst.hx)

With these, it is not necessary to detour over expressions as the compiler can use the provided constants directly.



<!--label:macro-rest-argument-->
#### Rest Argument

If the final argument of a macro is of type `Array<Expr>`, the macro accepts an arbitrary number of extra arguments which are available from that array:

[code asset](assets/MacroArgumentsRest.hx)





<!--label:macro-reification-->
### Reification

The Haxe Compiler allows **reification** of expressions, types and classes to simplify working with macros. The syntax for reification is `macro expr`, where `expr` is any valid Haxe expression.

<!--label:macro-reification-expression-->
#### Expression Reification

Expression reification is used to create instances of `haxe.macro.Expr` in a convenient way. The Haxe Compiler accepts the usual Haxe syntax and translates it to an expression object. It supports several escaping mechanisms, all of which are triggered by the `$` character:

* `${}` and `$e{}`: `Expr -> Expr` This can be used to compose expressions. The expression within the delimiting `{ }` is executed, with its value being used in place.
* `$a{}`: `Array<Expr> -> Array<Expr>` or `Array<Expr> -> Expr` If used in a place where an `Array<Expr>` is expected (e.g. call arguments, block elements), `$a{}` treats its value as that array. Otherwise it generates an array declaration.
* `$b{}`: `Array<Expr> -> Expr` Generates a block expression from the given expression array.
* `$i{}`: `String -> Expr` Generates an identifier from the given string.
* `$p{}`: `Array<String> -> Expr` Generates a field expression from the given string array.
* `$v{}`: `Dynamic -> Expr` Generates an expression depending on the type of its argument. This is only guaranteed to work for [basic types](types-basic-types) and [enum instances](types-enum-instance).

Additionally the [metadata](lf-metadata) `@:pos(p)` can be used to map the position of the annotated expression to `p` instead of the place it is reified at.

This kind of reification only works in places where the internal structure expects an expression. This disallows `object.${fieldName}`, but `object.$fieldName` works. This is true for all places where the internal structure expects a string:

* field access `object.$name`
* variable name `var $name = 1;`

##### since Haxe 3.1.0

* field name `{ $name: 1} `
* function name `function $name() { }`
* catch variable name `try e() catch($name:Dynamic) { }`

Furthermore, a `new` expression can be reified by providing [haxe.macro.TypePath](http://api.haxe.org/haxe/macro/TypePath.html) argument: `new $typePath()`



<!--label:macro-reification-type-->
#### Type Reification

Type reification is used to create instances of `haxe.macro.Expr.ComplexType` in a convenient way. It is identified by a `macro : Type`, where `Type` can be any valid type path expression. This is similar to explicit type hints in normal code, e.g. for variables in the form of `var x:Type`.

Each constructor of `ComplexType` has a distinct syntax:

* `TPath`: `macro : pack.Type`
* `TFunction`: `macro : Arg1 -> Arg2 -> Return`
* `TAnonymous`: `macro : { field: Type }`
* `TParent`: `macro : (Type)`
* `TExtend`: `macro : {> Type, field: Type }`
* `TOptional`: `macro : ?Type`



<!--label:macro-reification-class-->
#### Class Reification

It is also possible to use reification to obtain an instance of `haxe.macro.Expr.TypeDefinition`. This is indicated by the `macro class` syntax as shown here:

[code asset](assets/ClassReification.hx)

The generated `TypeDefinition` instance is typically passed to `haxe.macro.Context.defineType` in order to add a new type to the calling context (not the macro context itself).

This kind of reification can also be useful to obtain instances of `haxe.macro.Expr.Field`, which are available from the `fields` array of the generated `TypeDefinition`.





<!--label:macro-tools-->
### Tools

The Haxe Standard Library comes with a set of tool-classes to simplify working with macros. These classes work best as [static extensions](lf-static-extension) and can be brought into context either individually or as a whole through `using haxe.macro.Tools`. These classes are:

* `ComplexTypeTools`: Allows printing `ComplexType` instances in a human-readable way. Also allows determining the `Type` corresponding to a `ComplexType`.
* `ExprTools`: Allows printing `Expr` instances in a human-readable way. Also allows iterating and mapping expressions.
* `MacroStringTools`: Offers useful operations on strings and string expressions in macro context.
* `TypeTools`: Allows printing `Type` instances in a human-readable way. Also offers several useful operations on types, such as [unifying](type-system-unification) them or getting their corresponding `ComplexType`.

Furthermore the `haxe.macro.Printer` class has public methods for printing various types as a human-readable format. This can be helpful when debugging macros.

> ##### Trivia: The tinkerbell library and why Tools.hx works
>
> We learned about static extensions that using a **module** implies that all its types are brought into static extension context. As it turns out, such a type can also be a [typedef](type-system-typedef) to another type. The compiler then considers this type part of the module, and extends static extension accordingly.
> 
> This "trick" was first used in Juraj Kirchheim's **tinkerbell** library for exactly the same purpose. Tinkerbell provided many useful macro tools long before they made it into the Haxe Compiler and Haxe Standard Library. It remains the primary library for additional macro tools and offers other useful functionality as well.



<!--label:macro-type-building-->
### Type Building

Type-building macros are different from expression macros in several ways:

* They do not return expressions, but an array of class fields. Their return type must be set explicitly to `Array<haxe.macro.Expr.Field>`.
* Their [context](macro-context) has no local method and no local variables.
* Their context does have build fields, available from `haxe.macro.Context.getBuildFields()`.
* They are not called directly, but are argument to a `@:build` or `@:autoBuild` [metadata](lf-metadata) on a [class](types-class-instance) or [enum](types-enum-instance) declaration.

The following example demonstrates type building. Note that it is split up into two files for a reason: If a module contains a `macro` function, it has to be typed into macro context as well. This is often a problem for type-building macros because the type to be built could only be loaded in its incomplete state, before the building macro has run. We recommend to always define type-building macros in their own module.

[code asset](assets/TypeBuildingMacro.hx)

[code asset](assets/TypeBuilding.hx)

The `build` method of `TypeBuildingMacro` performs three steps:

1. It obtains the build fields using `Context.getBuildFields()`.
2. It declares a new `haxe.macro.expr.Field` field using the `funcName` macro argument as field name. This field is a `String` [variable](class-field-variable) with a default value `"my default"` (from the `kind` field) and is public and static (from the `access` field).
3. It adds the new field to the build field array and returns it.

This macro is argument to the `@:build` metadata on the `Main` class. As soon as this type is required, the compiler does the following:

1. It parses the module file, including the class fields.
2. It sets up the type, including its relation to other types through [inheritance](types-class-inheritance) and [interfaces](types-interfaces).
3. It executes the type-building macro according to the `@:build` metadata.
4. It continues typing the class normally with the fields returned by the type-building macro.

This allows adding and modifying class fields at will in a type-building macro. In our example, the macro is called with a `"myFunc"` argument, making `Main.myFunc` valid field access.

If a type-building macro should not modify anything, the macro can return `null`. This indicates to the compiler that no changes are intended and is preferable to returning `Context.getBuildFields()`.

<!--label:macro-enum-building-->
#### Enum building

Building [enums](types-enum-instance) is analogous to building classes with a simple mapping:

* Enum constructors without arguments are variable fields `FVar`.
* Enum constructors with arguments are method fields `FFun`.

[code asset](assets/EnumBuildingMacro.hx)

[code asset](assets/EnumBuilding.hx)

Because enum `E` is annotated with a `:build` metadata, the called macro builds two constructors `A` and `B` "into" it. The former is added with the kind being `FVar(null, null)`, meaning it is a constructor without argument. For the latter, we use [reification](macro-reification-expression) to obtain an instance of `haxe.macro.Expr.Function` with a singular `Int` argument.

The `main` method proves the structure of our generated enum by [matching](lf-pattern-matching) it. We can see that the generated type is equivalent to this:

```haxe
enum E {
	A;
	B(value:Int);
}
```



<!--label:macro-auto-build-->
#### @:autoBuild

If a class has the `:autoBuild` metadata, the compiler generates `:build` metadata on all extending classes. If an interface has the `:autoBuild` metadata, the compiler generates `:build` metadata on all implementing classes and all extending interfaces. Note that `:autoBuild` does not imply `:build` on the class/interface itself.

[code asset](assets/AutoBuildingMacro.hx)

[code asset](assets/AutoBuilding.hx)

This outputs during compilation:

```
AutoBuildingMacro.hx:6:
  fromInterface: TInst(I2,[])
AutoBuildingMacro.hx:6:
  fromInterface: TInst(Main,[])
AutoBuildingMacro.hx:11:
  fromBaseClass: TInst(Main,[])
```

It is important to keep in mind that the order of these macro executions is undefined, which is detailed in [Build Order](macro-limitations-build-order).

##### Related content

* [Haxe snippets and tutorials about build macros](http://code.haxe.org/tag/build-macro.html) in the Haxe Code Cookbook.



<!--label:macro-generic-build-->
#### @:genericBuild

##### since Haxe 3.1.0

Normal [build-macros](macro-type-building) are run per-type and are already very powerful. In some cases it is useful to run a build macro per type **usage** instead, i.e. whenever it actually appears in the code. Among other things, this allows accessing the concrete type parameters in the macro.

`@:genericBuild` is used just like `@:build` by adding it to a type with the argument being a macro call:

[code asset](assets/GenericBuildMacro1.hx)

[code asset](assets/GenericBuild1.hx)

When running this example the compiler outputs `TAbstract(Int,[])` and `TInst(String,[])`, indicating that it is indeed aware of the concrete type parameters of `MyType`. The macro logic could use this information to generate a custom type (using `haxe.macro.Context.defineType`) or refer to an existing one. For brevity we return `null` here which asks the compiler to [infer](type-system-type-inference) the type.

In Haxe 3.1 the return type of a `@:genericBuild` macro has to be a `haxe.macro.Type`. Haxe 3.2 allows (and prefers) returning a `haxe.macro.ComplexType` instead, which is the syntactic representation of a type. This is easier to work with in many cases because types can simply be referenced by their paths.

##### Const type parameter

Haxe allows passing [constant expression](expression-constants) as a type parameter if the type parameter name is `Const`. This can be utilized in the context of `@:genericBuild` macros to pass information from the syntax directly to the macro:

[code asset](assets/GenericBuildMacro2.hx)

[code asset](assets/GenericBuild2.hx)

Here the macro logic could load a file and use its contents to generate a custom type.

##### Related content

* [Haxe snippets and tutorials about build macros](http://code.haxe.org/tag/build-macro.html) in the Haxe Code Cookbook.





<!--label:macro-limitations-->
### Limitations

<!--subtoc-->

<!--label:macro-limitations-macro-in-macro-->
#### Macro-in-Macro

Build macros cannot be invoked from a macro context. This means it is impossible to use a macro to create a class which will provide build macros for other classes.

##### since Haxe 4.0.0

It is also disallowed to invoke expression macros in a macro context.

> ##### Trivia: Expression macro-in-macro
>
> Prior to Haxe 4, using expression macros inside a macro context was possible. Support was primarily dropped because such code would cause issues with the compiler cache.



<!--label:macro-limitations-static-extension-->
#### Static extension

The concepts of [static extensions](lf-static-extension) and macros are somewhat conflicting: While the former requires a known type in order to determine used functions, macros execute before typing on plain syntax. It is thus not surprising that combining these two features can lead to issues. Haxe 3.0 would try to convert the typed expression back to a syntax expression, which is not always possible and may lose important information. We recommend that it is used with caution.

##### since Haxe 3.1.0

The combination of static extensions and macros was reworked for the 3.1.0 release. The Haxe Compiler does not even try to find the original expression for the macro argument and instead passes a special `@:this this` expression. While the structure of this expression conveys no information, the expression can still be typed correctly:

[code asset](assets/MacroStaticExtension.hx)



<!--label:macro-limitations-build-order-->
#### Build Order

The build order of types is unspecified and this extends to the execution order of [build-macros](macro-type-building). While certain rules can be determined, we strongly recommend to not rely on the execution order of build-macros. If type building requires multiple passes, this should be reflected directly in the macro code. In order to avoid multiple build-macro executions on the same type, the state can be stored in [persistent variables](macro-persistent-variables) or added as [metadata](lf-metadata) to the type in question:

[code asset](assets/MacroBuildOrder.hx)

With both interfaces `I1` and `I2` having `:autoBuild` metadata, the build macro is executed twice for class `C`. We guard against duplicate processing by adding a custom `:processed` metadata to the class, which can be checked during the second macro execution.



<!--label:macro-limitations-type-parameters-->
#### Type Parameters

<!--subtoc-->





<!--label:macro-persistent-variables-->
### Persistent Variables

When using macros in combination with the [completion server](cr-completion-server), certain values obtained in a build or initialization macro can be retained for the next time the macro is executed. This is useful if obtaining the values is resource-intensive, or if the macro needs to keep track of previous builds. To mark a static field as persistent across macro builds, it should be annotated with the `:persistent` metadata.

As an example, here is `Welcome.hx`:

```haxe
import haxe.macro.Expr;

class Welcome {
  @:persistent static var firstBuild:Bool = true;

  public static build():Array<Field> {
    if (firstBuild) {
      trace("congratulations on your first build!");
      firstBuild = false;
    }
    return null;
  }
}
```

And `Main.hx`:

```haxe
@:build(Welcome.build())
class Main {
  public static function main() {}
}
```

After starting the completion server with `haxe --wait 6000`, we perform a build with `haxe --connect 6000 --main Main --no-output`. The first time the congratulatory message is printed during compilation. If we execute the same command again, however, it is not - the `firstBuild` variable retains the value `false` from the previous build.



<!--label:macro-initialization-->
### Initialization Macros

Initialization macros are invoked from the command line by using the `--macro callExpr(args)` command. This registers a callback which the compiler invokes after creating its context, but before typing the argument to `--main`. This then allows configuring the compiler in some ways.

If the argument to `--macro` is a call to a plain identifier, that identifier is looked up in the class `haxe.macro.Compiler` which is part of the Haxe Standard Library. It comes with several useful initialization macros which are detailed in its [API](http://api.haxe.org//haxe/macro/Compiler.html).

As an example, the `include` macro allows the inclusion of an entire package for compilation, recursively if necessary. The command line argument for this would then be `--macro include('some.pack', true)`.

Of course it is also possible to define custom initialization macros to perform various tasks before the real compilation. A macro like this would then be invoked via `--macro some.Class.theMacro(args)`. For instance, as all macros share the same [context](macro-context), an initialization macro could set the value of a static field which other macros use as configuration.


