<!--label:expression-->
## Expressions

Expressions in Haxe define what a program **does**. Most expressions are found in the body of a [method](class-field-method), where they are combined to express what that method should do. This section explains the different kinds of expressions. Some definitions help here:

> ##### Define: Name
>
> A general name may refer to
> 
> * a type,
> * a local variable,
> * a local function or
> * a field.
> 

> ##### Define: Identifier
>
> Haxe identifiers start with an underscore `_`, a dollar `$`, a lower-case character `a-z` or an upper-case character `A-Z`. After that, any combination and number of `_`, `A-Z`, `a-z` and `0-9` may follow.
> 
> Further limitations follow from the usage context, which are checked upon typing:
> 
> * Type names must start with an upper-case letter `A-Z` or an underscore `_`.
> * Leading dollars are not allowed for any kind of [name](define-name) (dollar-names are mostly used for [macro reification](macro-reification)).
> 

##### since Haxe 3.3.0

Haxe reserves the identifier prefix `_hx_` for internal use. This is not enforced by the parser or typer.

##### Keywords

The following Haxe keywords may not be used as identifiers:

* `abstract`
* `break`
* `case`
* `cast`
* `catch`
* `class`
* `continue`
* `default`
* `do`
* `dynamic`
* `else`
* `enum`
* `extends`
* `extern`
* `false`
* `final`
* `for`
* `function`
* `if`
* `implements`
* `import`
* `in`
* `inline`
* `interface`
* `macro`
* `new`
* `null`
* `operator`
* `overload`
* `override`
* `package`
* `private`
* `public`
* `return`
* `static`
* `switch`
* `this`
* `throw`
* `true`
* `try`
* `typedef`
* `untyped`
* `using`
* `var`
* `while`

##### Related content

