## 6 Language Features

**[Abstract types](types-abstract.md):**

An abstract type is a compile-time construct which is represented in a different way at runtime. This allows giving a whole new meaning to existing types.

**[Extern classes](lf-externs.md):**

Externs can be used to describe target-specific interaction in a type-safe manner.

**[Anonymous structures](types-anonymous-structure.md):**

Data can easily be grouped in anonymous structures, minimizing the necessity of small data classes.

```haxe
var point = { x: 0, y: 10 };
point.x += 10;
```

**[Array Comprehension](lf-array-comprehension.md):**

Create and populate arrays quickly using for loops and logic.

```haxe
var evenNumbers = [ for (i in 0...100) if (i%2==0) i ];
```

**[Classes, interfaces and inheritance](types-class-instance.md):**

Haxe allows structuring code in classes, making it an object-oriented language. Common related features known from languages such as Java are supported, including inheritance and interfaces.

**[Conditional compilation](lf-condition-compilation.md):**

Conditional Compilation allows compiling specific code depending on compilation parameters. This is instrumental for abstracting target-specific differences, but can also be used for other purposes, such as more detailed debugging.

```haxe
#if js
    js.Lib.alert("Hello");
#elseif sys
    Sys.println("Hello");
#end
```

**[(Generalized) Algebraic Data Types](types-enum-instance.md):**

Structure can be expressed through algebraic data types (ADT), which are known as enums in the Haxe Language. Furthermore, Haxe supports their generalized variant known as GADT.

```haxe
enum Result {
    Success(data:Array<Int>);
    UserError(msg:String);
    SystemError(msg:String, position:PosInfos);
}
```

**[Inlined calls](class-field-inline.md):**

Functions can be designed as being inline, allowing their code to be inserted at call-site. This can yield significant performance benefits without resorting to code duplication via manual inlining.

**[Iterators](lf-iterators.md):**

Iterating over a set of values, e.g. the elements of an array, is very easy in Haxe courtesy of iterators. Custom classes can quickly implement iterator functionality to allow iteration.

```haxe
for (i in [1, 2, 3]) {
    trace(i);
}
```

**[Local functions and closures](expression-function.md):**

Functions in Haxe are not limited to class fields and can be declared in expressions as well, allowing powerful closures.

```haxe
var buffer = "";
function append(s:String) {
    buffer += s;
}
append("foo");
append("bar");
trace(buffer); // foobar
```

**[Metadata](lf-metadata.md):**

Add metadata to fields, classes or expressions. This can communicate information to the compiler, macros, or runtime classes.

```haxe
class MyClass {
    @range(1, 8) var value:Int;
}
trace(haxe.rtti.Meta.getFields(MyClass).value.range); // [1,8]
```

**[Static Extensions](lf-static-extension.md):**

Existing classes and other types can be augmented with additional functionality through using static extensions.

```haxe
using StringTools;
"  Me & You    ".trim().htmlEscape();
```

**[String Interpolation](lf-string-interpolation.md):**

Strings declared with a single quotes are able to access variables in the current context.

```haxe
trace('My name is $name and I work in ${job.industry}');
```

**[Partial function application](lf-function-bindings.md):** 

Any function can be applied partially, providing the values of some arguments and leaving the rest to be filled in later.

```haxe
var map = new haxe.ds.IntMap();
var setToTwelve = map.set.bind(_, 12);
setToTwelve(1);
setToTwelve(2);
```

**[Pattern Matching](lf-pattern-matching.md):** 

Complex structures can be matched against patterns, extracting information from an enum or a structure and defining specific operations for specific value combination.

```haxe
var a = { foo: 12 };
switch (a) {
    case { foo: i }: trace(i);
    default:
}
```

**[Properties](class-field-property.md):**

Variable class fields can be designed as properties with custom read and write access, allowing fine grained access control.
```haxe
public var color(get,set);
function get_color() {
    return element.style.backgroundColor;
}
function set_color(c:String) {
    trace('Setting background of element to $c');
    return element.style.backgroundColor = c;
}
```

**[Access control](lf-access-control.md):**

The access control language feature uses the Haxe metadata syntax to force or allow access classes or fields.

**[Type Parameters, Constraints and Variance](type-system-type-parameters.md):**

Types can be parametrized with type parameters, allowing typed containers and other complex data structures. Type parameters can also be constrained to certain types and respect variance rules.

```haxe
class Main<A> {
    static function main() {
        new Main<String>("foo");
        new Main(12); // use type inference
    }

    function new(a:A) { }
}
```

---

Previous section: [type check](expression-type-check.md)

Next section: [Conditional Compilation](lf-condition-compilation.md)