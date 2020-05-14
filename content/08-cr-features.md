<!--label:cr-features-->
## Compiler Features

<!--subtoc-->

<!--label:cr-metadata-->
### Built-in Compiler Metadata

Starting from Haxe 3.0, you can get the list of defined compiler metadata by running `haxe --help-metas`

Metadata | Arguments | Description | Platforms 
 --- | --- | --- | ---
<!--include:generated/metas.md-->



<!--label:cr-dce-->
### Dead Code Elimination

Dead Code Elimination or **DCE** is a compiler feature which removes unused code from the output. After typing, the compiler evaluates the DCE entry-points (usually the main method) and recursively determines which fields and types are used. Used fields are marked accordingly and unmarked fields are then removed from their classes.

DCE has three modes which are set when invoking the command line:

* -dce std: Only classes in the Haxe Standard Library are affected by DCE. This is the default setting on all targets.
* -dce no: No DCE is performed.
* -dce full: All classes are affected by DCE.

The DCE-algorithm works well with typed code, but may fail when [dynamic](types-dynamic) or [reflection](std-reflection) is involved. This may require explicit marking of fields or classes as being used by attributing the following metadata:

* `@:keep`: If used on a class, the class along with all fields is unaffected by DCE. If used on a field, that field is unaffected by DCE.
* `@:keepSub`: If used on a class, it works like `@:keep` on the annotated class as well as all subclasses.
* `@:keepInit`: Usually, a class which had all fields removed by DCE (or is empty to begin with) is removed from the output. By using this metadata, empty classes are kept.
* `@:ifFeature("pack.SomeType.field")`: When used on a field, causes the field to be kept if `pack.SomeType.field` is used and not removed by DCE.
* `@:ifFeature("pack.SomeType.*")`: When used on a field, causes the field to be kept if `pack.SomeType` is used and not removed by DCE.

