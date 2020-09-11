<!--label:std-->
## Standard Library

<!--subtoc-->

<!--label:std-String-->
### String

> ##### Define: String
>
> A String is a sequence of characters.

String is a special class in Haxe. It is not considered a [basic type](types-basic-types), but it can be constructed as a [literal](std-String-literals). The [binary comparison operators](expression-operators-binops#string-comparison-operators) also behave differently when applied to strings. Haxe also supports special [string interpolation](lf-string-interpolation) syntax.

##### Character code
Use the `.code` property on a constant single-char string in order to compile its Unicode character point:

```haxe
"#".code // will compile as 35
```

##### Related content

* See the [String API](https://api.haxe.org/String.html) for details about its methods.

<!--label:std-String-literals-->
#### String literals

A string literal is a sequence of characters inside a pair of double quotes or single quotes:

```haxe
var a = "foo";
var b = 'foo';
trace(a == b); // true
```

The only difference between the two forms is that single-quoted literals allow [string interpolation](lf-string-interpolation).

##### Escape sequences

Sequence | Meaning | Unicode codepoint (decimal) | Unicode codepoint (hexadecimal)
 --- | --- | --- | ---
`\t` | horizontal tab (TAB) | 9 | 0x09
`\n` | new line (LF) | 10 | 0x0A
`\r` | new line (CR) | 13 | 0x0D
`\"` | double quote | 34 | 0x22
`\'` | single quote | 39 | 0x27
`\\` | backslash | 92 | 0x5C
`\NNN` | ASCII escape where `NNN` is 3 octal digits | 0 - 127 | 0x00 - 0x7F
`\xNN` | ASCII escape where `NN` is a pair of hexadecimal digits | 0 - 127 | 0x00 - 0x7F
`\uNNNN` | Unicode escape where `NNNN` is 4 hexadecimal digits | 0 - 65535 | 0x0000 - 0xFFFF
`\u{N...}` | Unicode escape where `N...` is 1-6 hexadecimal digits | 0 - 1114111 | 0x000000 - 0x10FFFF

<!--label:std-String-unicode-->
#### Unicode

##### since Haxe 4.0.0

All Haxe targets except Neko support Unicode in strings by default. The [compile-time define](lf-condition-compilation) `target.unicode` is set on targets where Unicode is supported.

A string in Haxe code represents a valid sequence of Unicode codepoints. Due to differing internal representations of strings across targets, only the basic multilingual plane (BMP) is supported consistently: every BMP Unicode codepoint corresponds to exactly one string character.

It is still possible to work with strings including non-BMP characters on all targets without having to manually decode surrogate pairs by using the [Unicode iterators API](https://api.haxe.org/v/development/haxe/iterators/StringIteratorUnicode.html) provided in the standard library.

<!--label:std-String-encoding-->
#### Encoding

On some targets, the internal representation is UTF-16, which means that non-BMP Unicode codepoints are represented using surrogate pairs. The [compile-time define](lf-condition-compilation) `target.utf16` is set when the target uses UTF-16 internally.

##### Null-bytes in strings

<!-- Might need to be changed depending on the outcome of -->
<!-- https://github.com/HaxeFoundation/haxe/issues/8201 -->

Some Haxe targets disallow null-bytes (Unicode codepoint 0) in strings. Additionally, some Haxe core APIs assume a null-byte terminates strings. To consistently deal with binary data, including null-bytes, use the [`haxe.io.Bytes`](https://api.haxe.org/haxe/io/Bytes.html) API.

##### Target details

Target | `target.unicode` | `target.utf16` | Internal encoding | Null-byte allowed
 --- | --- | --- | --- | ---
Flash | yes | yes | UTF-16 | no
JavaScript | yes | yes | UTF-16 | yes (except in some old browsers)
C++ | yes | yes | ASCII or UTF-16 (if needed) | yes
Java | yes | yes | UTF-16 | yes
JVM | yes | yes | UTF-16 | yes
C\# | yes | yes | UTF-16 | yes
Python | yes | no | Latin-1, UCS-2, or UCS-4 (see [PEP 393](https://www.python.org/dev/peps/pep-0393/)) | yes
Lua | yes | no | UTF-8 | yes
PHP | yes | no | binary | yes
Eval | yes | no | UTF-8 | yes
Neko | no | no | binary | yes
HashLink | yes | yes | UTF-16 | no


<!--label:std-ds-->
### Data Structures

<!--subtoc-->

<!--label:std-Array-->
#### Array

An `Array` is a collection of elements. It has one [type parameter](type-system-type-parameters) which corresponds to the type of these elements. Arrays can be created in three ways:

1. By using their constructor: `new Array()`
2. By using [array declaration syntax](expression-array-declaration): `[1, 2, 3]`
3. By using [array comprehension](lf-array-comprehension): `[for (i in 0...10) if (i % 2 == 0) i]`

Arrays come with an [API](https://api.haxe.org/Array.html) to cover most use-cases. Additionally they allow read and write [array access](expression-array-access):

[code asset](assets/ArrayAccess.hx)

Since array access in Haxe is unbounded, i.e. it is guaranteed to not throw an exception, this requires further discussion:

* If a read access is made on a non-existing index, a target-dependent value is returned.
* If a write access is made with a positive index which is out of bounds, `null` (or the [default value](define-default-values) for [basic types](types-basic-types) on [static targets](define-static-target)) is inserted at all positions between the last defined index and the newly written one.
* If a write access is made with a negative index, the result is unspecified.

Arrays define an [iterator](lf-iterators) over their elements. This iteration is typically optimized by the compiler to use a [`while` loop](expression-while) with array index:

[code asset](assets/ArrayIterator.hx)

Haxe generates this optimized JavaScript output:

```js
Main.main = function() {
	var scores = [110,170,35];
	var sum = 0;
	var _g = 0;
	while(_g < scores.length) {
		var score = scores[_g];
		++_g;
		sum += score;
	}
	console.log(sum);
};
```

Haxe does not allow arrays of mixed types unless the parameter type is forced to [`Dynamic`](types-dynamic):

[code asset](assets/ArrayDynamic.hx)

> ##### Trivia: Dynamic Arrays
>
> In Haxe 2, mixed type array declarations were allowed. In Haxe 3, arrays can have mixed types only if they are explicitly declared as `Array<Dynamic>`.

##### Related content

* See the [Array API](https://api.haxe.org/Array.html) for details about its methods. 
* [Data structures tutorials and examples](http://code.haxe.org/category/data-structures/) in the Haxe Code Cookbook.



<!--label:std-vector-->
#### Vector

A `Vector` is an optimized fixed-length **collection** of elements. Much like [Array](std-Array), it has one [type parameter](type-system-type-parameters) and all elements of a vector must be of the specified type, it can be **iterated over** using a [for loop](expression-for) and accessed using [array access syntax](types-abstract-array-access). However, unlike `Array` and `List`, vector length is specified on creation and cannot be changed later.

[code asset](assets/Vector.hx)

`haxe.ds.Vector` is implemented as an abstract type ([Abstract](types-abstract)) over a native array implementation for given target and can be faster for fixed-size collections, because the memory for storing its elements is pre-allocated.

##### Related content

* See the [Vector API](https://api.haxe.org/haxe/ds/Vector.html) for details about the vector methods. 
* [Data structures tutorials and examples](http://code.haxe.org/category/data-structures/) in the Haxe Code Cookbook.



<!--label:std-List-->
#### List

A `List` is a **collection** for storing elements.  On the surface, a list is similar to an [Array](std-Array).  However, the underlying implementation is very different.  This results in several functional differences:

1. A list cannot be indexed using square brackets, i.e. `[0]`.
2. A list cannot be initialized.
3. There are no list comprehensions.
4. A list can freely modify/add/remove elements while iterating over them.

A simple example of working with lists:
[code asset](assets/ListExample.hx)

##### Related content

* See the [List API](https://api.haxe.org/List.html) for details about the list methods. 
* [Data structures tutorials and examples](http://code.haxe.org/category/data-structures/) in the Haxe Code Cookbook.



<!--label:std-GenericStack-->
#### GenericStack

A `GenericStack`, like `Array` and `List` is a container for storing elements.  It has one [type parameter](type-system-type-parameters) and all elements of the stack must be of the specified type.   Here is a small example program for initializing and working with a `GenericStack`.
[code asset](assets/GenericStackExample.hx)

> ##### Trivia: FastList
>
> In Haxe 2, the GenericStack class was known as FastList.  Since its behavior more closely resembled a typical stack, the name was changed for Haxe 3.
The **Generic** in `GenericStack` is literal.  It is attributed with the `:generic` metadata.  Depending on the target, this can lead to improved performance on static targets.  See [Generic](type-system-generic) for more details.

##### Related content

* See the [GenericStack API](https://api.haxe.org/haxe/ds/GenericStack.html) for details about its methods. 
* [Data structures tutorials and examples](http://code.haxe.org/category/data-structures/) in the Haxe Code Cookbook.



<!--label:std-Map-->
#### Map

A `Map` is a container composed of **key**, **value** pairs.  A `Map` is also commonly referred to as an associative array, dictionary, or symbol table. The following code gives a short example of working with maps:

[code asset](assets/MapExample.hx)

Under the hood, a `Map` is an [abstract](types-abstract) type. At compile time, it gets converted to one of several specialized types depending on the **key** type:

* `String`: `haxe.ds.StringMap`
* `Int`: `haxe.ds.IntMap`
* `EnumValue`: `haxe.ds.EnumValueMap`
* `{}`: `haxe.ds.ObjectMap`

The `Map` type does not exist at runtime and has been replaced with one of the above objects. 

Map defines [array access](types-abstract-array-access) using its key type.

##### Related content

* See the [Map API](https://api.haxe.org/Map.html) for details of its methods.
* [Data structures tutorials and examples](http://code.haxe.org/category/data-structures/) in the Haxe Code Cookbook.



<!--label:std-Option-->
#### Option

An [Option](https://api.haxe.org/haxe/ds/Option.html) is an [enum](types-enum-instance) in the Haxe Standard Library which is defined like so:

```haxe
enum Option<T> {
	Some(v:T);
	None;
}
```

It can be used in various situations, such as communicating whether or not a method had a valid return and if so, what value is returned:

[code asset](assets/OptionUsage.hx)





<!--label:std-regex-->
### Regular Expressions

Haxe has built-in support for **regular expressions**. They can be used to verify the format of a string, transform a string or extract some regular data from a given text.

Haxe has special syntax for creating regular expressions. We can create a regular expression object by typing it between the `~/` combination and a single `/` character:

```haxe
var r = ~/haxe/i;
```

Alternatively, we can create regular expression with regular syntax:

```haxe
var r = new EReg("haxe", "i");
```

The first argument is a string with a regular expression pattern, the second one is a string with **flags** (see below).

We can use standard regular expression patterns such as:

* `.` any character
* `*` repeat zero-or-more
* `+` repeat one-or-more
* `?` optional zero-or-one
* `[A-Z0-9]` character ranges
* `[^\r\n\t]` character not-in-range
* `(...)` parenthesis to match groups of characters
* `^` beginning of the string (beginning of a line in multiline matching mode)
* `$` end of the string (end of a line in multiline matching mode)
* <code>&#124;</code> "OR" statement.

For example, the following regular expression matches valid email addresses:
```haxe
~/[A-Z0-9._%-]+@[A-Z0-9.-]+.[A-Z][A-Z][A-Z]?/i;
```

Please notice that the `i` at the end of the regular expression is a **flag** that enables case-insensitive matching.

The possible flags are the following:

* `i` case insensitive matching
* `g` global replace or split, see below
* `m` multiline matching, `^` and `$` represent the beginning and end of a line
* `s` the dot `.` will also match newlines **(not supported by C# and JavaScript versions before ES2018)**
* `u` use UTF-8 matching **(Neko and C++ targets only)**

##### Related content

* See the [EReg API](https://api.haxe.org/EReg.html) for details about its methods. 
* [Haxe snippets and tutorials about regular expressions](http://code.haxe.org/tag/ereg.html) in the Haxe Code Cookbook.

<!--label:std-regex-match-->
#### Matching

Probably one of the most common uses for regular expressions is checking whether a string matches the specific pattern. The `match` method of a regular expression object can be used to do that:
[code asset](assets/ERegMatch.hx)



<!--label:std-regex-groups-->
#### Groups

Specific information can be extracted from a matched string by using **groups**. If `match()` returns true, we can get groups using the `matched(X)` method, where X is the number of a group defined by regular expression pattern:

[code asset](assets/ERegGroups.hx)

Note that group numbers start with 1 and `r.matched(0)` will always return the whole matched substring.

The `r.matchedPos()` will return the position of this substring in the original string:

[code asset](assets/ERegMatchPos.hx)

Additionally, `r.matchedLeft()` and `r.matchedRight()` can be used to get substrings to the left and to the right of the matched substring:

[code asset](assets/ERegMatchLeftRight.hx)



<!--label:std-regex-replace-->
#### Replace

A regular expression can also be used to replace a part of the string:

[code asset](assets/ERegReplace.hx)

We can use `$X` to reuse a matched group in the replacement:

[code asset](assets/ERegReplaceGroups.hx)



<!--label:std-regex-split-->
#### Split

A regular expression can also be used to split a string into several substrings:

[code asset](assets/ERegSplit.hx)



<!--label:std-regex-map-->
#### Map

The `map` method of a regular expression object can be used to replace matched substrings using a custom function. This function takes a regular expression object as its first argument so we may use it to get additional information about the match being done and do conditional replacement. For example:

[code asset](assets/ERegMap.hx)



<!--label:std-regex-implementation-details-->
#### Implementation Details

Regular Expressions are implemented:

* in JavaScript, the runtime is providing the implementation with the object RegExp.
* in Neko and C++, the PCRE library is used
* in Flash, PHP, C# and Java, native implementations are used
* in Flash 6/8, the implementation is not available





<!--label:std-math-->
### Math

Haxe includes a floating point math library for some common mathematical operations. Most of the functions operate on and return `floats`. However, an `Int` can be used where a `Float` is expected, and Haxe also converts `Int` to `Float` during most numeric operations (see [Binary Operators](expression-operators-binops) for more details).

Here are some example uses of the math library:  

[code asset](assets/MathExample.hx)

##### Related content

* See the [Math API documentation](https://api.haxe.org/Math.html) for all available functions.
* [Haxe snippets and tutorials about math](http://code.haxe.org/tag/math.html) in the Haxe Code Cookbook.

<!--label:std-math-special-numbers-->
#### Special Numbers

The math library has definitions for several special numbers:

* NaN (Not a Number): returned when a mathematically incorrect operation is executed, e.g. Math.sqrt(-1)
* POSITIVE_INFINITY: e.g. divide a positive number by zero
* NEGATIVE_INFINITY: e.g. divide a negative number by zero
* PI : 3.1415...



<!--label:std-math-mathematical-errors-->
#### Mathematical Errors

Although neko can fluidly handle mathematical errors, like division by zero, this is not true for all targets.  Depending on the target, mathematical errors may produce exceptions and ultimately errors.



<!--label:std-math-integer-math-->
#### Integer Math

If you are targeting a platform that can utilize integer operations, e.g. integer division, it should be wrapped in **Std.int()** for improved performance.  The Haxe Compiler can then optimize for integer operations.  An example:

```haxe
	var intDivision = Std.int(6.2/4.7);
```



<!--label:std-math-extensions-->
#### Extensions

It is common to see [Static Extension](lf-static-extension) used with the math library.  This code shows a simple example:  
[code asset](assets/MathStaticExtension.hx)

[code asset](assets/MathExtensionUsage.hx)





<!--label:std-Lambda-->
### Lambda

> ##### Define: Lambda
>
> Lambda is a functional language concept within Haxe that allows you to apply a function to a list or [iterators](lf-iterators). The Lambda class is a collection of functional methods in order to use functional-style programming with Haxe.

It is ideally used with `using Lambda` (see [Static Extension](lf-static-extension)) and then acts as an extension to `Iterable` types. 

On static platforms, working with the `Iterable` structure might be slower than performing the operations directly on known types, such as `Array` and `List`.

##### Lambda Functions
The Lambda class allows us to operate on an entire `Iterable` at once.
This is often preferable to looping routines since it is less error-prone and easier to read. 
For convenience, the `Array` and `List` class contains some of the frequently used methods from the Lambda class.

It is helpful to look at an example. The exists function is specified as:

```haxe
static function exists<A>( it : Iterable<A>, f : A -> Bool ) : Bool
```

Most Lambda functions are called in similar ways. The first argument for all of the Lambda functions is the `Iterable` on which to operate. Many also take a function as an argument.

* `Lambda.array`, `Lambda.list` Convert Iterable to `Array` or `List`. It always returns a new instance.
* `Lambda.count` Count the number of elements.  If the Iterable is a `Array` or `List` it is faster to use its length property.
* `Lambda.empty` Determine if the Iterable is empty. For all Iterables it is best to use the this function; it's also faster than compare the length (or result of Lambda.count) to zero.
* `Lambda.has` Determine if the specified element is in the Iterable.
* `Lambda.exists` Determine if criteria is satisfied by an element.
* `Lambda.indexOf` Find out the index of the specified element.
* `Lambda.find` Find first element of given search function.
* `Lambda.foreach` Determine if every element satisfies a criteria.
* `Lambda.iter` Call a function for each element.
* `Lambda.concat` Merge two Iterables, returning a new List.
* `Lambda.filter` Find the elements that satisfy a criteria, returning a new List.
* `Lambda.map`, `Lambda.mapi` Apply a conversion to each element, returning a new List.
* `Lambda.fold` Functional fold, which is also known as reduce, accumulate, compress or inject.

This example demonstrates the Lambda filter and map on a set of strings:

```haxe
using Lambda;
class Main {
    static function main() {
        var words = ['car', 'boat', 'cat', 'frog'];

        var isThreeLetters = function(word) return word.length == 3;
        var capitalize = function(word) return word.toUpperCase();

        // Three letter words and capitalized. 
        trace(words.filter(isThreeLetters).map(capitalize)); // [CAR,CAT]
    }
}
``` 

This example demonstrates the Lambda count, has, foreach and fold function on a set of ints.

```haxe
using Lambda;
class Main {
    static function main() {
        var numbers = [1, 3, 5, 6, 7, 8];

        trace(numbers.count()); // 6
        trace(numbers.has(4)); // false

        // test if all numbers are greater/smaller than 20
        trace(numbers.foreach(function(v) return v < 20)); // true
        trace(numbers.foreach(function(v) return v > 20)); // false

        // sum all the numbers
        var sum = function(num, total) return total += num;
        trace(numbers.fold(sum, 0)); // 30

        // get highest number
        trace(numbers.fold(Math.max, numbers[0])); // 8
        // get lowest number
        trace(numbers.fold(Math.min, numbers[0])); // 1
    }
}
``` 

##### Related content

* See the [Lambda API documentation](https://api.haxe.org/Lambda.html) for all available functions.



<!--label:std-template-->
### Template

Haxe comes with a standard template system with an easy to use syntax which is interpreted by a lightweight class called [haxe.Template](https://api.haxe.org/haxe/Template.html).

A template is a string or a file that is used to produce any kind of string output depending on the input. Here is a small template example:

[code asset](assets/Template.hx)

The console will trace `My name is Mark, 30 years old`.

##### Expressions
An expression can be put between the `::`, the syntax allows the current possibilities:

* `::name::` the variable name
* `::expr.field::` field access
* `::(expr)::` the expression expr is evaluated
* `::(e1 op e2)::` the operation op is applied to e1 and e2
* `::(135)::` the integer 135. Float constants are not allowed

##### Conditions
It is possible to test conditions using `::if flag1::`. Optionally, the condition may be followed by `::elseif flag2::` or `::else::`. Close the condition with `::end::`.

```
::if isValid:: valid ::else:: invalid ::end::
``` 

Operators can be used but they don't deal with operator precedence. Therefore it is required to enclose each operation in parentheses `()`. Currently, the following operators are allowed: `+`, `-`, `*`, `/`, `>`, `<`,  `>=`, `<=`, `==`, `!=`, `&&` and <code>&#124;&#124;</code>.

For example `::((1 + 3) == (2 + 2))::` will display true. 

``` 
::if (points == 10):: Great! ::end::
``` 

To compare to a string, use double quotes `"` in the template.
```
::if (name == "Mark"):: Hi Mark ::end::
``` 

##### Iterating
Iterate on a structure by using `::foreach::`. End the loop with `::end::`.
```xml
<table>
	<tr>
		<th>Name</th>
		<th>Age</th>
	</tr>
	::foreach users::
		<tr>
			<td>::name::</td>
			<td>::age::</td>
		</tr>
	::end::
</table>
``` 

##### Sub-templates
To include templates in other templates, pass the sub-template result string as a parameter.
```haxe
var users = [{name:"Mark", age:30}, {name:"John", age:45}];

var userTemplate = new haxe.Template("::foreach users:: ::name::(::age::) ::end::");
var userOutput = userTemplate.execute({users: users});

var template = new haxe.Template("The users are ::users::");
var output = template.execute({users: userOutput});
trace(output);
``` 
The console will trace `The users are Mark(30) John(45)`.

##### Template macros
To call custom functions while parts of the template are being rendered, provide a `macros` object to the argument of [Template.execute](https://api.haxe.org/haxe/Template.html#execute). The key will act as the template variable name, the value refers to a callback function that should return a `String`. The first argument of this macro function is always a `resolve()` method, followed by the given arguments. The resolve function can be called to retrieve values from the template context. If `macros` has no such field, the result is unspecified.

The following example passes itself as macro function context and executes `display` from the template.
[code asset](assets/TemplateMacros.hx)

The console will trace `The results: Mark ran 3.5 kilometers in 15 minutes`.

##### Globals
Use the [Template.globals](https://api.haxe.org/haxe/Template.html#globals) object to store values that should be applied across all `haxe.Template` instances. This has lower priority than the context argument of `Template.execute`.

##### Using resources

To separate the content from the code, consider using the [resource embedding system](cr-resources). 
Place the template-content in a new file called `sample.mtt`, add `--resource sample.mtt@my_sample` to the compiler arguments and retrieve the content using `haxe.Resource.getString`.
[code asset](assets/TemplateResource.hx)

When running the template system on the server side, you can simply use `neko.Lib.print` or `php.Lib.print` instead of trace to display the HTML template to the user.

##### Related content

* See the [Template API](https://api.haxe.org/haxe/Template.html) for details about its methods.



<!--label:std-reflection-->
### Reflection

Haxe supports runtime reflection of types and fields. Special care has to be taken here because runtime representation generally varies between targets. In order to use reflection correctly, it is necessary to understand what kind of operations are supported and what is not. Given the dynamic nature of reflection, this can not always be determined at compile-time.

The reflection API consists of two classes:

* Reflect: A lightweight API which work best on [anonymous structures](types-anonymous-structure), with limited support for [classes](types-class-instance). 
* Type: A more robust API for working with classes and [enums](types-enum-instance).

The available methods are detailed in the API for [Reflect](https://api.haxe.org/Reflect.html) and [Type](https://api.haxe.org/Type.html).

Reflection can be a powerful tool, but it is important to understand why it can also cause problems. As an example, several functions expect a [String](std-String) argument and try to resolve it to a type or field. This is vulnerable to typing errors:

[code asset](assets/ReflectionTypo.hx)

However, even if there are no typing errors it is easy to come across unexpected behavior:

[code asset](assets/ReflectionMissingType.hx)

The problem here is that the compiler never actually "sees" the type `haxe.Template`, so it does not compile it into the output. Furthermore, even if it were to see the type there could be issues arising from [dead code elimination](cr-dce) eliminating types or fields which are only used via reflection.

Another set of problems comes from the fact that, by design, several reflection functions expect arguments of type [Dynamic](types-dynamic), meaning the compiler cannot check if the passed in arguments are correct. 

The following example demonstrates a common mistake when working with `callMethod`:

[code asset](assets/ReflectionWrongUsage.hx)

The commented out call would be accepted by the compiler because it assigns the string `"f"` to the function argument `func` which is specified to be `Dynamic`.

A good advice when working with reflection is to wrap it in a few functions within an application or API which are called by otherwise type-safe code. An example could look like this:

[code asset](assets/ReflectionWrap.hx)

While the method `reflective` could internally work with reflection (and `Dynamic` for that matter) a lot, its return value is a typed structure which the callers can use in a type-safe manner.



<!--label:std-serialization-->
### Serialization

Many runtime values can be serialized and deserialized using the [haxe.Serializer](https://api.haxe.org/haxe/Serializer.html) and [haxe.Unserializer](https://api.haxe.org/haxe/Unserializer.html) classes. Both support two usages:

1. Create an instance and continuously call the `serialize`/`unserialize` method to handle multiple values.
2. Call their static `run` method to serialize/deserialize a single value.

The following example demonstrates the first usage:

[code asset](assets/SerializationExample.hx)

The result of the serialization (here stored in local variable `s`) is a [String](std-String) and can be passed around at will, even remotely. Its format is described in [Serialization format](std-serialization-format).

##### Supported values

* `null`
* `Bool`, `Int` and `Float` (including infinities and `NaN`)
* `String`
* `Date`
* `haxe.io.Bytes` (encoded as base64)
* [`Array`](std-Array) and [`List`](std-List)
* `haxe.ds.StringMap`, `haxe.ds.IntMap` and `haxe.ds.ObjectMap`
* [anonymous structures](types-anonymous-structure)
* Haxe [class instances](types-class-instance) (not native ones)
* [enum instances](types-enum-instance)

##### Serialization configuration

Serialization can be configured in two ways. For both a static variable can be set to influence all [haxe.Serializer](https://api.haxe.org/haxe/Serializer.html) instances, and a member variable can be set to only influence a specific instance:

* `USE_CACHE`, `useCache`: If true, repeated structures or class/ enum instances are serialized by reference. This can avoid infinite loops for recursive data at the expense of longer serialization time. By default, object caching is disabled; strings, however, are always cached.
* `USE_ENUM_INDEX`, `useEnumIndex`: If true, enum constructors are serialized by their index instead of their name. This can make the resulting string shorter but breaks if enum constructors are inserted into the type before deserialization. This behavior is disabled by default.

##### Deserialization behavior

If the serialization result is stored and later used for deserialization, care has to be taken to maintain compatibility when working with class and enum instances. It is then important to understand exactly how unserialization is implemented.

* The type has to be available in the runtime where the deserialization is made. If [dead code elimination](cr-dce) is active, a type which is used only through serialization might be removed.
* Each `Unserializer` has a member variable `resolver` which is used to resolve classes and enums by name. Upon creation of the `Unserializer` this is set to `Unserializer.DEFAULT_RESOLVER`. Both that and the instance member can be set to a custom resolver.
* Classes are resolved by name using `resolver.resolveClass(name)`. The instance is then created using `Type.createEmptyInstance`, which means that the class constructor is not called. Finally, the instance fields are set according to the serialized value.
* Enums are resolved by name using `resolver.resolveEnum(name)`. The enum instance is then created using `Type.createEnum`, using the serialized argument values if available. If the constructor arguments were changed since serialization, the result is unspecified.

##### Custom (de)serialization

If a class defines the member method `hxSerialize`, that method is called by the serializer and allows custom serialization of the class. Likewise, if a class defines the member method `hxUnserialize` it is called by the deserializer:

[code asset](assets/SerializationCustom.hx)

In this example, we decide that we want to ignore the value of member variable `y` and do not serialize it. Instead we default it to `-1` in `hxUnserialize`. Both methods are annotated with the `@:keep` metadata to prevent [dead code elimination](cr-dce) from removing them as they are never properly referenced in the code.

See [Serializer](https://api.haxe.org/haxe/Serializer.html) and [Unserializer](https://api.haxe.org/haxe/Unserializer.html) API documentation for details.

<!--label:std-serialization-format-->
#### Serialization format

Each supported value is translated to a distinct prefix character, followed by the necessary data.

* `null`: `n`
* `Int`: `z` for zero, or `i` followed by the integer display (e.g. `i456`)
* `Float`: 

    * `NaN`: `k`
    * negative infinity: `m`
    * positive infinity: `p`
    * finite floats: `d` followed by the float display (e.g. `d1.45e-8`)
* `Bool`: `t` for `true`, `f` for `false`
* `String`: `y` followed by the url encoded string length, then `:` and the url encoded string (e.g. `y10:hi%20there for "hi there".`
* name-value pairs: a serialized string representing the name followed by the serialized value
* structure: `o` followed by the list of name-value pairs and terminated by `g` (e.g. `oy1:xi2y1:kng` for `{x:2, k:null}`)
* `List`: `l` followed by the list of serialized items, followed by `h` (e.g. `lnnh` for a list of two `null` values)
* `Array`: `a` followed by the list of serialized items, followed by `h`. For multiple consecutive `null` values, `u` followed by the number of `null` values is used (e.g. `ai1i2u4i7ni9h for [1,2,null,null,null,null,7,null,9]`)
* `Date`: `v` followed by the date itself (e.g. `v2010-01-01 12:45:10`)
* `haxe.ds.StringMap`: `b` followed by the name-value pairs, followed by `h` (e.g. `by1:xi2y1:knh` for `{"x" => 2, "k" => null}`)
* `haxe.ds.IntMap`: `q` followed by the key-value pairs, followed by `h`. Each key is represented as `:<int>` (e.g. `q:4n:5i45:6i7h` for `{4 => null, 5 => 45, 6 => 7}`)
* `haxe.ds.ObjectMap`: `M` followed by serialized value pairs representing the key and value, followed by `h`
* `haxe.io.Bytes`: `s` followed by the length of the base64 encoded bytes, then `:` and the byte representation using the codes `A-Za-z0-9%` (e.g. `s3:AAA` for 2 bytes equal to `0`, and `s10:SGVsbG8gIQ` for `haxe.io.Bytes.ofString("Hello !")`)
* exception: `x` followed by the exception value
* class instance: `c` followed by the serialized class name, followed by the name-value pairs of the fields, followed by `g` (e.g. `cy5:Pointy1:xzy1:yzg` for `new Point(0, 0)` (having two integer fields `x` and `y`)        
* enum instance (by name): `w` followed by the serialized enum name, followed by the serialized constructor name, followed by `:`, followed by the number of arguments, followed by the argument values (e.g. `wy3:Fooy1:A:0` for `Foo.A` (with no arguments), `wy3:Fooy1:B:2i4n` for `Foo.B(4,null)`)
* enum instance (by index): `j` followed by the serialized enum name, followed by `:`, followed by the constructor index (starting from 0), followed by `:`, followed by the number of arguments, followed by the argument values (e.g. `jy3:Foo:0:0` for `Foo.A` (with no arguments), `jy3:Foo:1:2i4n` for `Foo.B(4,null)`)
* cache references: 

    * `String`: `R` followed by the corresponding index in the string cache (e.g. `R456`)
    * class, enum or structure `r` followed by the corresponding index in the object cache (e.g. `r42`)
* custom: `C` followed by the class name, followed by the custom serialized data, followed by `g`

 Cached elements and enum constructors are indexed from zero.





<!--label:std-Xml-->
### Xml

Haxe provides built-in support for working with **XML** data via the [haxe.Xml](https://api.haxe.org/Xml.html) class.

<!--label:std-Xml-getting-started-->
#### Getting started with Xml

##### Creating a root element

A `Xml` root element can be created using the `Xml.createElement` method.
```haxe
var root = Xml.createElement('root');
trace(root); // <root />
```

An root node element can also be created by parsing a `String` containing the XML data.
```haxe
var root = Xml.parse('<root />').firstElement();
trace(root); // <root />
```

##### Creating child elements

Adding child elements to the root can be done using the `addChild` method.
```haxe
var child:Xml = Xml.createElement('child'); 
root.addChild(child);
trace(root); // <root><child/></root>
```

Adding attributes to an element can be done by using the `set()` method.
```haxe
child.set('name', 'John');
trace(root); // <root><child name="John"/></root>
```

##### Accessing elements and values

This code parses an XML string into an object structure `Xml` and then accesses properties of the object.
```haxe
var xmlString = '<hello name="world!">Haxe is great!</hello>';
var xml:Xml = Xml.parse(xmlString).firstElement();

trace(xml.nodeName); // hello
trace(xml.get('name')); // world!
trace(xml.firstChild().nodeValue); // Haxe is great!
```

The difference between `firstChild` and `firstElement` is that the second function will return the first child with the type `Xml.Element`. 

##### Iterate on Xml elements
We can as well use other methods to iterate either over children or elements.
```haxe
for (child in xml) {
	// iterate on all children.
}
for (elt in xml.elements()) {
	// iterate on all elements.
}
for (user in xml.elementsNamed("user")) {
	// iterate on all elements with a nodeName "user".
}
for (att in xml.attributes()) {
	// iterator on all attributes.
}
```

See [Xml](https://api.haxe.org/Xml.html) API documentation for details about its methods.



<!--label:std-Xml-parsing-->
#### Parsing Xml

The static method [Xml.parse](https://api.haxe.org/Xml.html#parse) can be used to parse **XML** data and obtain a Haxe value from it.

```haxe
var xml = Xml.parse('<root>Haxe is great!</root>').firstElement();
trace(xml.firstChild().nodeValue);
```



<!--label:std-Xml-encoding-->
#### Encoding Xml

The method [xml.toString()](https://api.haxe.org/Xml.html#toString) can be used to obtain the `String` representation.
```haxe
var xml = Xml.createElement('root');
xml.addChild(Xml.createElement('child1'));
xml.addChild(Xml.createElement('child2'));

trace(xml.toString()); // <root><child1/><child2/></root>
```



<!--label:std-Xml-simplified-access-->
#### Simplified Xml access

The [haxe.xml.Access](https://api.haxe.org/haxe/xml/Access.html) API exists to provide a dot-syntax access to the most common `Xml` methods.

Since Haxe 4 this class is named `haxe.xml.Access`. In Haxe 3 it was known as `haxe.xml.Fast`.

Here's an example of XML Access usage:
```haxe
// parse some XML data
var xml = Xml.parse("
  <user name='John'>
    <phone>
      <number>0000</number>
      <number>111</number>
    </phone>
  </user>
");
// wrap the Xml for Access
var access = new haxe.xml.Access(xml.firstElement());

// access attributes
trace(access.att.name); // attribute "name"
if (access.has.age) trace( access.att.age ); // optional attribute

// access the "phone" child, which is wrapped with haxe.xml.Access too
var phone = access.node.phone;

// iterate over numbers
for (p in phone.nodes.number) {
  trace(p.innerData);
}
```
This code works the same on all platforms.

##### Accessors
There are different accessors that can be used with the Access API:

* `.name` returns the name of the current element (same as `Xml.nodeName`).
* `.x` returns the current corresponding `Xml` node.
* `.att.<name>` access to a given attribute. An exception is thrown if the attribute doesn't exists.
* `.has.<name>` check the existence of an attribute.
* `.elements` the list of all sub-elements (which are the nodes with type `Xml.Element`).
* `.node.<name>` access to the first sub element with the given name. An exception is thrown if the element doesn't exists.
* `.nodes.<name>` returns a List of elements with the given name.
* `.hasNode.<name>` check the existence of a sub node with the given name.
* `.innerData` returns the inner `PCDATA` or `CDATA` of the node. An exception is thrown if there is no data or if there not only data but also other nodes.
* `.innerHTML` returns the XML string built with all the sub nodes, excluding the current one.

##### Self-closed nodes
Please note that we cannot access self-closed nodes as "regular" ones. 
For example, provided this XML:

```haxe
var xml = Xml.parse("<xml>
  <myNode1></myNode1>
  <myNode2/>
</xml>");

var access = new haxe.xml.Access(xml.firstElement());

var myNode1Value = access.node.myNode1.innerData; 
// no problem

var myNode2Value = access.node.myNode2.innerData; 
// ERROR, an exception is thrown!
```

If the XML might contain self-closed nodes, check `hasNode.innerData` before and default to an alternative value.

```haxe
var myNode2Value = access.node.myNode2.hasNode.innerData ? access.node.myNode2.innerData : null; 
```





<!--label:std-Json-->
### Json

Haxe provides built-in support for (de-)serializing **JSON** data via the `haxe.Json` class.

##### Related content

* See the [Haxe Json API documentation](https://api.haxe.org/haxe/Json.html).
* [Haxe snippets and tutorials about JSON](http://code.haxe.org/tag/json.html) in the Haxe Code Cookbook.

<!--label:std-Json-parsing-->
#### Parsing JSON

Use the [haxe.Json.parse](https://api.haxe.org/haxe/Json.html#parse) static method to parse **JSON** data and obtain a Haxe value from it:
[code asset](assets/JsonParse.hx)

Note that the type of the object returned by `haxe.Json.parse` is `Dynamic`, so if the structure of our data is well-known, we may want to specify a type using [anonymous structures](types-anonymous-structure). This way we provide compile-time checks for accessing our data and most likely more optimal code generation because the compiler knows about types in a structure:
[code asset](assets/JsonParseTyped.hx)



<!--label:std-Json-encoding-->
#### Encoding JSON

Use the [haxe.Json.stringify](https://api.haxe.org/haxe/Json.html#stringify) static method to encode a Haxe value into a **JSON** string:
[code asset](assets/JsonStringify.hx)



<!--label:std-Json-implementation-details-->
#### Implementation details

The [haxe.Json](https://api.haxe.org/haxe/Json.html) API automatically uses native implementation on targets where it is available, i.e. **JavaScript**, **Flash** and **PHP** and provides its own implementation for other targets.

Usage of Haxe own implementation can be forced with `-D haxeJSON` compiler argument. This will also provide serialization of [enums](types-enum-instance) by their index, [maps](std-Map) with string keys and class instances.

Older browsers (Internet Explorer 7, for instance) may not have a native **JSON** implementation. In case it's required to support them, we can include one of the JSON implementations available on the internet in the HTML page.





<!--label:std-input-output-->
### Input/Output

<!--subtoc-->



<!--label:std-sys-->
### Sys

The majority of Haxe targets are so-called "sys" targets. This means the targets have access to system APIs such as the filesystem, networking, threads, and more. The only non-sys targets supported by Haxe are Flash, and JavaScript, although JavaScript can support sys APIs when running under Node.js runtime.

##### Related content

* See the [sys package](https://api.haxe.org/sys/) on the API documentation for more details on its classes.

<!--label:std-threading-->
#### Threading

##### since Haxe 4.0.0

A [unified threading API](https://api.haxe.org/sys/thread/Thread.html) is available on some sys targets. The compile-time define `target.threaded` is set when the API is available. The API allows very simple creation of threads from functions:

[code asset](assets/Threads.hx)

All spawned threads are treated as daemon threads, meaning that the main thread will not wait for their completion.

Due to threads having access to a shared memory space with all the Haxe variables and objects, it is possible to run into issues due to deadlocks and race conditions. The standard library provides some core synchronization constructs in the [`sys.thread`](https://api.haxe.org/sys/thread/) package.





<!--label:std-remoting-->
### Remoting

##### since Haxe 4.0.0

**Deprecated:** The remoting API has been removed from the standard library in Haxe 4. For compatibility purposes it is still available in the [hx3compat](https://github.com/HaxeFoundation/hx3compat/) library. See [Haxe 3 Compatibility](std-hx3compat).

Haxe remoting is a way to communicate between different platforms. With Haxe remoting, applications can transmit data transparently, send data and call methods between server and client side.

##### Related content

* See the [remoting package](https://api.haxe.org/haxe/remoting/) on the API documentation for more details on its classes.

<!--label:std-remoting-connection-->
#### Remoting Connection

In order to use remoting, there must be a connection established. There are two kinds of Haxe Remoting connections: 

* [haxe.remoting.Connection](https://api.haxe.org/haxe/remoting/Connection.html) is used for **synchronous connections**, where the results can be directly obtained when calling a method. 
* [haxe.remoting.AsyncConnection](https://api.haxe.org/haxe/remoting/AsyncConnection.html) is used for **asynchronous connections**, where the results are events that will happen later in the execution process.

##### Start a connection
There are some target-specific constructors with different purposes that can be used to set up a connection:

* All targets:

    * `HttpAsyncConnection.urlConnect(url:String)`  Returns an asynchronous connection to the given URL which should link to a Haxe server application. 
* Flash:

    * `ExternalConnection.jsConnect(name:String, ctx:Context)`  Allows a connection to the local JavaScript Haxe code. The JS Haxe code must be compiled with the class ExternalConnection included. This only works with Flash Player 8 and higher.
    * `AMFConnection.urlConnect(url:String)` and `AMFConnection.connect( cnx : NetConnection )`  Allows a connection to an [AMF Remoting server](http://en.wikipedia.org/wiki/Action_Message_Format) such as [Flash Media Server](http://www.adobe.com/products/adobe-media-server-family.html) or [AMFPHP](http://www.silexlabs.org/amfphp/).
    * `SocketConnection.create(sock:flash.XMLSocket)`  Allows remoting communications over an `XMLSocket`
    * `LocalConnection.connect(name:String)`  Allows remoting communications over a [Flash LocalConnection](https://api.haxe.org/haxe/remoting/LocalConnection.html)
* JavaScript:

    * `ExternalConnection.flashConnect(name:String, obj:String, ctx:Context)`  Allows a connection to a given Flash Object. The Haxe Flash content must be loaded and it must include the `haxe.remoting.Connection` class. This only works with Flash 8 and higher. 
* Neko:

    * `HttpConnection.urlConnect(url:String)`  Will work like the asynchronous version but in synchronous mode.
    * `SocketConnection.create(...)`  Allows real-time communications with a Flash client which is using an `XMLSocket` to connect to the server.

##### Remoting context

Before communicating between platforms, a remoting context has to be defined. This is a shared API that can be called on the connection at the client code.

This server code example creates and shares an API:
```haxe
class Server {
	function new() { }
	function foo(x, y) { return x + y; }

	static function main() {
		var ctx = new haxe.remoting.Context();
		ctx.addObject("Server", new Server());

		if(haxe.remoting.HttpConnection.handleRequest(ctx))
		{
			return;
		}

		// handle normal request
		trace("This is a remoting server !");
	} 
}
```

##### Using the connection

Using a connection is pretty convenient. Once the connection is obtained, use classic dot-access to evaluate a path and then use `call()` to call the method in the remoting context and get the result.
The asynchronous connection takes an additional function parameter that will be called when the result is available.

This client code example connects to the server remoting context and calls a function `foo()` on its API.
```haxe
class Client {
  static function main() {
    var cnx = haxe.remoting.HttpAsyncConnection.urlConnect("http://localhost/");
    cnx.setErrorHandler( function(err) { trace('Error: $err'); } );
    cnx.Server.foo.call([1,2], function(data) { trace('Result: $data'); });
  }
}
```

To make this work for the Neko target, set up a Neko Web Server, point the url in the Client to `"http://localhost2000/remoting.n"` and compile the Server using `--main Server --neko remoting.n`.

##### Error handling

* When an error occurs in an asynchronous call, the error handler is called as seen in the example above.
* When an error occurs in a synchronous call, an exception is raised on the caller-side as if we were calling a local method.

##### Data serialization

Haxe Remoting can send a lot of different kinds of data. See [Serialization](std-serialization).

##### Related content

* See the [remoting package](https://api.haxe.org/haxe/remoting/) on the API documentation for more details on its classes.



<!--label:std-remoting-implementation-details-->
#### Implementation details

##### JavaScript security specifics

The html-page wrapping the js client must be served from the same domain as the one where the server is running. The same-origin policy restricts how a document or script loaded from one origin can interact with a resource from another origin. The same-origin policy is used as a means to prevent some of the cross-site request forgery attacks.

To use the remoting across domain boundaries, CORS (cross-origin resource sharing) needs to be enabled by defining the header `X-Haxe-Remoting` in the `.htaccess`:

```
# Enable CORS
Header set Access-Control-Allow-Origin "*"
Header set Access-Control-Allow-Methods: "GET,POST,OPTIONS,DELETE,PUT"
Header set Access-Control-Allow-Headers: X-Haxe-Remoting
``` 

See [same-origin policy](http://en.wikipedia.org/wiki/Same-origin_policy) for more information on this topic.

Also, note that this means that the page can't be served directly from the file system `"file:///C:/example/path/index.html"`.

##### Flash security specifics

When Flash accesses a server from a different domain, set up a `crossdomain.xml` file on the server, enabling the `X-Haxe` headers.

```xml
<cross-domain-policy>
	<allow-access-from domain="*"/> <!-- or the appropriate domains -->
	<allow-http-request-headers-from domain="*" headers="X-Haxe*"/>
</cross-domain-policy>
``` 

##### Arguments types are not ensured

There is no guarantee of any kind that the types of arguments will be respected when a method is called using remoting. 
That means even if the arguments of function `foo` are typed to `Int`, the client will still be able to use strings while calling the method. 
This can lead to security issues in some cases. When in doubt, check the argument type when the function is called by using the `Std.is` method.





<!--label:std-unit-testing-->
### Unit Testing

##### since Haxe 4.0.0

**Deprecated:** The unit testing API has been removed from the standard library in Haxe 4. For compatibility purposes it is still available in the [hx3compat](https://github.com/HaxeFoundation/hx3compat/) library. See [Haxe 3 Compatibility](std-hx3compat).

The Haxe Standard Library provides basic unit testing classes from the [haxe.unit](https://api.haxe.org/haxe/unit/) package. 

##### Creating new test cases

First, create a new class extending [haxe.unit.TestCase](https://api.haxe.org/haxe/unit/TestCase.html) and add own test methods. Every test method name must start with "`test`".

[code asset](assets/UnitTestCase.hx)

##### Running unit tests
To run the test, an instance of [haxe.unit.TestRunner](https://api.haxe.org/haxe/unit/TestRunner.html) has to be created. Add the [TestCase](https://api.haxe.org/haxe/unit/TestCase.html) using the `add` method and call `run` to start the test.

[code asset](assets/UnitTestRunner.hx)

The result of the test looks like this:
```
Class: MyTestCase
.
OK 1 tests, 0 failed, 1 success
``` 

##### Test functions
The `haxe.unit.TestCase` class comes with three test functions.

* `assertEquals(expected, actual)` Succeeds if `expected` and `actual` are equal
* `assertTrue(a)` Succeeds if `a` is `true`
* `assertFalse(a)` Succeeds if `a` is `false`

##### Setup and tear down

To run code before or after the test, override the functions `setup` and `tearDown` in the `TestCase`. 

* `setup` is called before each test runs.
* `tearDown` is called once after all tests are run.

[code asset](assets/UnitTestSetup.hx)

##### Comparing Complex Objects

With complex objects, it can be difficult to generate expected values to compare to the actual ones. It can also be a problem that `assertEquals` doesn't do a deep comparison. One way around these issues is to use a string as the expected value and compare it to the actual value converted to a string using `Std.string`. Below is a trivial example using an array.

```haxe
public function testArray() {
  var actual = [1,2,3];
  assertEquals("[1, 2, 3]", Std.string(actual));
}
``` 

##### Run unit test

This is an example showing how to run your unit tests (on Neko and Node.js) after compilation using a [HXML](compiler-usage-hxml).

```hxml 
-p source/main/haxe
-p source/test/haxe
--main your.package.TestRunnerMain
--each

--neko output/neko/test.n
--cmd neko ./output/neko/test.n
--next

--js output/javascript/test.js
--cmd node ./output/javascript/test.js
``` 

##### Related content

* See the [haxe.unit](https://api.haxe.org/haxe/unit/) package on the API documentation for more details.



<!--label:std-hx3compat-->
### Haxe 3 Compatibility

##### since Haxe 4.0.0

Some APIs that were originally a part of the standard library have been removed in Haxe 4. To allow projects to transition from Haxe 3 more smoothly, the [hx3compat](https://github.com/HaxeFoundation/hx3compat/) library still provides these APIs. To use it, simply install it and compile the project with `-L hx3compat`.

The full list of APIs in hx3compat is:

* `haxe.remoting.*` Haxe remoting
* `haxe.unit.*` Unit testing
* `haxe.web.*` Web request classes for Haxe web servers
* `neko.net.*` Neko web server
* (JavaScript target only) jQuery and SWFObject externs

Note that some of these APIs were removed from the standard library in favour of solutions in external libraries:

* [utest](https://github.com/haxe-utest/utest) is a Haxe unit testing library.
* [hxnodejs](https://github.com/HaxeFoundation/hxnodejs) can be used to produce Node.js web servers in Haxe.


