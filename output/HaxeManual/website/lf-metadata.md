## 6.9 Metadata

Several constructs can be attributed with custom metadata:

* `class` and `enum` declarations
* Class fields
* Enum constructors
* Expressions

These metadata information can be obtained at runtime through the `haxe.rtti.Meta` API:

```haxe
import haxe.rtti.Meta;

@author("Nicolas")
@debug
class MyClass {
  @range(1, 8)
  var value:Int;

  @broken
  @:noCompletion
  static function method() { }
}

class Main {
  static public function main() {
    // { author : ["Nicolas"], debug : null }
    trace(Meta.getType(MyClass));
    // [1,8]
    trace(Meta.getFields(MyClass).value.range);
    // { broken: null }
    trace(Meta.getStatics(MyClass).method);
  }
}
```

We can easily identify metadata by the leading `@` character, followed by the metadata name and, optionally, by a number of comma-separated constant arguments enclosed in parentheses.

* Class `MyClass` has an `author` metadata with a single String argument `"Nicolas"`, as well as a `debug` metadata without arguments.
* The member variable `value` has a `range` metadata with two Int arguments `1` and `8`.
* The static method `method` has a `broken` metadata without arguments, as well as a `:noCompletion` metadata without arguments.

The `main` method accesses these metadata values using their API. The output reveals the structure of the obtained data:

* There is a field for each metadata, with the field name being the metadata name.
* The field values correspond to the metadata arguments. If there are no arguments, the field value is `null`. Otherwise the field value is an array with one element per argument.
* Metadata starting with `:` is omitted. This kind of metadata is known as **compiler metadata**.

Allowed values for metadata arguments are:

* [Constants](expression-constants.md)
* [Arrays declarations](expression-array-declaration.md) (if all their elements qualify)
* [Object declarations](expression-object-declaration.md) (if all their field values qualify)

###### Built-in Compiler Metadata
An exhaustive list of all defined metadata can be obtained by running `haxe --help-metas` from command line.

See also the [Compiler Metadata list](cr-metadata.md).

---

Previous section: [Function Bindings](lf-function-bindings.md)

Next section: [Access Control](lf-access-control.md)