If a class needs to be marked with `@:keep` from the command line instead of editing its source code, there is a compiler macro available for doing so: `--macro keep('type dot path')` See the [haxe.macro.Compiler.keep API](http://api.haxe.org/haxe/macro/Compiler.html#keep) for details of this macro. It will mark package, module or sub-type to be kept by DCE and includes them for compilation.
 
The compiler automatically defines the flag `dce` with a value of either `"std"`, `"no"` or `"full"` depending on the active mode. This can be used in [conditional compilation](lf-condition-compilation).

> ##### Trivia: DCE-rewrite
>
> DCE was originally implemented in Haxe 2.07. This implementation considered a function to be used when it was explicitly typed. The problem with that was that several features, most importantly interfaces, would cause all class fields to be typed in order to verify type-safety. This effectively subverted DCE completely, prompting the rewrite for Haxe 2.10.

> ##### Trivia: DCE and try.haxe.org
>
> DCE for the `JavaScript` target saw vast improvements when the website <http://try.haxe.org> was published. Initial reception of the generated JavaScript code was mixed, leading to a more fine-grained selection of which code to eliminate.



<!--label:cr-completion-->
### Compiler Services

<!--subtoc-->

<!--label:cr-completion-overview-->
#### Overview

The rich [type system](type-system) of the Haxe Compiler makes it difficult for IDEs and editors to provide accurate completion information. Between [type inference](type-system-type-inference) and [macros](macro), it would require a substantial amount of work to replicate the required processing. This is why the Haxe Compiler comes with a built-in completion mode for third-party software to use.

All completion is triggered using the `--display file@position[@mode]` compiler argument. The required arguments are:

* file: The file to check for completion. This must be an absolute or relative path to a .hx file. It does not respect any classpaths or libraries.
* position: The byte position (not character position) of where to check for completion in the given file.
* mode: The completion mode to use (see below).

We will look into the following completion modes in detail:

* [Field access](cr-completion-field-access): Provides a list of fields that can be accessed on a given type.
* [Call argument](cr-completion-call-argument): Reports the type of the function which is currently being called.
* [Type path](cr-completion-type-path): Lists sub-packages, sub-types and static fields.
* [Usage](cr-completion-usage): Lists all occurrences of a given type, field or variable in all compiled files. (mode: `"usage"`)
* [Position](cr-completion-position): Reports the position of where a given type, field or variable is defined. (mode: `"position"`)
* [Top-level](cr-completion-top-level): Lists all identifiers which are available at a given position. (mode: `"toplevel"`)

Due to Haxe being a very fast compiler, it is often sufficient to rely on the normal compiler invocation for completion. For bigger projects, Haxe provides a [server mode](cr-completion-server) which ensures that only those files are re-compiled that actually changed or had any of their dependencies changes.

##### General notes on the interface

* The position-argument can be set to 0 if the file in question contains a pipeline <code>&#124;</code> character at the position of interest. This is very useful for demonstration and testing as it allows us to ignore the byte-counting process a real IDE would have to do. The examples in this section are making use of this feature. Note that this only works in places where <code>&#124;</code> is not valid syntax otherwise, e.g. after dots (<code>.&#124;</code>) and opening parentheses (<code>(&#124;</code>).
* The output is HTML-escaped so that `&`, `<` and `>` become `&amp;amp;`, `&amp;lt;` and `&amp;gt;` respectively.
* Otherwise any documentation output is preserved which means longer documentation might include new-line and tab-characters as it does in the source files.
* When running in completion mode, the compiler does not display errors but instead tries to ignore them or recover from them.  If a critical error occurs while getting completion, the Haxe Compiler prints the error message instead of the completion output. Any non-XML output can be treated as a critical error message.



<!--label:cr-completion-field-access-->
#### Field access completion

Field completion is triggered after a dot `.` character to list the fields that are available on the given type. The compiler parses and types everything up to the point of completion and then outputs the relevant information to stderr:

```haxe
class Main {
  public static function main() {
    trace("Hello".|
  }
}
```

If this file is saved to Main.hx, the completion can be invoked using the command `haxe --display Main.hx@0`. The output looks similar to this (we omit several fields for brevity and improve the formatting for readability):

```xml
<list>
<i n="length">
  <t>Int</t>
  <d>
    The number of characters in `this` String.
  </d>
</i>
<i n="charAt">
  <t>index : Int -&gt; String</t>
  <d>
    Returns the character at position `index` of `this` String.
    If `index` is negative or exceeds `this.length`, the empty String
    "" is returned.
  </d>
</i>
<i n="charCodeAt">
  <t>index : Int -&gt; Null&lt;Int&gt;</t>
  <d>
    Returns the character code at position `index` of `this` String.
    If `index` is negative or exceeds `this.length`, null is returned.
    To obtain the character code of a single character, "x".code can
    be used instead to inline the character code at compile time.
    Note that this only works on String literals of length 1.
  </d>
</i>
</list>
```

The XML structure follows:

* The document node `list` encloses several nodes `i`, each representing a field.
* The `n` attribute contains the name of the field.
* The `t` node contains the type of the field.
* the `d` node contains the documentation of the field.

##### since Haxe 3.2.0

When compiling with `-D display-details`, each field additionally has a `k` attribute which can either be `var` or `method`. This allows distinguishing method fields from variable fields that have a function type.



<!--label:cr-completion-call-argument-->
#### Call argument completion

Call argument completion is triggered after an opening parenthesis character `(` to show the type of the function that is currently being called. It works for any function call as well as constructor calls:

```haxe
class Main {
  public static function main() {
    trace("Hello".split(|
  }
}
```

If this file is saved to Main.hx, the completion can be invoked using the command `haxe --display Main.hx@0`. The output looks like this:

```xml
<type>
delimiter : String -&gt; Array&lt;String&gt;
</type>
```

IDEs can parse this to recognize that the called function requires one argument named `delimiter` of type `String` and returns an `Array<String>`.

> ##### Trivia: Problems with the output structure
>
> We acknowledge that the current format requires a bit of manual parsing which can be annoying. In the future we might look into providing a more structured output, especially for functions.



<!--label:cr-completion-type-path-->
#### Type path completion

Type path completion can occur in [import declarations](type-system-import), [using declarations](lf-static-extension) or any place a type is referenced. We can identify three different cases:

##### package completion

This lists all sub-packages of the haxe package as well as all modules in that package:

```haxe
import haxe.|
```

```xml
<list>
<i n="CallStack"><t></t><d></d></i>
<i n="Constraints"><t></t><d></d></i>
<i n="DynamicAccess"><t></t><d></d></i>
<i n="EnumFlags"><t></t><d></d></i>
<i n="EnumTools"><t></t><d></d></i>
<i n="Http"><t></t><d></d></i>
<i n="Int32"><t></t><d></d></i>
<i n="Int64"><t></t><d></d></i>
<i n="Json"><t></t><d></d></i>
<i n="Log"><t></t><d></d></i>
<i n="PosInfos"><t></t><d></d></i>
<i n="Resource"><t></t><d></d></i>
<i n="Serializer"><t></t><d></d></i>
<i n="Template"><t></t><d></d></i>
<i n="Timer"><t></t><d></d></i>
<i n="Ucs2"><t></t><d></d></i>
<i n="Unserializer"><t></t><d></d></i>
<i n="Utf8"><t></t><d></d></i>
<i n="crypto"><t></t><d></d></i>
<i n="ds"><t></t><d></d></i>
<i n="extern"><t></t><d></d></i>
<i n="format"><t></t><d></d></i>
<i n="io"><t></t><d></d></i>
<i n="macro"><t></t><d></d></i>
<i n="remoting"><t></t><d></d></i>
<i n="rtti"><t></t><d></d></i>
<i n="unit"><t></t><d></d></i>
<i n="web"><t></t><d></d></i>
<i n="xml"><t></t><d></d></i>
<i n="zip"><t></t><d></d></i>
</list>
```

##### import module completion

This lists all [sub-types](type-system-module-sub-types) of the module `haxe.Unserializer` as well as all its public static fields (because these can be imported too):

```haxe
import haxe.Unserializer.|
```

```xml
<list>
<i n="DEFAULT_RESOLVER">
  <t>haxe.TypeResolver</t>
  <d>
    This value can be set to use custom type resolvers.

    A type resolver finds a Class or Enum instance from a given String.
    By default, the haxe Type API is used.

    A type resolver must provide two methods:

    1. resolveClass(name:String):Class&lt;Dynamic&gt; is called to
      determine a Class from a class name
    2. resolveEnum(name:String):Enum&lt;Dynamic&gt; is called to
      determine an Enum from an enum name

    This value is applied when a new Unserializer instance is created.
    Changing it afterwards has no effect on previously created
    instances.
  </d>
</i>
<i n="run">
  <t>v : String -&gt; Dynamic</t>
  <d>
    Unserializes `v` and returns the according value.

    This is a convenience function for creating a new instance of
    Unserializer with `v` as buffer and calling its unserialize()
    method once.
  </d>
</i>
<i n="TypeResolver"><t></t><d></d></i>
<i n="Unserializer"><t></t><d></d></i>
</list>
```

```haxe
using haxe.Unserializer.|
```

##### other module completion

This lists all [sub-types](type-system-module-sub-types) of the module `haxe.Unserializer`:

```haxe
using haxe.Unserializer.|
```

```haxe
class Main {
  static public function main() {
    var x:haxe.Unserializer.|
  }
}
```

```xml
<list>
<i n="TypeResolver"><t></t><d></d></i>
<i n="Unserializer"><t></t><d></d></i>
</list>
```



<!--label:cr-completion-usage-->
#### Usage completion

##### since Haxe 3.2.0

Usage completion is enabled by using the `"usage"` mode argument (see [Overview](cr-completion-overview)). We demonstrate it here using a local variable. Note that it would work with fields and types the same way:

```haxe
class Main {
  public static function main() {
    var a = 1;
    var b = a + 1;
    trace(a);
    a.|
  }
}
```

If this file is saved to Main.hx, the completion can be invoked using the command `haxe --display Main.hx@0@usage`. The output looks like this:

```xml
<list>
<pos>main.hx:4: characters 9-10</pos>
<pos>main.hx:5: characters 7-8</pos>
<pos>main.hx:6: characters 1-2</pos>
</list>
```



<!--label:cr-completion-position-->
#### Position completion

##### since Haxe 3.2.0

Position completion is enabled by using the `"position"` mode argument (see [Overview](cr-completion-overview)). We demonstrate it using a field. Note that it would work with local variables and types the same way:

```haxe
class Main {
  static public function main() {
    "foo".split.|
}
```

If this file is saved to Main.hx, the completion can be invoked using the command `haxe --display Main.hx@0@position`. The output looks like this:

```xml
<list>
<pos>std/string.hx:124: characters 1-54</pos>
</list>
```

> ##### Trivia: Effects of omitting a target specifier
>
> In this example the compiler reports the standard String.hx definition which does not actually have an implementation. This happens because we did not specify any target, which is allowed in completion-mode. If the command line arguments included, say, `--neko neko.n`, the reported position would instead be `std/neko/_std/string.hx:84: lines 84-98`.



<!--label:cr-completion-top-level-->
#### Top-level completion

##### since Haxe 3.2.0

Top-level completion displays all identifiers which the Haxe Compiler knows about at a given compilation position. This is the only completion method for which we need a real position argument in order to demonstrate its effect:

```haxe
class Main {
  static public function main() {
    var a = 1;
  }
}

enum MyEnum {
  MyConstructor1;
  MyConstructor2(s:String);
}
```

If this file is saved to Main.hx, the completion can be invoked using the command `haxe --display Main.hx@63@toplevel`. The output looks similar to this (we omit several entries for brevity):

```xml
<il>
<i k="local" t="Int">a</i>
<i k="static" t="Void -&gt; Unknown&lt;0&gt;">main</i>
<i k="enum" t="MyEnum">MyConstructor1</i>
<i k="enum" t="s : String -&gt; MyEnum">MyConstructor2</i>
<i k="package">sys</i>
<i k="package">haxe</i>
<i k="type" p="Int">Int</i>
<i k="type" p="Float">Float</i>
<i k="type" p="MyEnum">MyEnum</i>
<i k="type" p="Main">Main</i>
</il>
```

The structure of the XML depends on the `k` attribute of each entry. In all cases, the node value of the `i` nodes contains the relevant name.

* `local`, `member`, `static`, `enum`, `global`: The `t` attribute holds the type of the variable or field.
* `global`, `type`: The `p` attribute holds the path of the module which contains the type or field.



<!--label:cr-completion-server-->
#### Completion server

To get the best speed for both compilation and completion, you can use the `--wait` command-line parameter to start a Haxe compilation server. You can also use `-v` to have the server print the log. Here's an example:

```hxml
haxe -v --wait 6000
```

You can then connect to the Haxe server, send command-line parameters followed by a 0 byte and, then, read the response (either completion result or errors).

Use the `--connect` command-line parameter to have Haxe send its compilation commands to the server instead of executing them directly :

```hxml
haxe --connect 6000 myproject.hxml
```

Please note that you can use the parameter `--cwd` at the first sent command line to change the Haxe server's current working directory. Usually, classpaths and other files are relative to your project.

##### How it works
The compilation server will cache the following things:

* parsed files the files will only get parsed again if they are modified or if there was a parse error
* haxelib calls the previous results of haxelib calls will be reused (only for completion : they are ignored when doing a compilation)
* typed modules compilation modules will be cached after a successful compilation and can be reused in later compilation/completions if none of their dependencies have been modified

You can get a precise reading of the times spent by the compiler and how using the compilation server affects them by adding `--times` to the command line.

##### Protocol
As the following Haxe/Neko example shows, you can simply connect on the server port and send all commands (one per line) ending with a 0 binary char. You can, then, read the results.

Macros and other commands can log events which are not errors. From the command line, we can see the difference between what is printed on `stdout` and what is print on `stderr`. This is not the case in socket mode. In order to differentiate between the two, log messages (not errors) are prefixed with a `
x01` character and all newline-characters in the message are replaced by the same `
x01` character.

Warnings and other messages can also be considered errors, but are not fatal ones. If a fatal error occurred, it will send a single `
x02` message-line.

Here's some code that will treat the connection to the server and handle the protocol details:

[code asset](assets/CompletionServer.hx)

##### Effect on macros
The compilation server can have some side effects on [macro execution](macro).





<!--label:cr-resources-->
### Resources

Haxe provides a simple resource embedding system that can be used for embedding files directly into the compiled application.

While it may be not optimal to embed large assets such as images or music in the application file, it comes in very handy for embedding smaller resources like configuration or XML data.

<!--label:cr-resources-embed-->
#### Embedding resources

External files are embedded using the **--resource** compiler argument:

```hxml
--resource hello_message.txt@welcome
```

The string after the **@** symbol is the **resource identifier** which is used in the code for retrieving the resource. If it is omitted (together with the **@** symbol) then the file name will become the resource identifier.



<!--label:cr-resources-getString-->
#### Retrieving text resources

To retrieve the content of an embedded resource we use the static method **getString** of `haxe.Resource`, passing a **resource identifier** to it:

[code asset](assets/ResourceGetString.hx)

The code above will display the content of the **hello_message.txt** file that we included earlier using **welcome** as the identifier.



<!--label:cr-resources-getBytes-->
#### Retrieving binary resources

While it's not recommended to embed large binary files in the application, it still may be useful to embed binary data. The binary representation of an embedded resource can be accessed using the static method **getBytes** of `haxe.Resource`:

[code asset](assets/ResourceGetBytes.hx)

The return type of **getBytes** method is `haxe.io.Bytes`, which is an object providing access to individual bytes of the data.



<!--label:cr-resources-impl-->
#### Implementation details

Haxe uses the target platform's native resource embedding if there is one, otherwise, it provides its own implementation.

* **Flash** resources are embedded as ByteArray definitions
* **C#** resources are included in the compiled assembly
* **Java** resources are packed in the resulting JAR file
* **C++** resources are stored in global byte array constants.
* **JavaScript** resources are serialized in Haxe serialization format and stored in a static field of `haxe.Resource` class.
* **Neko** resources are stored as strings in a static field of `haxe.Resource` class.





<!--label:cr-rtti-->
### Runtime Type Information

The Haxe compiler generates runtime type information (RTTI) for classes that are annotated or extend classes that are annotated with the `:rtti` metadata. This information is stored as a XML string in a static field `__rtti` and can be processed through `haxe.rtti.XmlParser.process()`. The resulting structure is [`haxe.rtti.TypeTree`](https://api.haxe.org/haxe/rtti/TypeTree.html).

##### since Haxe 3.2.0

The type `haxe.rtti.Rtti` has been introduced in order to simplify working with RTTI. Retrieving this information is now very easy:

[code asset](assets/RttiUsage.hx)





<!--label:cr-static-analyzer-->
### Static Analyzer

##### since Haxe 3.3.0

Haxe 3.3.0 introduces a new static analyzer for code optimizations. It is enabled by using the `-D analyzer-optimize` [compiler flag](compiler-usage-flags) and consists of multiple modules which can be configured globally with a [compiler flag](compiler-usage-flags) as well as at type-level and field-level with a [compiler metadata](cr-metadata):

##### Global configuration

To globally enable an analyzer module `-D analyzer-module` is used. To globally disable a module `-D analyzer-no-module` is used. In both cases "module" represents the name of the module to be disabled or enabled:

```hxml
# Global enable from command line
haxe -D analyzer-module
# Global disable from command line
haxe -D analyzer-no-module
```

##### Local configuration

To enable an analyzer module for a given type or field `@:analyzer(module)` is used. To disable a module `@:analyzer(no_module)` is used. In both cases "module" represents the name of the module to be disabled or enabled:

```haxe
@:analyzer(module) // Type-level enable
class C {
	@:analyzer(module) function f() { } // Field-level enable
	@:analyzer(no_module) function f() { } // Field-level disable
}
@:analyzer(no_module) // Type-level disable
class D { }
```

##### Modules

The static analyzer currently comes with the following modules. Unless noted otherwise they are enabled if `-D analyzer-optimize` is used.

* `const_propagation`: Implements sparse conditional constant propagation to promote values that are known at compile-time to usage places. Also detects dead branches.
* `copy_propagation`: Detects local variables that alias other local variables and replaces them accordingly.
* `local_dce`: Detects and removes unused local variables.
* `fusion`: Moves variable expressions to its usage in case of single-occurrence. By default, only compiler-generated variables are handled. This can be changed by using the compiler flag `-D analyzer-user-var-fusion` or the metadata `@:analyzer(user_var_fusion)`.
* `purity_inference`: Infers if fields are "pure", i.e. do not have any side-effects. This can improve the effect of the fusion module.



<!--label:cr-loop-unrolling-->
### Loop unrolling

##### since Haxe 4.0.0

The compiler tries to unroll short iterations of `for` loops over constant ranges. This can produce faster code without the use of a loop:

```haxe
for (i in 0...4) {
  test(i);
}
```

The above code turns into something similar to:

```haxe
test(0);
test(1);
test(2);
test(3);
```

Whether a loop is unrolled or not depends on the loop unrolling cost, which is defined as the number of iterations of the loop and the number of expressions inside the loop body. This threshold is 250 by default but can be configured using the `-D loop_unroll_max_cost=...` compile-time define.



<!--label:cr-tail-recursion-elimination-->
### Tail Recursion Elimination (TRE)

##### since Haxe 4.1.0

Recursion is a natural way to solve some tasks like calculating fibonacci numbers or traversing trees. It's easy to write,
read and understand. But it takes more computational resources at run time than solving the same tasks with loops instead of recursion.

For example a loop-based function to find the root of a tree of nodes:
```haxe
  static function getRoot(node:Node):Node {
    var root = node;
    while(root.parent != null) {
      root = root.parent;
    }
    return root;
  }
```
Its recursive counterpart may look cleaner, but might have worse performance because of additional function calls:
```haxe
  static function getRoot(node:Node):Node {
    if(node.parent == null) {
      return node;
    }
    return getRoot(node.parent);
  }
```

The Haxe compiler since version 4.1.0 can perform automatic recursion-to-loop transformation for functions which end with a recursive call.
This optimization is automatically enabled with the [static analyzer](/manual/cr-static-analyzer.html) (by adding `-D analyzer-optimize` to compilation arguments).
Here's how the aforementioned recursive `getRoot` function looks in the compiled syntax tree with tail recursion elimination (TRE) enabled:
```haxe
static function getRoot(node:Node) {
  while (true) {
    if (node.parent == null) return node;
    node = node.parent;
  }
}
```
The recursive call is automatically replaced with a loop on compilation.

A function must satisfy a number of requirements to be eligible for TRE optimization:

1. The last operation of the function is a recursive call. Even if that call is inside of an `if` or `else` expressions.
2. The function does not have a [`dynamic` accessor](/manual/class-field-dynamic.html).
3. It's a static method or a [final method](/manual/class-field-final.html) or a [local named function](/manual/expression-arrow-function.html).



<!--label:cr-null-safety-->
### Null Safety

##### since Haxe 4.0.0

The Haxe compiler offers opt-in compile-time checking for nullable values. It attempts to catch various possible issues with nullable values.

##### Enabling Null Safety

To enable the checker for a particular class, field, or expression, annotate it with the `:nullSafety` metadata. Null safety can be enabled for a whole package using the `--macro nullSafety("some.package")` [initialization macro](macro-initialization).

##### Strictness

There are three levels of null safety strictness:

* `Off`: Turn off null safety checks. Useful to selectively disable null safety for particular fields or expression.
* `Loose` (Default): Within an `if (<expr> != null)` condition, `<expr>` is considered safe even if it could be modified after the check.
* `Strict`: Full-scale null safety checking for a single-threaded environment.
* `StrictThreaded`: Full-scale null safety checking for a multi-threaded environment.

Enabling null safety by default uses the loose strictness level. This can be configured by providing an argument in the metadata:

```haxe
@:nullSafety(Off)
@:nullSafety(Loose)
@:nullSafety(Strict)
@:nullSafety(StrictThreaded)
```

`Strict` and `StrictThreaded` differ in handling of sequential field access.
In a multi-threaded application sequential access to the same object field may not yeld the same result. That means a null check for a field does not provide any guarantees:
```haxe
@:nullSafety(StrictThreaded)
function demo1(o:{field:Null<String>}) {
  if (o.field != null) {
    // Error: o.field could have been changed to `null` 
    // by another thread after the check
    trace(o.field.length); 
  }
}

@:nullSafety(Strict)
function demo1(o:{field:Null<String>}) {
  if (o.field != null) {
    trace(o.field.length); // Ok
  }
}
```

For the package-level case, null safety strictness can be configured using the optional second argument:

```haxe
--macro nullSafety("some.package", Off)
--macro nullSafety("some.package", Loose)
--macro nullSafety("some.package", Strict)
--macro nullSafety("some.package", StrictThreaded)
```

##### Detailed Usage

* Null safety makes sure you will not pass nullable values to the places which are not explicitly declared with `Null<T>` (assignments, return statements, array access, etc.).
[code asset](assets/NullSafety1.hx)

* Using nullables with unary and binary operators (except `==` and `!=`) is not allowed.
* If a field is declared without `Null<>` then it should have an initial value or it should be initialized in the constructor (for instance fields).
* Passing an instance of a parametrized type with nullable type parameters where the same type with non-nullable type parameters is expected is not allowed:
```haxe
var nullables:Array<Null<String>> = ['hello', null, 'world'];
// Array<Null<String>> cannot be assigned to Array<String>:
//var a:Array<String> = nullables;
```
* Local variables checked against `null` are considered safe inside of a scope covered with that null-check:
```haxe
var nullable:Null<String> = getSomeStr();
//var s:String = nullable; // Compilation error
if (nullable != null) {
  s = nullable; //OK
}
//s = nullable; // Compilation error
s = (nullable == null ? 'hello' : nullable); // OK
switch (nullable) {
  case null:
  case _: s = nullable; // OK
}
```
* Control flow is also taken into account:
```haxe
function doStuff(a:Null<String>) {
  if(a == null) {
    return;
  }
  // From here `a` is safe, because function execution
  // will continue only if `a` is not null:
  var s:String = a; // OK
}
```

##### Limitations

* Out-of-bounds array reads return `null`, but Haxe types them without `Null<>`.
```haxe
var a:Array<String> = ["hello"];
$type(a[100]); // String
trace(a[100]); // null
var s:String = a[100]; // Safety does not complain here, because `a[100]` is not `Null<String>`, but just `String`
```
* Out-of-bounds array writes fill all positions between the last defined index and the newly-written one with `null` values. Null safety cannot protect against this.
```haxe
var a:Array<String> = ["hello"];
a[2] = "world";
trace(a); // ["hello", null, "world"]
var s:String = a[1]; // Cannot check this
trace(s); //null
```
* Haxe was not designed with null safety in mind, so it's always possible `null` values will come into your code from third-party code or even from the standard library.
* Nullable fields and properties are not considered null-safe even after checking against `null`. You can use helper methods instead:
```haxe
using Main.NullTools;
class NullTools {
  public static function sure<T>(value:Null<T>):T {
    if (value == null) {
      throw "null pointer in .sure() call";
    }
    return @:nullSafety(Off) (value:T);
  }
  public static function or<T>(value:Null<T>, defaultValue:T):T {
    if (value == null) {
      return defaultValue;
    }
    return @:nullSafety(Off) (value:T);
  }
}
class Main {
  static var nullable:Null<String>;
  public static function main() {
    var str:String;
    if (nullable != null) {
      str = nullable; // Compilation error
    }
    str = nullable.sure();
    str = nullable.or('hello');
  }
}
```
* If a local variable is captured in a closure, it cannot be safe inside that closure:
```haxe
var a:Null<String> = getSomeStr();
var fn = function () {
  if (a != null) {
    var s:String = a; // Compilation error
  }
}
```
Unless the closure is executed immediately:
```haxe
var a:Null<String> = getSomeStr();
[1, 2, 3].map(function (i) {
  if (a != null) {
    return i * a.length; // OK
  } else {
    return i;
  }
});
```
* If a local variable is captured and modified in a closure with a nullable value, that variable cannot be safe anymore:
```haxe
var nullable:Null<String> = getSomeNullableStr();
var str:String;
if (nullable != null) {
  str = nullable; // OK
  doStuff(function () nullable = getSomeNullableStr());
  if (nullable != null) {
    str = nullable; // Compilation error
  }
}
```
