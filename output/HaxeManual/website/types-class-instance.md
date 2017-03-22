## 2.3 Class Instance

Similar to many object-oriented languages, classes are the primary data structure for the majority of programs in Haxe. Each Haxe class has an explicit name, an implied path and zero or more class fields. Here we will focus on the general structure of classes and their relations, while leaving the details of class fields for [Class Fields](class-field.md).

The following code example serves as basis for the remainder of this section:

```haxe
class Point {
  var x : Int;
  var y : Int;
  public function new(x,y) {
    this.x = x;
    this.y = y;
  }
  public function toString() {
    return "Point("+x+","+y+")";
  }
}
```

Semantically, this class represents a point in discrete 2-dimensional space - but this is not important here. Let us instead describe the structure:

* The keyword `class` denotes that we are declaring a class.
* `Point` is the name of the class and could be anything conforming to the [rules for type identifiers](dictionary.md#define-identifier).
* Enclosed in curly braces `{}` are the class fields,
* Which consist of two **variable** fields `x` and `y` of type `Int`,
* followed by a special **function** field named `new`, which is the **constructor** of the class,
* as well as a normal function `toString`.

There is a special type in Haxe which is compatible with all classes:

> ##### Define: `Class<T>`
>
> This type is compatible with all class types which means that all classes (not their instances) can be assigned to it. At compile-time, `Class<T>` is the common base type of all class types. However, this relation is not reflected in generated code.
> 
> This type is useful when an API requires a value to be **a** class, but not a specific one. This applies to several methods of the [Haxe reflection API](std-reflection.md).

---

Previous section: [Optional Arguments and Nullability](types-nullability-optional-arguments.md)

Next section: [Class constructor](types-class-constructor.md)