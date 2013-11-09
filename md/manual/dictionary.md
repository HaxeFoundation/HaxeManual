##### Abstract Syntax Tree (AST)
The AST is the result of **parsing** Haxe code into a typed structure. This structure is exposed to macros through the types defined in the file `haxe/macro/Expr.hx` of the Haxe standard library.

##### Accessor method
An **accessor method** (or short **accessor**) for a field named `field` of type `T` is a **getter** named `get_field` of type `Void->T` or a **setter** named `set_field` of type `T->T`.

##### Bool
Represents a value which can be either **true** or **false**

##### Class Field
A class field is a variable, property or method of a class.  It can either be static or non-static. Non-static fields are referred to as **member** fields, so we speak of e.g. a **static method** or a **member variable**.

##### Class<T>
This type is compatible with all class types. At compile-time, `Class<T>` can be considered the common base type of all class types. However, this relation is not reflected in generated code.

##### Compiler Flag
A compiler flag is a configurable value which may influence the compilation process. Such a flag can be set by invoking the command line with `-D key=value` or just `-D key`, in which case the value defaults to `"1"`. The compiler also sets several flags internally to pass information between different compilation steps.

##### Compound Type
A compound type is a type which has sub-types. This includes any type with [type parameters](3.2-Type_Parameters.md) and the [function](2.6-Function.md) type.

##### Contravariance
A [compound type](dictionary.md#compound-type) is considered contravariant if its component types can be assigned to less generic components, i.e. if they are only written, but never read.

##### Covariance
A [compound type](dictionary.md#compound-type) is considered covariant if its component types can be assigned to less specific components, i.e. if they are only read, but never written.

##### Definition name
Definition description

##### Dynamic target
Dynamic targets are more lenient with their types and allow null values for basic types. They consist of JavaScript, PHP, neko and Flash 6-8.

##### Enum
This type is compatible with all enum types. At compile-time, `Enum<T>` can be considered to be the common base type of all enum types. However, this relation is not reflected in generated code.

##### EnumValue
EnumValue is a special type which unifies with all enum instances. It is used by the standard library to provide some operations for all enum instances, and can be employed in user-code accordingly.

##### Expected Type
Expected types occur when the type of an expression is known before that expression has been typed, e.g. because the expression is argument to a function call. They can influence typing of that expression through what is called [top-down inference](3.6.1-Top-down_Inference.md).

##### Float
Represents a double-precision IEEE 64bit floating point number.

##### Generic Type Parameter
A type parameter is said to be generic if its containing class or method is generic.

##### Int
Represents a 32bit integral number.

##### Local Function
A local function is declared using the **function** keyword without a name.  Local functions are values like literal integers or strings and can access local and static variables from their defining class

##### Macro Context
The macro context is the environment in which the macro is executed. Depending on the macro type, it can be considered to be a class being built or a function being typed. Contextual information can be obtained through the `haxe.macro.Context` API.

##### Module
All haxe code is organized in modules, which are addressed using paths. In essence, each .hx file represents a module which may contain several types. A type may be `private`, in which case only its containing module can access it.

##### Name
A general name may refer to


* a type,
* a local variable,
* a local function or
* a field.



##### nullable
A type in haxe is considered **nullable** if `null` is a valid value for it.

##### Physical field
A **physical field** means there is an actual variable for data storage.  A field is considered to be **physical** if it is:


* a [variable](4.1-Variable.md)
* a [property](4.2-Property.md) with the read-access or write-access identifier being `default` or `null`
* a [property](4.2-Property.md) with `:isVar` [metadata](7.9-Metadata.md)




##### Read Access
A read access to a field occurs when a right-hand side [field access expression](5.8-Field_Access.md) is used. This includes calls in the form of `obj.field()`, where `field` is accessed to be read.

##### Static Extension
A static extension allows pseudo-extending existing types without modifying their source. In Haxe this is achieved by declaring a static method with a first argument of the extending type and then bringing the defining class into context through `using`.

##### Static target
`null` is not a valid value for basic types. This is true for the Flash 9+, C++, Java and C# targets.

##### String
A String is a sequence of characters.

##### Structural Subtyping
Structural subtyping defines an implicit relation between types that have the same structure.

##### type
type is a compile-time mechanism being called like a function, with a single argument. The compiler evaluates the argument expression and then outputs the type of that expression.

##### Type path
The (dot-)path to a type consists of the package, the module name and the type name. Its general form is `pack1.pack2.packN.ModuleName.TypeName`.

##### Underlying Type
The underlying type is the type which is used to represent an abstract at runtime. It is usually a concrete (i.e. non-abstract) type, but could be another abstract type as well.

##### Unification
Unification between two types A and B is a directional process which answers the question if A **can be assigned to** B. It may **mutate** either type if it is or has a [monomorph](2.9-Monomorph.md).

##### Valid Identifier
a valid Haxe identifier must start with an underscore `_`, a dollar `$`, a lower-case character `a-z` or an upper-case character `A-Z`. After that, any combination and number of `_`, `A-Z`, `a-z` and `0-9` may follow.

Further limitations follow from the usage context, which is checked upon typing:


* Type names must start with an upper-case letter `A-Z` or an underscore `_`.
* Leading dollars are not allowed for any kind of [name](dictionary.md#name) (dollar-names are mostly used for [macro reification](8.3-Reification.md)).



##### Void
Void denote the absence of a type. It is used to express that something (usually a function) has no value.

##### Write Access
A write access to a field occurs when a [field access expression](5.8-Field_Access.md) is assigned a value in the form of `obj.field = value`. It may also occur in combination with [read access](dictionary.md#read-access) for special assignment operators such as `+=` in expressions like `obj.field += value`.