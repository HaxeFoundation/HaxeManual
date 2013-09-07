Expression reification is used to create instances of `haxe.macro.Expr` in a convenient way. The Haxe Compiler accepts the usual Haxe syntax and translates it to an expression object. It supports several escaping mechanisms, all of which are triggered by the `$` character:



* `${}` and `$e{}`: `Expr -> Expr` This can be used to compose expressions. The expression within the delimiting `{ }` is executed, with its value being used in place.
* `$a{}`: `Expr -> Array<Expr>` If used in a place where an `Array<Expr>` is expected (e.g. call arguments, block elements), `$a{}` treats its value as that array. Otherwise it generates an array declaration.
* `$b{}`: `Array<Expr> -> Expr` Generates a block expression from the given expression array.
* `$i{}`: `String -> Expr` Generates an identifier from the given string.
* `$p{}`: `Array<String> -> Expr` Generates a field expression from the given string array.
* `$v{}`: `Dynamic -> Expr` Generates an expression depending on the type of its argument. This is only guaranteed to work for [manual/Basic_Types] and [manual/Enum_Instance].