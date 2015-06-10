## 8.3.1 Overview

The rich [type system](type-system.md) of the Haxe Compiler makes it difficult for IDEs and editors to provide accurate completion information. Between [type inference](type-system-type-inference.md) and [macros](macro.md), it would require a substantial amount of work to replicate the required processing. This is why the Haxe Compiler comes with a built-in completion mode for third-party software to use.

All completion is triggered using the `--display file@position[@mode]` compiler argument. The required arguments are:

* file: The file to check for completion. This must be an absolute or relative path to a .hx file. It does not respect any class paths or libraries.
* position: The byte position (not character position) of where to check for completion in the given file.
* mode: The completion mode to use (see below).

We will look into the following completion modes in detail:

* [Field access](cr-completion-field-access.md): Provides a list of fields that can be accessed on a given type.
* [Call argument](cr-completion-call-argument.md): Reports the type of the function which is currently being called.
* [Type path](cr-completion-type-path.md): Lists sub-packages, sub-types and static fields.
* [Usage](cr-completion-usage.md): Lists all occurrences of a given type, field or variable in all compiled files. (mode: `"usage"`)
* [Position](cr-completion-position.md): Reports the position of where a given type, field or variable is defined. (mode: `"position"`)
* [Top-level](cr-completion-top-level.md): Lists all identifiers which are available at a given position. (mode: `"toplevel"`)

Due to Haxe being a very fast compiler, it is often sufficient to rely on the normal compiler invocation for completion. For bigger projects Haxe provides a [server mode](cr-completion-server.md) which ensures that only those files are re-compiled that actually changed or had any of their dependencies changes.

###### General notes on the interface

* The position-argument can be set to 0 if the file in question contains a pipeline `|` character at the position of interest. This is very useful for demonstration and testing as it allows us to ignore the byte-counting process a real IDE would have to do. The examples in this section are making use of this feature. Note that this only works in places where `|` is not valid syntax otherwise, e.g. after dots (`.|`) and opening parentheses (`(|`).
* The output is HTML-escaped so that `&`, `<` and `>` become `&amp;`, `&lt;` and `&gt;` respectively.
* Otherwise any documentation output is preserved which means longer documentation might include new-line and tab-characters as it does in the source files.
* When run in completion mode, the compiler does not display errors but instead tries to ignore them or recover from them.  If a critical error occurs while getting completion, the Haxe Compiler prints the error message instead of the completion output. Any non-XML output can be treated as a critical error message.

---

Previous section: [Completion](cr-completion.md)

Next section: [Field access completion](cr-completion-field-access.md)