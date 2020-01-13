<!--label:introduction-->
## Introduction

<!--subtoc-->

<!--label:introduction-what-is-haxe-->
### What is Haxe?

Haxe consists of a high-level, open source programming language and a compiler. It allows compilation of programs, written using an ECMAScript-oriented syntax, to multiple target languages. Employing proper abstraction, it is possible to maintain a single code-base which compiles to multiple targets.

Haxe is strongly typed, but the typing system can be subverted where required. Utilizing type information, the Haxe type system can detect errors at compile-time which would only be noticeable at run-time in the target language. Furthermore, type information can be used by the compiler to generate optimized and robust code.

Currently, there are nine supported target languages which allow for different use-cases:

Name | Output type | Main usages 
 --- | --- | ---
JavaScript | Sourcecode | Browser, Desktop, Mobile, Server 
Neko | Bytecode | Desktop, Server, CLI 
HashLink | Bytecode | Desktop, Mobile, Game consoles 
PHP | Sourcecode | Server 
Python | Sourcecode | Desktop, Server 
Lua | Sourcecode | Desktop, Scripting 
C++ | Sourcecode | Desktop, Mobile, Server, Game consoles 
ActionScript 3 | Sourcecode | Desktop, Mobile 
Flash | Bytecode | Desktop, Mobile 
 Java | Sourcecode | Desktop, Mobile, Server 
C# | Sourcecode | Desktop, Mobile, Server 
 

The remainder of this section gives a brief overview of what a Haxe program looks like and how Haxe has evolved since its inception in 2005.

[Types](types) introduces the seven different kinds of types in Haxe and how they interact with each other. The discussion of types is continued in [Type System](type-system), where features like **unification**, **type parameters** and **type inference** are explained.

[Class Fields](class-field) is all about the structure of Haxe classes and, among other topics, deals with **properties**, **inline fields** and **generic functions**.

In [Expressions](expression) we see how to actually get programs to do something by using **expressions**.

[Language Features](lf) concludes the Haxe language reference by describing some features in detail such as **pattern matching**, **string interpolation** and **dead code elimination**.

We continue with the Haxe compiler reference, which first handles the basics in [Compiler Usage](compiler-usage) before getting into the advanced features in [Compiler Features](cr-features). Finally, we will venture into the exciting land of **Haxe macros** in [Macros](macro) to see how some common tasks can be greatly simplified.

In the following chapter, [Standard Library](std), we explore important types and concepts from the Haxe Standard Library. We then learn about Haxe's package manager in [Haxelib](haxelib).

Haxe abstracts away many target differences, but sometimes it is important to interact with a target directly, which is the subject of [Target Details](target-details).



<!--label:introduction-about-this-document-->
### About this Document

This document is the official manual for Haxe 4. As such, it is not a beginner's tutorial and does not teach programming. However, the topics are roughly designed to be read in order and there are references to topics "previously seen" and topics "yet to come". In some cases, an earlier section makes use of the information of a later section if it simplifies the explanation. These references are linked accordingly and it should generally not be a problem to read ahead on other topics.

We use a lot of Haxe source code to illustrate theoretical matters in a practical way. These code examples are often complete programs that come with a main function and can be compiled as-is. However, sometimes only the most relevant parts are shown.
Source code looks like this:

```haxe
Haxe code here
```
Occasionally, we demonstrate how target code is generated, for which we usually show the JavaScript target.

Furthermore, we define a set of terms in this document. Predominantly, this is done when introducing a new type or when a term is specific to Haxe. To avoid clutter, we do not define every new aspect we introduce, e.g. what a class is. A definition looks like this:

> ##### Define: Definition name
>
> Definition description

In a few places, this document has **trivia**-boxes. These include background information such as why certain decisions were made during Haxe's development or how a particular feature has changed as Haxe has developed. This information is generally not essential reading and can be skipped if desired:

> ##### Trivia: About Trivia
>
> This is trivia.

<!--label:introduction-authors-and-contributions-->
#### Authors and contributions

Most of this document's content was written by Simon Krajewski while working for the Haxe Foundation. We would like to thank these people for their contributions:

* Dan Korostelev: Additional content and editing
* Caleb Harper: Additional content and editing
* Josefiene Pertosa: Editing
* Miha Lunar: Editing
* Nicolas Cannasse: Haxe creator



<!--label:introduction-license-->
#### License

The Haxe Manual by [Haxe Foundation](http://haxe.org/foundation) is licensed under a [Creative Commons Attribution 4.0 International License](http://creativecommons.org/licenses/by/4.0/).

Based on a work at [github.com/HaxeFoundation/HaxeManual](https://github.com/HaxeFoundation/HaxeManual).





<!--label:introduction-hello-world-->
### Hello World

The following program prints "Hello World" after being compiled and run:

[code asset](assets/HelloWorld.hx)

This can be tested by saving the above code to a file named `Main.hx` and invoking the Haxe Compiler like so: `haxe --main Main --interp`. It generates the following output: `Main.hx:3: Hello world`. There are several things to learn from this:

* Haxe programs are saved in files with an extension of `.hx`.
* The Haxe Compiler is a command-line tool which can be invoked with parameters such as `--main Main` and `--interp`.
* Haxe programs have classes (`Main`, upper-case), which have functions (`main`, lower-case). 
* The name of the file containing a Haxe class is the same as the name of the class itself (in this case `Main.hx`). 

##### Related content

* [Beginner tutorials and examples](http://code.haxe.org/category/beginner/) in the Haxe Code Cookbook.



<!--label:introduction-haxe-history-->
### History

The Haxe project was started on 22 October 2005 by French developer **Nicolas Cannasse** as a successor to the popular open-source ActionScript 2 compiler **MTASC** (Motion-Twin Action Script Compiler) and the in-house **MTypes** language, which experimented with the application of type inference to an object-oriented language. Nicolas' long-time passion for programming language design and the rise of new opportunities to mix different technologies as part of his game developer work at **Motion-Twin**, led to the creation of a whole new language.

Being spelled **haXe** back then, its beta version was released in February 2006 with the first supported targets being AVM-bytecode and Nicolas' own **Neko** virtual machine.

Nicolas Cannasse, who remains leader of the Haxe project to this date, continued to develop Haxe with a clear vision, leading to the Haxe 1.0 release in May 2006. This first major release came with support for JavaScript code generation and already had some of the features that define Haxe today, such as type inference and structural sub-typing.

Haxe 1 saw several minor releases over the course of two years, adding the Flash AVM2 target along with the **haxelib**-tool in August 2006 and the ActionScript 3 target in March 2007. During this period there was a strong focus on improving stability, which resulted in several minor bug-fix releases.

Haxe 2.0 was released in July 2008 and included the PHP target, courtesy of **Franco Ponticelli**. A similar effort by **Hugh Sanderson** lead to the addition of the C++ target in July 2009 with the Haxe 2.04 release.

Just as with Haxe 1, what followed were several months of stability releases. In January 2011, Haxe 2.07 was released with the support of **macros**. Around that time, **Bruno Garcia** joined the team as maintainer of the JavaScript target, which saw vast improvements in the subsequent 2.08 and 2.09 releases.

After the release of 2.09, **Simon Krajewski** joined the team and work towards Haxe 3 began. Furthermore, **Cauê Waneck**'s Java and C# targets found their way into the Haxe builds. It was then decided to make one final Haxe 2 release, which happened in July 2012 with the release of Haxe 2.10.

In late 2012, the Haxe 3 switch was flipped and the Haxe Compiler team, now backed by the newly established **Haxe Foundation**, focused on this next major version. Haxe 3 was subsequently released in May 2013.


