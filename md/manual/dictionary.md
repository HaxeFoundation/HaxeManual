##### Abstract Syntax Tree (AST)
The AST is the result of **parsing** Haxe code into a typed structure. This structure is exposed to macros through the types defined in the file `haxe/macro/Expr.hx` of the Haxe standard library.

##### Bool
Represents a value which can be either **true** or **false**

##### Class Field
A class field is a variable, property or method of a class which can either be static or non-static. Non-static fields are referred to as **member** fields, so we speak of e.g. a **static method** or a **member variable**.

##### Class<T>
This type is compatible with all class types. At compile-time, `Class<T>` can be considered to be the common base type of all class types. However, this relation is not reflected in generated code.

##### Compiler Flag
A compiler flag is a configurable value which may influence the compilation process. Such a flag can be set by invoking the command line with `-D key=value` or just `-D key`, in which case the value defaults to `"1"`. The compiler also sets several flags internally to pass information between different compilation steps.

##### Dynamic target
Dynamic targets are more lenient with their types and allow *null* values for basic types. They const is JavaScript, PHP, neko and Flash 6-8.

##### Enum
This type is compatible with all enum types. At compile-time, `Enum<T>` can be considered to be the common base type of all enum types. However, this relation is not reflected in generated code.

##### EnumValue
EnumValue is a special type which unifies with all enum instances. It is used by the standard library to provide some operations for all enum instances, and can be employed in user-code accordingly.

##### Float
Represents a double-precision IEEE 64bit floating point number.

##### Int
Represents a 32bit integral number.

##### Macro Context
The macro context is the environment in which the macro is executed. Depending on the macro type, it can be considered to be a class being built or a function being typed. Contextual information can be obtained through the `haxe.macro.Context` API.

##### Module
All haxe code is organized in modules, which are addressed using paths. In essence, each .hx file represents a module which may contain several types.

##### Name
Description

##### nullable
A type in haxe is considered **nullable** if `null` is a valid value for it.

##### Static Extension
A static extension allows pseudo-extending existing types without modifying their source. In Haxe this is achieved by declaring a static method with a first argument of the extending type and then bringing the defining class into context through `using`.

##### Static target
Static targets employ their own type system where `null` is not a valid value for basic types. This is true for the Flash 9+, C++, Java and C# targets.

##### String
A String is a sequence of characters.

##### Structural Subtyping
Structural subtyping defines an implicit relation between types that have the same structure.

##### type
type is a compile-time mechanism being called like a function, with a single argument. The compiler evaluates the argument expression and then outputs the type of that expression.

##### Underlying Type
The underlying type of an abstract is the type which is used to represent said abstract at runtime. It is usually a concrete (i.e. non-abstract) type, but could be another abstract type as well.

##### Unification
Unification between two types A and B is a directional process which answers the question if A **can be assigned to** B. It may **mutate** either type if it is or has a [Monomorph](https://github.com/Simn/HaxeManual/tree/master/md/manual/2.9-Monomorph.md).

##### Void
Void denote the absence of a type. It is used to express that something (usually a function) has no value.