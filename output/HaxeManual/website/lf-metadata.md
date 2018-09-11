## 6.10 Metadata

Several constructs can be attributed with custom metadata:

* `class` and `enum` declarations
* Class fields
* Enum constructors
* Expressions

These metadata information can be obtained at runtime through the `haxe.rtti.Meta` API:

```haxe
import haxe.rtti.Meta;

@author("Nicolas")
@:keep
class MyClass {
  @range(1, 8)
  var value:Int;

  @broken
  static function method() { }
}

class Main {
  static public function main() {
    // { author : ["Nicolas"] }
    trace(Meta.getType(MyClass));
    // [1,8]
    trace(Meta.getFields(MyClass).value.range);
    // { broken: null }
    trace(Meta.getStatics(MyClass).method);
  }
}
```

We can easily identify metadata by the leading `@` character, followed by the metadata name and, optionally, by a number of comma-separated constant arguments enclosed in parentheses.

* Class `MyClass` has an `author` metadata with a single String argument `"Nicolas"`, as well as a `:keep` metadata without arguments.
* The member variable `value` has a `range` metadata with two Int arguments `1` and `8`.
* The static method `method` has a `broken` metadata without arguments.

The `main` method accesses these metadata values using their API. The output reveals the structure of the obtained data:

* There is a field for each metadata, with the field name being the metadata name.
* The field values correspond to the metadata arguments. If there are no arguments, the field value is `null`. Otherwise the field value is an array with one element per argument.

Allowed values for metadata arguments are:

* [Constants](expression-constants.md)
* [Arrays declarations](expression-array-declaration.md) (if all their elements qualify)
* [Object declarations](expression-object-declaration.md) (if all their field values qualify)

##### Compile-time Metadata

Metadata starting with `:`, such as `@:keep`, is available at compile time only; it is omitted at runtime. It may be used by macros or by the Haxe compiler itself. Unlike runtime metadata, arguments to compile-time metadata can be any valid expression.

##### Built-in Compiler Metadata
An exhaustive list of all defined metadata can be obtained by running `haxe --help-metas` from command line.

##### Related content

* See also the [Compiler Metadata list](cr-metadata.md).

---

Previous section: [Function Bindings](lf-function-bindings.md)

Next section: [Access Control](lf-access-control.md)