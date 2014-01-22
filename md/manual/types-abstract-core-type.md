## 2.8.7 Core-type abstracts

The Haxe Standard Library defines a set of basic types as core-type abstracts. They are identified by the `:coreType` metadata and the lack of an underlying type declaration. These abstracts can still be understood to represent a different type, but that type is native to the Haxe target. 

Introducing custom core-type abstracts is rarely necessary in user code as it requires the target Haxe target to be able to make sense of it. However, there could be interesting use-cases for authors of macros and new Haxe targets.

In contrast to opaque abstracts, core-type abstracts have the following properties:



* They have no underlying type.
* They are considered nullable unless they are annotated with `:notNull` metadata.
* They are allowed to declare [array access](types-abstract-array-access.md) functions without expressions.
* [Operator overloading fields](types-abstract-operator-overloading.md) that have no expression are not forced to adhere to the Haxe type semantics.

---

Previous section: [Exposing abstracts](types-abstract-expose.md)

Next section: [Monomorph](types-monomorph.md)