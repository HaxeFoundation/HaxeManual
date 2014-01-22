## 9.3.1 Expression Reification

Expression reification is used to create instances of `haxe.macro.Expr` in a convenient way. The Haxe Compiler accepts the usual Haxe syntax and translates it to an expression object. It supports several escaping mechanisms, all of which are triggered by the `$` character:



* `${}` and `$e{}`: `Expr -> Expr` This can be used to compose expressions. The expression within the delimiting `{ }` is executed, with its value being used in place.
* `$a{}`: `Expr -> Array<Expr>` If used in a place where an `Array<Expr>` is expected (e.g. call arguments, block elements), `$a{}` treats its value as that array. Otherwise it generates an array declaration.
* `$b{}`: `Array<Expr> -> Expr` Generates a block expression from the given expression array.
* `$i{}`: `String -> Expr` Generates an identifier from the given string.
* `$p{}`: `Array<String> -> Expr` Generates a field expression from the given string array.
* `$v{}`: `Dynamic -> Expr` Generates an expression depending on the type of its argument. This is only guaranteed to work for [basic types](types-basic-types.md) and [enum instances](types-enum-instance.md).



This kind of reification only works in places where the internal structure expects an expression. This disallows `object.${fieldName}`, but `object.$fieldName` works. This is true for all places where the internal structure expects a string:



* field access `object.$name`
* variable name `var $name = 1;`


##### since Haxe 3.1.0




* field name `{ $name: 1} `
* function name `function $name() { }`
* catch variable name `try e() catch($name:Dynamic) {}`

---

Previous section: [Reification](macro-reification.md)

Next section: [Type Reification](macro-reification-type.md)