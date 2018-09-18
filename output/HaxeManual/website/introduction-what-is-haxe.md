## 1.1 What is Haxe?

Haxe consists of a high-level, open source programming language and a compiler. It allows compilation of programs, written using an ECMAScript-oriented syntax, to multiple target languages. Employing proper abstraction, it is possible to maintain a single code-base which compiles to multiple targets.

Haxe is strongly typed but the typing system can be subverted where required. Utilizing type information, the Haxe type system can detect errors at compile-time which would only be noticeable at run-time in the target language. Furthermore, type information can be used by the target generators to generate optimized and robust code.

Currently, there are nine supported target languages which allow for different use-cases:

Name  | Output type  | Main usages 
 --- | --- | ---
JavaScript  | Sourcecode  | Browser, Desktop, Mobile, Server 
Neko  | Bytecode  | Desktop, Server, CLI 
HashLink  | Bytecode  | Desktop, Mobile, Game consoles 
PHP  | Sourcecode  | Server 
Python  | Sourcecode  | Desktop, Server 
Lua  | Sourcecode  | Desktop, Scripting 
C++  | Sourcecode  | Desktop, Mobile, Server, Game consoles 
ActionScript 3  | Sourcecode  | Desktop, Mobile 
Flash  | Bytecode  | Desktop, Mobile 
 Java  | Sourcecode  | Desktop, Mobile, Server 
C#  | Sourcecode  | Desktop, Mobile, Server 
 

The remainder of section [Introduction](introduction.md) gives a brief overview of what a Haxe program looks like and how Haxe evolved since its inception in 2005.

[Types](types.md) introduces the seven different kinds of types in Haxe and how they interact with each other. The discussion of types is continued in [Type System](type-system.md), where features like **unification**, **type parameters** and **type inference** are explained.

[Class Fields](class-field.md) is all about the structure of Haxe classes and, among other topics, deals with **properties**, **inline fields** and **generic functions**.

In [Expressions](expression.md) we see how to actually get programs to do something by using **expressions**.

[Language Features](lf.md) describes some of the Haxe features in detail such as **pattern matching**, **string interpolation** and **dead code elimination**. This concludes the Haxe language reference.

We continue with the Haxe compiler reference, which first handles the basics in [Compiler Usage](compiler-usage.md) before getting into the advanced features in [Compiler Features](cr-features.md). Finally, we will venture into the exciting land of **haxe macros** in [Macros](macro.md) to see how some common tasks can be greatly simplified.

In the following chapter, [Standard Library](std.md), we explore important types and concepts from the Haxe Standard Library. We then learn about Haxe's package manager Haxelib in [Haxelib](haxelib.md).

Haxe abstracts away many target differences, but sometimes it is important to interact with a target directly, which is the subject of [Target Details](target-details.md).

---

Previous section: [Introduction](introduction.md)

Next section: [About this Document](introduction-about-this-document.md)