* Haxe Code Cookbook  article: [Everything is an expression](http://code.haxe.org/category/principles/everything-is-an-expression.html).

<!--label:expression-block-->
### Blocks

A block in Haxe starts with an opening curly brace `{` and ends with a closing curly brace `}`. A block may contain several expressions, each of which is followed by a semicolon `;`. The general syntax is thus:

```haxe
{
	expr1;
	expr2;
	...
	exprN;
}
```
The value and by extension the type of a block-expression is equal to the value and the type of the last sub-expression.

Blocks can contain local variables declared by [`var` expression](expression-var), as well as local functions declared by [`function` expressions](expression-arrow-function). These are available within the block and within sub-blocks, but not outside the block. Also, they are available only after their declaration. The following example uses `var`, but the same rules apply to `function` usage:

```haxe
{
	a; // error, a is not declared yet
	var a = 1; // declare a
	a; // ok, a was declared
	{
		a; // ok, a is available in sub-blocks
	}
  // ok, a is still available after
	// sub-blocks	
	a;
}
a; // error, a is not available outside
```
At runtime, blocks are evaluated from top to bottom. Control flow (e.g. [exceptions](expression-try-catch) or [return expressions](expression-return)) may leave a block before all expressions
are evaluated.

##### Variable Shadowing

Haxe allows local variable shadowing within the same block. This means that
a `var`, `final`, or `function` can be declared with the same name that was previously available in a block, effectively hiding it from the further code:

```haxe
{
	var v = 42; // declare v
	$type(v); // Int
	var v = "hi"; // declare a new v
	$type(v); // String, previous declaration is not available
}
```

It might come as a surprise that this is allowed, but it's useful to avoid pollution of local name space and thus prevent accidental usage of a wrong variable.

Note, that the shadowing strictly follows syntax, so if a variable was captured
in a closure before it was shadowed, that closure would still reference the
original declaration:

```haxe
{
	var a = 1;
	function f() {
	    trace(a);
	}
	var a = 2;
	f(); // traces 1
}
```

##### since Haxe 4.0.0

It is possible that variable shadowing in code is unintentional. The compiler can be set to emit warnings about all instances of variable shadowing with the `-D warn-var-shadowing` define.



<!--label:expression-literals-->
### Literals

Literals are ways to construct values for many Haxe core types using reserved syntax. The following table summarizes the literals available in Haxe:

Example | Type | Note
 --- | --- | ---
`42`, `0xFF42` | `Int` | [integer](define-int) constant
`0.32`, `3.`, `2.1e5` | `Float` | [floating-point](define-float) decimal constant
`true`, `false` | `Bool` | [boolean](define-bool) constant
`~/haxe/gi` | `EReg` | [regular expression](std-regex)
`null` | `T` | null value for any [nullable](types-nullability) type
`"XXX"`, `'XXX'` | `String` | [string literal](std-String-literals)
`"X".code`, `'X'.code` | `Int` | [Unicode character codepoint](std-String#character-code)
`[1, 2, 3]`, `[]` | `Array<T>` | [array](std-Array) literal
`["a" => 1]`, `[]` | `Map<T, U>` | [map](std-Map) literal
`{foo: true}`, `{}` | `T` | [anonymous structure](types-anonymous-structure)
`1...3` | `IntIterator` | [range](expression-for)



<!--label:expression-constants-->
### Constants

Constants are values which are immutable. These values can be used as [inline variables](class-field-inline#inline-variables) and [default values for function arguments](types-function-default-values). All constants are [literals](expression-literals), except for argument-less enum constructors:

Example | Type  | Note
 --- | --- | --- | ---
`42`, `0xFF42` | `Int` | [integer](define-int) constant
`0.32`, `3.`, `2.1e5` | `Float` | [floating-point](define-float) decimal constant
`true`, `false` | `Bool` | [boolean](define-bool) constant
`~/haxe/gi` | `EReg` | [regular expression](std-regex)
`null` | `T` | null value for any [nullable](types-nullability) type
`"XXX"`, `'XXX'` | `String` | [string literal](std-String-literals)
`"X".code`, `'X'.code` | `Int` | [Unicode character codepoint](std-String#character-code)
`MyEnum.Haxe` | `T` | [enum constructor](types-enum-constructor) with no arguments

Furthermore, the internal syntax structure treats [identifiers](define-identifier) as constants, which may be relevant when working with [macros](macro).



<!--label:expression-operators-->
### Operators

<!--subtoc-->

<!--label:expression-operators-unops-->
#### Unary Operators

Operator | Operation | Operand type | Position | Result type 
 --- | --- | --- | --- | ---
<code>~</code> | bitwise negation | `Int` | prefix | `Int` 
<code>!</code> | logical negation | `Bool` | prefix | `Bool` 
<code>-</code> | arithmetic negation | `Float/Int` | prefix | same as operand 
<code>++</code> | increment | `Float/Int` | prefix and postfix | same as operand 
<code>--</code> | decrement | `Float/Int` | prefix and postfix | same as operand

##### Increment and decrement

The increment and decrement operators change the given value, so they cannot be applied to a read-only value. They also produce different results based on whether they are used as a prefix operator, which evaluates to the modified value, or as a postfix operator, which evaluates to the original value:

```haxe
var a = 10;
trace(a++); // 10
trace(a); // 11

a = 10;
trace(++a); // 11
trace(a); // 11
```



<!--label:expression-operators-binops-->
#### Binary Operators

##### Arithmetic operators

Operator | Operation | Operand 1 | Operand 2 | Result type 
 --- | --- | --- | --- | ---
<code>%</code> | modulo | `Float/Int` | `Float/Int` | `Float/Int` 
<code>*</code> | multiplication | `Float/Int` | `Float/Int` | `Float/Int` 
<code>/</code> | division | `Float/Int` | `Float/Int` | `Float` 
<code>+</code> | addition | `Float/Int` | `Float/Int` | `Float/Int` 
<code>-</code> | subtraction | `Float/Int` | `Float/Int` | `Float/Int`

About the `Float/Int` return type: If one of the operands is of type `Float`, the resulting expression will also be of type `Float`, otherwise the type will be `Int`. The result of a division is always a `Float`; use `Std.int(a / b)` for integer division (discarding any fractional part).

In Haxe, the result of a modulo operation always keeps the sign of the dividend (the left operand) if the divisor is non-negative. The result is target-specific with a negative divisor.

##### Bitwise operators

Operator | Operation | Operand 1 | Operand 2 | Result type 
 --- | --- | --- | --- | ---
<code>&lt;&lt;</code> | shift left | `Int` | `Int` | `Int` 
<code>&gt;&gt;</code> | shift right | `Int` | `Int` | `Int` 
<code>&gt;&gt;&gt;</code> | unsigned shift right | `Int` | `Int` | `Int` 
<code>&amp;</code> | bitwise and | `Int` | `Int` | `Int` 
<code>&#124;</code> | bitwise or | `Int` | `Int` | `Int` 
<code>^</code> | bitwise xor | `Int` | `Int` | `Int`

##### Logical operators

Operator | Operation | Operand 1 | Operand 2 | Result type 
 --- | --- | --- | --- | ---
<code>&amp;&amp;</code> | logical and | `Bool` | `Bool` | `Bool` 
<code>&#124;&#124;</code> | logical or | `Bool` | `Bool` | `Bool`

**Short-circuiting:**

Haxe guarantees that compound boolean expressions with the same operator are evaluated from left to right but only as far as necessary at run-time. For instance, an expression like `A && B` will evaluate `A` first and evaluate `B` only if the evaluation of `A` yielded `true`. Likewise, the expression <code>A &#124;&#124; B</code> will not evaluate `B` if the evaluation of `A` yielded `true`, because the value of `B` is irrelevant in that case. This is important in cases such as this:

```haxe
if (object != null && object.field == 1) { }
```

Accessing `object.field` if `object` is `null` would lead to a run-time error, but the check for `object != null` guards against it.

##### Compound assignment operators

Operator | Operation | Operand 1 | Operand 2 | Result type 
 --- | --- | --- | --- | ---
<code>%=</code> | modulo | `Float/Int` | `Float/Int` | `Float/Int` 
<code>*=</code> | multiplication | `Float/Int` | `Float/Int` | `Float/Int` 
<code>/=</code> | division | `Float` | `Float/Int` | `Float` 
<code>+=</code> | addition | `Float/Int` | `Float/Int` | `Float/Int` 
<code>-=</code> | subtraction | `Float/Int` | `Float/Int` | `Float/Int` 
<code>&lt;&lt;=</code> | shift left | `Int` | `Int` | `Int` 
<code>&gt;&gt;=</code> | shift right | `Int` | `Int` | `Int` 
<code>&gt;&gt;&gt;=</code> | unsigned shift right | `Int` | `Int` | `Int` 
<code>&amp;=</code> | bitwise and | `Int` | `Int` | `Int` 
<code>&#124;=</code> | bitwise or | `Int` | `Int` | `Int` 
<code>^=</code> | bitwise xor | `Int` | `Int` | `Int`

In all cases, a compound assignment modifies the given variable, field, structure member, etc., so it will not work on a read-only value. The compound assignment evaluates to the modified value when used as a sub-expression:

```haxe
var a = 3;
trace(a += 3); // 6
trace(a); // 6
```

Note that the first operand of `/=` must always be a `Float`, since the result of a division is always a `Float` in Haxe. Similarly, `+=` and `-=` cannot accept `Int` as the first operand if `Float` is given as the second operand, since the result would be a `Float`.

##### Numeric comparison operators

Operator | Operation | Operand 1 | Operand 2 | Result type 
 --- | --- | --- | --- | ---
<code>==</code> | equal | `Float/Int` | `Float/Int` | `Bool` 
<code>!=</code> | not equal | `Float/Int` | `Float/Int` | `Bool` 
<code>&lt;</code> | less than | `Float/Int` | `Float/Int` | `Bool` 
<code>&lt;=</code> | less than or equal | `Float/Int` | `Float/Int` | `Bool` 
<code>&gt;</code> | greater than | `Float/Int` | `Float/Int` | `Bool` 
<code>&gt;=</code> | greater than or equal | `Float/Int` | `Float/Int` | `Bool`

##### String comparison operators

Operator | Operation | Operand 1 | Operand 2 | Result type 
 --- | --- | --- | --- | ---
<code>==</code> | equal | `String` | `String` | `Bool` 
<code>!=</code> | not equal | `String` | `String` | `Bool` 
<code>&lt;</code> | lexicographically before | `String` | `String` | `Bool` 
<code>&lt;=</code> | lexicographically before or equal | `String` | `String` | `Bool` 
<code>&gt;</code> | lexicographically after | `String` | `String` | `Bool` 
<code>&gt;=</code> | lexicographically after or equal | `String` | `String` | `Bool`

Two values of type `String` are considered equal in Haxe when they have the same length and the same contents:

```haxe
var a = "foo";
var b = "bar";
var c = "foo";
trace(a == b); // false
trace(a == c); // true
trace(a == "foo"); // true
```

##### Equality operators

Operator | Operation | Operand 1 | Operand 2 | Result type 
 --- | --- | --- | --- | ---
<code>==</code> | equal | any | any | `Bool` 
<code>!=</code> | not equal | any | any | `Bool`

The types of operand 1 and operand 2 must [unify](type-system-unification).

**Enums:**

* Enums without parameters always represent the same value, so `MyEnum.A == MyEnum.A`. 
* Enums with parameters can be compared with `a.equals(b)` (which is short for `Type.enumEquals()`).

**Dynamic:**

Comparison involving at least one operand of type `Dynamic` is unspecified and platform-specific.

##### Miscellaneous operators

Operator | Operation | Operand&nbsp;1 | Operand&nbsp;2 | Result&nbsp;type 
 --- | --- | --- | --- | ---
<code>...</code> | interval (see [range iteration](expression-for)) | `Int` | `Int` | `IntIterator` 
<code>=&gt;</code> | arrow (see [map](expression-map-declaration), [key-value iteration](expression-for#key-value-iteration), [map comprehension](lf-map-comprehension)) | any | any | -



<!--label:expression-operators-ternary-->
#### Ternary Operator

Operator | Operation | Operand 1 | Operand 2 | Operand 3 | Result type 
 --- | --- | --- | --- | --- | ---
<code>?:</code> | condition | `Bool` | any | any | any

The type of operand 1 and operand 2 must [unify](type-system-unification). The unified type is used as the result type of the expression.

The ternary conditional operator is a shorter form of [`if`](expression-if):

```haxe
trace(true ? "Haxe" : "Neko"); // Haxe
trace(1 == 2 ? 3 : 4); // 4

// equivalent to:

trace(if (true) "Haxe" else "Neko"); // Haxe
trace(if (1 == 2) 3 else 4); // 4
```



<!--label:expression-operators-precedence-->
#### Precedence

In order of descending precedence (i.e. operators higher in the table are evaluated first):

Operators | Note | Associativity 
 --- | --- | ---
<code>!</code>, <code>++</code>, <code>--</code> | postfix unary operators | right 
<code>~</code>, <code>!</code>, <code>-</code>, <code>++</code>, <code>--</code> | prefix unary operators | right 
<code>%</code> | modulo | left 
<code>*</code>, <code>/</code> | multiplication, division | left 
<code>+</code>, <code>-</code> | addition, subtraction | left 
<code>&lt;&lt;</code>, <code>&gt;&gt;</code>, <code>&gt;&gt;&gt;</code> | bitwise shifts | left 
<code>&amp;</code>, <code>&#124;</code>, <code>^</code> | bitwise operators | left 
<code>==</code>, <code>!=</code>, <code>&lt;</code>, <code>&lt;=</code>, <code>&gt;</code>, <code>&gt;=</code> | comparison | left 
<code>...</code> | interval | left 
<code>&amp;&amp;</code> | logical and | left 
<code>&#124;&#124;</code> | logical or | left 
<code>@</code> | metadata | right 
<code>?:</code> | ternary | right 
<code>%=</code>, <code>*=</code>, <code>/=</code>, <code>+=</code>, <code>-=</code>, <code>&lt;&lt;=</code>, <code>&gt;&gt;=</code>, <code>&gt;&gt;&gt;=</code>, <code>&amp;=</code>, <code>&#124;=</code>, <code>^=</code> | compound assignment | right 
<code>=&gt;</code> | arrow | right 

##### Differences from C-like precedence

Many languages (C++, Java, PHP, JavaScript, etc) use the same operator precedence rules as C. In Haxe, there are a couple of differences from these rules:

* `%` (modulo) has a higher precedence than `*` and `/`; in C they have the same precedence
* <code>&#124;</code>, `&`, `^` (bitwise operators) have the same precedence; in C the three operators all have a different precedence
* <code>&#124;</code>, `&`, `^` (bitwise operators) also have a lower precedence than `==`, `!=`, etc (comparison operators)



<!--label:expression-operators-overloading-->
#### Overloading and macros

The operators specified in the previous sections specify the types and meanings for operations on basic types. Additional functionality can be implemented using [abstract operator overloading](types-abstract-operator-overloading) or [macro processing](macro).

Operator precedence cannot be changed with abstract operator overloading.

For macro processing in particular, there is an additional operator available: the postfix `!` operator.





<!--label:expression-array-declaration-->
### Array Declaration

Arrays are initialized by enclosing comma `,` separated values in brackets `[]`. A plain `[]` represents the empty array, whereas `[1, 2, 3]` initializes an array with three elements `1`, `2` and `3`.

The generated code may be less concise on platforms that do not support array initialization. Essentially, such initialization code then looks like this:

```haxe
var a = new Array();
a.push(1);
a.push(2);
a.push(3);
```
This should be considered when deciding if a function should be [inlined](class-field-inline) as it may inline more code than visible in the syntax.

Advanced initialization techniques are described in [Array Comprehension](lf-array-comprehension).



<!--label:expression-map-declaration-->
### Map Declaration

Maps are initialized similarly to arrays, but include both keys and their corresponding values. `["example" => 1, "data" => 2]` initializes a map (`Map<String, Int>` specifically) where the key `"example"` stores the value `1` and `"data"` stores the value 2.

##### since Haxe 4.0.0

Where a map type is expected (based on [top-down inference](type-system-top-down-inference)), `[]` refers to an empty map.



<!--label:expression-object-declaration-->
### Object Declaration

Object declaration begins with an opening curly brace `{` after which `key:value`-pairs separated by comma `,` follow, and which ends in a closing curly brace `}`.

```haxe
{
	key1:value1,
	key2:value2,
	...
	keyN:valueN
}
```
Further details of object declaration are described in the section about [anonymous structures](types-anonymous-structure).



<!--label:expression-field-access-->
### Field Access

Field access is expressed by using the dot `.` followed by the name of the field.

```haxe
object.fieldName
```

This syntax is also used to access types within packages in the form of `pack.Type`.

The typer ensures that an accessed field actually exist and may apply transformations depending on the nature of the field. If a field access is ambiguous, understanding the [resolution order](type-system-resolution-order) may help.



<!--label:expression-array-access-->
### Array Access

Array access is expressed by using an opening bracket `[` followed by the index expression and a closing bracket `]`.

```haxe
expr[indexExpr]
```

This notation is allowed with arbitrary expressions, but at typing level only certain combinations are admitted:

* `expr` is of `Array` or `Dynamic` and `indexExpr` is of `Int`
* `expr` is an [abstract type](types-abstract) which defines a matching [array access](types-abstract-array-access)



<!--label:expression-function-call-->
### Function Call

Functions calls consist of an arbitrary subject expression followed by an opening parenthesis `(`, a comma `,` separated list of expressions as arguments and a closing parenthesis `)`.

```haxe
subject(); // call with no arguments
subject(e1); // call with one argument
subject(e1, e2); // call with two arguments
// call with multiple arguments
subject(e1, ..., eN);
```

##### Related content

* Haxe Code Cookbook article: [How to declare functions](http://code.haxe.org/category/beginner/declare-functions.html)
* Class Methods: [Method](class-field-method)



<!--label:expression-var-->
### var and final

The `var` keyword allows declaring multiple variables, separated by comma `,`. Each variable has a valid [identifier](define-identifier) and optionally a value assignment following the assignment operator `=`. Variables can also have an explicit type-hint.

```haxe
var a; // declare local a
var b:Int; // declare variable b of type Int
// declare variable c, initialized to value 1
var c = 1;
// declare an uninitialized variable d
// and variable e initialized to value 2
var d,e = 2;
```

The scoping behavior of local variables, as well as variable shadowing is described in [Blocks](expression-block).

##### since Haxe 4.0.0

In Haxe 4, the alternative keyword `final` was introduced at the expression level. Variables declared with `final` instead of `var` can only be assigned a value once.

[code asset](assets/Final.hx)

It is important to note that `final` may not have the intended effect with types that are not immutable, such as arrays or objects. Even though the variable cannot have a different object assigned to it, the object itself can still be modified using its methods:

[code asset](assets/FinalMutable.hx)



<!--label:expression-arrow-function-->
### Local Functions

Haxe supports first-class functions and allows declaring local functions in expressions. The syntax follows [class field methods](class-field-method):

[code asset](assets/LocalFunction.hx)

We declare `myLocalFunction` inside the [block expression](expression-block) of the `main` class field. It takes one argument `i` and adds it to `value`, which is defined in the outside scope.

The scoping is equivalent to that of [variables](expression-var) and for the most part writing a named local function can be considered equal to assigning an unnamed local function to a local variable:

```haxe
var myLocalFunction = function(a) { }
```

However, there are some differences related to type parameters and the position of the function. We speak of a "lvalue" function if it is not assigned to anything upon its declaration, and an "rvalue" function otherwise.

* Lvalue functions require a name and can have [type parameters](type-system-type-parameters).
* Rvalue functions may have a name, but cannot have type parameters.

##### since Haxe 4.0.0

##### Arrow functions

Haxe 4 introduced a shorter syntax for defining local functions without a name, very similar to the function type syntax. The argument list is defined between two parentheses, followed by an arrow `->`, followed directly by the expression. An arrow function with a single argument does not require parentheses around the argument, and an arrow function with zero arguments should be declared with `() -> ...`:

[code asset](assets/ArrowFunction.hx)

Arrow functions are very similar to normal local functions, with a couple of differences:

* The expression after the arrow is implicitly treated as the return value of the function. For simple functions like `myConcat` above, this can be a convenient way to shorten the code. Normal `return` expressions can still be used, as shown in `myContains` above.
* There is no way to declare the return type, although you can use a [type check](expression-type-check) to unify the function expression with the desired return type.
* [Metadata](lf-metadata) cannot be applied to the arguments of an arrow function.



<!--label:expression-new-->
### new

The `new` keyword signals that a [class](types-class-instance) or an [abstract](types-abstract) is being instantiated. It is followed by the [type path](define-type-path) of the type which is to be instantiated. It may also list explicit [type parameters](type-system-type-parameters) enclosed in `<>` and separated by comma `,`. After an opening parenthesis `(` follow the constructor arguments, again separated by comma `,`, with a closing parenthesis `)` at the end.

[code asset](assets/New.hx)

Within the `main` method we instantiate an instance of `Main` itself, with an explicit type parameter `Int` and the arguments `12` and `"foo"`. As we can see, the syntax is very similar to the [function call syntax](expression-function-call) and it is common to speak of "constructor calls".



<!--label:expression-for-->
### for

Haxe does not support traditional for-loops known from C. Its `for` keyword expects an opening parenthesis `(`, then a variable identifier followed by the keyword `in` and an arbitrary expression used as iterating collection. After the closing parenthesis `)` follows an arbitrary loop body expression.

```haxe
for (v in e1) e2;
```

The typer ensures that the type of `e1` can be iterated over, which is typically the case if it has an  [`iterator`](lf-iterators) method returning an `Iterator<T>`, or if it is an `Iterator<T>` itself.

Variable `v` is then available within loop body `e2` and holds the value of the individual elements of collection `e1`.

```haxe
var list = ["apple", "pear", "banana"];
for (v in list) {
  trace(v);
}
// apple
// pear
// banana
```

##### Range iteration

Haxe has a special range operator to iterate over intervals. It is a binary operator taking two `Int` operands: `min...max` returns an [IntIterator](http://api.haxe.org/IntIterator.html) instance that iterates from `min` (inclusive) to `max` (exclusive). Note that `max` may not be smaller than `min`.

```haxe
for (i in 0...10) trace(i); // 0 to 9
```

The type of a `for` expression is always `Void`, meaning it has no value and cannot be used as right-side expression. However, we'll later introduce [array comprehension](lf-array-comprehension), which lets you construct arrays using `for` expressions.

The control flow of loops can be affected by [`break`](expression-break) and [`continue`](expression-continue) expressions.

```haxe
for (i in 0...10) {
  if (i == 2) continue; // skip 2
  if (i == 5) break; // stop at 5
  trace(i);
}
// 0
// 1
// 3
// 4
```

##### since Haxe 4.0.0

##### Key-value iteration

In Haxe 4 it is possible to iterate over collections of key-value pairs. The syntax is the same as regular `for` loops, but the single variable identifier is replaced with the key variable identifier, followed by `=>`, followed by the value variable identifier:

```haxe
for (k => v in e1) e2;
```

Type safety is ensured for key-value iteration as well. The typer checks that `e1` either has a `keyValueIterator` method returning returning a `KeyValueIterator<K, V>`, or if it is a `KeyValueIterator<K, V>` itself. Here `K` and `V` refer to the type of the keys and the values, respectively.

```haxe
var map = [1 => 101, 2 => 102, 3 => 103];
for (key => value in map) {
  trace(key, value);
}
// 1, 101
// 2, 102
// 3, 103
```

##### Related content

* Manual: [Haxe iterators documentation](lf-iterators), [Haxe Data Structures documentation](std-ds)
* Cookbook: [Haxe iterators examples](http://code.haxe.org/tag/iterator.html), [Haxe data structures examples](http://code.haxe.org/tag/data-structures.html)



<!--label:expression-while-->
### while

A normal while loop starts with the `while` keyword, followed by an opening parenthesis `(`, the condition expression and a closing parenthesis `)`. After that follows the loop body expression:

```haxe
while(condition) expression;
```

The condition expression has to be of type `Bool`.

Upon each iteration, the condition expression is evaluated. If it evaluates to `false`, the loop stops, otherwise it evaluates the loop body expression.

[code asset](assets/While.hx)

This kind of while-loop is not guaranteed to evaluate the loop body expression at all: If the condition does not hold from the start, it is never evaluated. This is different for [do-while loops](expression-do-while).



<!--label:expression-do-while-->
### do-while

A do-while loop starts with the `do` keyword followed by the loop body expression. After that follows the `while` keyword, an opening parenthesis `(`, the condition expression and a closing parenthesis `)`:

```haxe
do expression while(condition);
```

The condition expression has to be of type `Bool`.

As the syntax suggests, the loop body expression is always evaluated at least once, unlike [while](expression-while) loops.



<!--label:expression-if-->
### if

Conditional expressions come in the form of a leading `if` keyword, a condition expression enclosed in parentheses `()` and a expression to be evaluated in case the condition holds:

```haxe
if (condition) expression;
```

The condition expression has to be of type `Bool`.

Optionally, `expression` may be followed by the `else` keyword as well as another expression to be evaluated if the condition does not hold:

```haxe
if (condition) expression1 else expression2;
```

Here, `expression2` may consist of another `if` expression:

```haxe
if (condition1) expression1
else if(condition2) expression2
else expression3
```

If the value of an `if` expression is required, e.g. for `var x = if(condition) expression1 else expression2`, the typer ensures that the types of `expression1` and `expression2` [unify](type-system-unification). If no `else` expression is given, the type is inferred to be `Void`.



<!--label:expression-switch-->
### switch

A basic switch expression starts with the `switch` keyword and the switch subject expression, as well as the case expressions between curly braces `{}`. Case expressions either start with the `case` keyword and are followed by a pattern expression, or consist of the `default` keyword. In both cases a colon `:` and an optional case body expression follows:

```haxe
switch subject {
	case pattern1: case-body-expression-1;
	case pattern2: case-body-expression-2;
	default: default-expression;
}
```

Case body expressions never "fall through", so the [`break`](expression-break) keyword is not supported in Haxe.

Switch expressions can be used as value; in that case the types of all case body expressions and the default expression must [unify](type-system-unification).

##### Related content

* Further details on syntax of pattern expressions are detailed in [Pattern Matching](lf-pattern-matching).
* [Snippets and tutorials about pattern matching](http://code.haxe.org/tag/pattern-matching.html) in the Haxe Code Cookbook.



<!--label:expression-try-catch-->
### try/catch

Haxe allows catching values using its `try/catch` syntax:

```haxe
try try-expr
catch(varName1:Type1) catch-expr-1
catch(varName2:Type2) catch-expr-2
```

If during runtime the evaluation of `try-expression` causes a [`throw`](expression-throw), it can be caught by any subsequent `catch` block. These blocks consist of

* a variable name which holds the thrown value,
* an explicit type annotation which determines which types of values to catch, and
* the expression to execute in that case.

Haxe allows throwing and catching any kind of value, it is not limited to types inheriting from a specific exception or error class. Catch blocks are checked from top to bottom with the first one whose type is compatible with the thrown value being picked.

This process has many similarities to the compile-time [unification](type-system-unification) behavior. However, since the check has to be done at runtime there are several restrictions:

* The type must exist at runtime: [Class instances](types-class-instance), [enum instances](types-enum-instance), [abstract core types](types-abstract-core-type) and [Dynamic](types-dynamic).
* Type parameters can only be [Dynamic](types-dynamic).



<!--label:expression-return-->
### return

A `return` expression can come with or without a value expression:

```haxe
return;
return expression;
```

It leaves the control-flow of the innermost function it is declared in, which has to be distinguished when [local functions](expression-arrow-function) are involved:

```haxe
function f1() {
	function f2() {
		return;
	}
	f2();
	expression;
}
```

The `return` leaves local function `f2`, but not `f1`, meaning `expression` is still evaluated.

If `return` is used without a value expression, the typer ensures that the return type of the function it returns from is of `Void`. If it has a value expression, the typer [unifies](type-system-unification) its type with the return type (explicitly given or inferred by previous `return` expressions) of the function it returns from.



<!--label:expression-break-->
### break

The `break` keyword leaves the control flow of the innermost loop (`for` or `while`) it is declared in, stopping further iterations:

```haxe
while(true) {
	expression1;
	if (condition) break;
	expression2;
}
```

Here, `expression1` is evaluated for each iteration, but as soon as `condition` holds, the current iteration is terminated without evaluating `expression2`, and no more iteration is done.

The typer ensures that it appears only within a loop. The `break` keyword in [`switch` cases](expression-switch) is not supported in Haxe.



<!--label:expression-continue-->
### continue

The `continue` keyword ends the current iteration of the innermost loop (`for` or `while`) it is declared in, causing the loop condition to be checked for the next iteration:

```haxe
while(true) {
	expression1;
	if(condition) continue;
	expression2;
}
```

Here, `expression1` is evaluated for each iteration, but if `condition` holds, `expression2` is not evaluated for the current iteration. Unlike `break`, iterations continue.

The typer ensures that it appears only within a loop.



<!--label:expression-throw-->
### throw

Haxe allows throwing any kind of value using its `throw` syntax:

```haxe
throw expr
```

A value which is thrown like this can be caught by [`catch` blocks](expression-try-catch). If no such block catches it, the behavior is target-dependent.



<!--label:expression-cast-->
### cast

Haxe allows two kinds of casts:

```haxe
cast expr; // unsafe cast
cast (expr, Type); // safe cast
```

<!--label:expression-cast-unsafe-->
#### unsafe cast

Unsafe casts are useful to subvert the type system. The compiler types `expr` as usual and then wraps it in a [monomorph](types-monomorph). This allows the expression to be assigned to anything.

Unsafe casts do not introduce any [dynamic](types-dynamic) types, as the following example shows:

[code asset](assets/UnsafeCast.hx)

Variable `i` is typed as `Int` and then assigned to variable `s` using the unsafe cast `cast i`. This causes `s` to be of an unknown type, a monomorph. Following the usual rules of [unification](type-system-unification), it can then be bound to any type, such as `String` in this example.

These casts are called "unsafe" because the runtime behavior for invalid casts is not defined. While most [dynamic targets](define-dynamic-target) are likely to work, it might lead to undefined errors on [static targets](define-static-target).

Unsafe casts have little to no runtime overhead.



<!--label:expression-cast-safe-->
#### safe cast

Unlike [unsafe casts](expression-cast-unsafe), the runtime behavior in case of a failing cast is defined for safe casts:

[code asset](assets/SafeCast.hx)

In this example we first cast a class instance of type `Child1` to `Base`, which succeeds because `Child1` is a [child class](types-class-inheritance) of `Base`. We then try to cast the same class instance to `Child2`, which is not allowed because instances of `Child2` are not instances of `Child1`.

The Haxe compiler guarantees that an exception of type `String` is [thrown](expression-throw) in this case. This exception can be caught using a [`try/catch` block](expression-try-catch).

Safe casts have a runtime overhead. It is important to understand that the compiler already generates type checks, so it is redundant to add manual checks, e.g. using `Std.is`. The intended usage is to try the safe cast and catch the `String` exception.





<!--label:expression-type-check-->
### type check

##### since Haxe 3.1.0

It is possible to employ compile-time type checks using the following syntax:

```haxe
(expr : type)
```

The parentheses are mandatory. Unlike [safe casts](expression-cast-safe) this construct has no run-time impact. It has two compile-time implications:

1. [Top-down inference](type-system-top-down-inference) is used to type `expr` with type `type`.
2. The resulting typed expression is [unified](type-system-unification) with type `type`.

This has the usual effect of both operations such as the given type being used as expected type when performing [unqualified identifier resolution](type-system-resolution-order) and the unification checking for [abstract casts](types-abstract-implicit-casts).



<!--label:expression-inline-->
### inline

##### since Haxe 4.0.0

The `inline` keyword can be used before a [function call](expression-function-call) or a [constructor call](expression-new). This allows a finer-grained control of inlining, unlike the [inline access modifier](class-field-inline).

[code asset](assets/InlineCallsite.hx)

The generated JavaScript output is:

```haxe
(function ($global) { "use strict";
var Test = function() { };
Test.mid = function(s1,s2) {
	return (s1 + s2) / 2;
};
Test.main = function() {
	var a = 1;
	var b = 2;
	var c = Test.mid(a,b);
	var d = (a + b) / 2;
};
Test.main();
})({});
```

Note that `c` produces a call to the function, whereas `d` does not. The usual warnings about what makes a good candidate for inlining still hold (see [Inline](class-field-inline)).

An `inline new` call can be used to avoid creating a local class instance. See [Inline Constructors](lf-inline-constructor) for more details.


