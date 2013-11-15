## 4.2 Property

Next to [variables](class-field-variable.md), properties are the second option for dealing with data on a class. Unlike variables however, they offer more control of which kind of field access should be allowed and how it should be generated. Common use cases include:



* Have a field which can be read from anywhere, but only be written from within the defining class.
* Have a field which invokes a **getter**-method upon read-access.
* Have a field which invokes a **setter**-method upon write-access.



When dealing with properties, it is important to understand the two kinds of access:

> ##### Define: Read Access
>
> A read access to a field occurs when a right-hand side [field access expression](expression-field-access.md) is used. This includes calls in the form of `obj.field()`, where `field` is accessed to be read.


> ##### Define: Write Access
>
> A write access to a field occurs when a [field access expression](expression-field-access.md) is assigned a value in the form of `obj.field = value`. It may also occur in combination with [read access](dictionary.md#read-access) for special assignment operators such as `+=` in expressions like `obj.field += value`.
 

Read access and write access are directly reflected in the syntax, as the following example shows:

```haxe
class Main {
	public var x(default, null):Int;
	static public function main() { }
}
```

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

---

Previous section: [Variable](class-field-variable.md)

Next section: [Common accessor identifier combinations](class-field-property-common-combinations.md)