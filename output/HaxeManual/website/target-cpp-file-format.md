## 12.5.3 build.xml File Format

The build.xml file format is designed to address the very specific goal of generating compiled output as fast as possible on a wide variety of compilers.  Therefore, at its core, it is simply a list of files to compile, and their dependencies, and a list of compiler exes and flags required to get the job done.  Conditional variable setting is added to support the great variety of compilers and use cases encountered by hxcpp.  However, much of the logic required to orchestrate the compiler sequences, such as precompiling headers, is defined in haxe and implemented in the build tool itself, rather than being scriptable.

A hxcpp build file consists of a series of commands and data structures in xml format.  The commands are executed immediately as they are encountered, while the data structures are accumulated and used after all the build files have been parsed.

##### Running a build.xml File With Hxcpp
When you compile a haxe program with hxcpp, the haxe compiler will normally run the hxcpp build tool on the generated build.xml file automatically.  You can, however, prevent this by adding `-D no-compilation` to the haxe command line.

You can run the hxcpp build tool on your own build files using

`haxelib run hxcpp myfile.xml [-Ddefine] [-Dkey=value]`

Note the lack of space between the "-D" and the variable name.

A minimal build.xml file consists of an xml container and a dummy default target, like:
```haxe
<xml>
   <echo value="Hello!" />
   <target id="default" />
</xml>
```

##### Conditions, Substitutions and Sections
Most elements in the hxcpp xml file allow a common syntax for dynamic configuration.

Xml elements can contain conditional "if" and/or "unless" values.  These conditions are evaluated at parse time and the entire element will be skipped if the condition fails.  For example adding this lines:
```haxe
<xml>
  <echo value="Hello A" if="A" />
  <echo value="Hello A && B" if="A B" />
  <echo value="Hello A || B" if="A || B" />
  <echo value="Hello !A" unless="A" />
  <echo value="Hello !(A && B)" unless="A B" />
  <echo value="Hello !(A || B)" unless="A || B" />
  <echo value="Never Never" if="A" unless="A" />
  <target id="default" />
</xml>
```

and running:

`haxelib run hxcpp myfile.xml -DA`

shows how the logic depends on whether or not A or B has been defined.

Sections can be used to group commands together based on a common condition.  They can also be used to include only part of another xml file, but this technique is currently only used when parsing the .hxcpp_config.xml file.  For example:

```haxe
  <section if="C" >
    <echo value="I See" />
    <echo value="You" />
  </section>
```

The xml attribute values can be substituted with variable values using dollars-brace syntax.  Using a colon allows a function-call to be substituted, e.g.:

```haxe
  <echo value="some var = ${SOME_VAR}" />
  <echo value="${haxelib:hxcpp}/include" />
```

---

Previous section: [The Hxcpp Build Environment](target-cpp-build-environment.md)

Next section: [Using C++ Defines](target-cpp-defines.md)