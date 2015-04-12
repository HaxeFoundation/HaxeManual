## 8.5.1 RTTI structure

###### General type information

* path: The [type path](dictionary.md#define-type-path) of the type.
* module: The type path of the [module](dictionary.md#define-module) containing the type.
* file: The full slash path of the .hx file containing the type. This might be `null` in case there is no such file, e.g. if the type is defined through a [macro](macro.md).
* params: An array of strings representing the names of the [type parameters](type-system-type-parameters.md) the type has. As of Haxe 3.2.0, this does not include the [constraints](type-system-type-parameter-constraints.md).
* doc: The documentation of the type. This information is only available if the [compiler flag](dictionary.md#define-compiler-flag) `-D use_rtti_doc` was in place. Otherwise, or if the type has no documentation, the value is `null`.
* isPrivate: Whether or not the type is [private](dictionary.md#define-private-type).
* platforms: A list of strings representing the targets where the type is available.
* meta: The meta data the type was annotated with.

###### Class type information

* isExtern: Whether or not the class is [extern](lf-externs.md).
* isInterface: Whether or not the class is actually an [interface](types-interfaces.md).
* superClass: The class' parent class defined by its type path and list of type parameters.
* interfaces: The list of interfaces defined by their type path and list of type parameters.
* fields: The list of member [class fields](class-field.md), described in [Class field information](cr-rtti-structure.md#class-field-information).
* statics: The list of static class fields, described in [Class field information](cr-rtti-structure.md#class-field-information).
* tdynamic: The type which is [dynamically implemented](types-dynamic-implemented.md) by the class or `null` if no such type exists.

###### Enum type information

* isExtern: Whether or not the enum is [extern](lf-externs.md).
* constructors: The list of enum constructors.

###### Abstract type information

* to: An array containing the defined [implicit to casts](types-abstract-implicit-casts.md).
* from: An array containing the defined [implicit from casts](types-abstract-implicit-casts.md).
* impl: The [class type information](cr-rtti-structure.md#class-type-information) of the implementing class.
* athis: The [underlying type](dictionary.md#define-underlying-type) of the abstract.

###### Class field information

* name: The name of the field.
* type: The type of the field.
* isPublic: Whether or not the field is [public](class-field-visibility.md).
* isOverride: Whether or not the field [overrides](class-field-override.md) another field.
* doc: The documentation of the field. This information is only available if the [compiler flag](dictionary.md#define-compiler-flag) `-D use_rtti_doc` was in place. Otherwise, or if the field has no documentation, the value is `null`.
* get: The [read access behavior](dictionary.md#define-read-access) of the field.
* set: The [write access behavior](dictionary.md#define-write-access) of the field.
* params: An array of strings representing the names of the [type parameters](type-system-type-parameters.md) the field has. As of Haxe 3.2.0, this does not include the [constraints](type-system-type-parameter-constraints.md).
* platforms: A list of strings representing the targets where the field is available.
* meta: The meta data the field was annotated with.
* line: The line number where the field is defined. This information is only available if the field has an expression. Otherwise the value is `null`.
* overloads: The list of available overloads for the fields or `null` if no overloads exists.

###### Enum constructor information

* name: The name of the constructor.
* args: The list of arguments the constructor has or `null` if no arguments are available.
* doc: The documentation of the constructor. This information is only available if the [compiler flag](dictionary.md#define-compiler-flag) `-D use_rtti_doc` was in place. Otherwise, or if the constructor has no documentation, the value is `null`.
* platforms: A list of strings representing the targets where the constructor is available.
* meta: The meta data the constructor was annotated with.

---

Previous section: [Runtime Type Information](cr-rtti.md)

Next section: [Macros](macro.md)