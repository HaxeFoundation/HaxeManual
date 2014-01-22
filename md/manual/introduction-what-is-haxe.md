## 1.1 What is Haxe?

Haxe is a high-level, open source programming language and compiler. It allows compilation of programs written using an ECMAScript-oriented syntax to multiple target languages. Employing proper abstraction, it is possible to maintain a single code-base which compiles to multiple targets.

Haxe is strongly typed, but the typing system can be subverted where required. Utilizing type information, the Haxe type system can detect errors at compile-time which would only be noticeable at runtime in the target language. Furthermore, type information can be used by the target generators to generate optimized and robust code.

Currently, there are eight supported target languages which allow different use-cases:


Name  | Output type  | Main usages 
 --- | --- | ---
Javascript  | Sourcecode  | Desktop, Mobile, Server 
Neko  | Bytecode  | Desktop, Server 
PHP  | Sourcecode  | Server 
C++  | Sourcecode  | Desktop, Mobile, Server 
Actionscript 3  | Sourcecode  | Browser, Desktop, Mobile 
Flash  | Bytecode  | Browser, Desktop, Mobile 
 Java  | Sourcecode  | Desktop, Server 
C#  | Sourcecode  | Desktop, Mobile, Server 
 

The remainder of section [Introduction](introduction.md) gives a brief overview of what a Haxe program looks like, and how Haxe evolved since its inception in 2005.

[Types](types.md) introduces the seven different kinds of types in Haxe and how they interact with each other. The discussion of types is continued in [Type System](type-system.md), where features like **unification**, **type parameters** and **type inference** are explained.

[Class Fields](class-field.md) is all about the structure of Haxe classes and, among other topics, deals with **properties**, **inline fields** and **generic functions**.

In [Expressions](expression.md) we see how to actually get programs to do something by using **expressions**, plenty of which are used in the Haxe Standard Library described in [Standard Library](std.md).

[Language Features](lf.md) describes some of the Haxe features in detail, such as **pattern matching**, **string interpolation** and **dead code elimination**.

Finally, we will venture to the exciting land of **haxe macros** in [Macros](macro.md) to see how some common tasks can be greatly simplified.

---

Previous section: [Introduction](introduction.md)

Next section: [About this Document](introduction-about-this-document.md)