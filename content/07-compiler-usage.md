<!--label:compiler-usage-->
## Compiler Usage

##### Basic Usage

The Haxe Compiler is typically invoked from command line with several arguments which have to answer two questions:

* What should be compiled?
* What should the output be?

To answer the first question, it is usually sufficient to provide a class path via the `-p <path>` argument, along with the main class to be compiled via the `-m <dot_path>` argument. The Haxe Compiler then resolves the main class file and begins compilation.

The second question usually comes down to providing an argument specifying the desired target. Each Haxe target has a dedicated command line switch, such as `-js <file_name>` for JavaScript and `-php <directory>` for PHP. Depending on the nature of the target, the argument value is either a directory path (for `-as3`, `-php`, `-cpp`, `-cs`, and `-java`) or a file name.

##### Common arguments

**Input:**

* `-cp <path>` Add a class path where `.hx` source files or packages (sub-directories) can be found.
* `-lib <library_name>` Add a [Haxelib](haxelib) library. By default the most recent version in the local Haxelib repository is used. To require a specific library version use `-lib library_name:version`. To require a version from git use `-lib library_name:git:https://github.com/user/project.git#commit` where the optional #commit can be a branch, tag or commit hash.
* `-main <dot_path>` Set the main class.
* `-D <var[=value]>` Define a [conditional compilation flag](lf-condition-compilation).

**Output:**

* `-js <file_name.js>` Generate [JavaScript](target-javascript) source code in specified file.
* `-as3 directory` Generate ActionScript 3 source code in specified directory.
* `-swf <file_name.swf>` Generate the specified file as [Flash](target-flash) `.swf`.
* `-neko <file_name.n>` Generate [Neko](target-neko) binary as specified file.
* `-php <directory>` Generate [PHP](target-php) source code in specified directory. Use `-D php7` for PHP7 source code.
* `-cpp <directory>` Generate [C++](target-cpp) source code in specified directory and compiles it using native C++ compiler.
* `-cs <directory>` Generate [C#](target-cs) source code in specified directory.
* `-java <directory>` Generate [Java](target-java) source code in specified directory and compiles it using the Java Compiler.
* `-python <file_name.py>` Generate [Python](target-python) source code in the specified file.
* `-lua <file_name.lua>` Generate [Lua](target-python) source code in the specified file.
* `-hl <file_name.hl>` Generate [HashLink](target-hl) byte code in specified file.
* `-cppia <file_name.cppia>` Generate the specified script as a [cppia](target-cppia) file.
* `-x <file>` Shortcut for compiling and executing a Neko file.
* `--no-output` Compile but do not generate any file.
* `--interp` Interpret the program using internal macro system.

##### Other global arguments

* `-xml <file>` Generate XML types description. Useful for API documentation generation tools like [Dox](https://github.com/HaxeFoundation/dox).
* `-v` Turn on verbose mode.
* <code>-dce &lt;std&#124;full&#124;no&gt;</code> Set the [Dead Code Elimination](cr-dce) mode (default `std`).
* `-debug` Add debug information to the compiled code.
* `-resource <file>[@name]` Add a named resource file.
* `-prompt` Prompt on error.
* `-cmd <command>` Run the specified shell command after a successful compilation.
* `--no-traces` Don't compile trace calls in the program.
* `--gen-hx-classes` Generate hx headers for all input classes.
* `--display` Display code tips to provide [completion information for IDEs and editors](cr-completion-overview). 
* `--times` Measure compilation times.
* `--no-inline` Disable [inlining](class-field-inline).
* `--no-opt` Disable code optimizations.
* `--remap <package:target>` Remap a package to another one.
* `--macro` Call the given [initialization macro](macro-initialization) before typing anything else.
* `--wait <host:port>` Wait on the given port for commands to run (see [Completion server](cr-completion-server)).
* `--connect <host:port>` Connect on the given port and run commands there (see [Completion server](cr-completion-server)).
* `--cwd <dir>` Set current working directory.

##### Target specific arguments

* `--php-front <filename>` Select the name for the php front file.
* `--php-lib <filename>` Select the name for the php lib folder.
* `--php-prefix <name>` Prefix all classes with given name.
* `-swf-version <version>` Change the SWF version.
* `-swf-header <header>` Define SWF header (width:height:fps:color).
* `-swf-lib <file>` Add the SWF library to the compiled SWF.
* `-swf-lib-extern <file>` Use the SWF library for type checking.
* `--flash-strict` More type strict flash API.
* `-java-lib <file>` Add an external JAR or class directory library.
* `-net-lib <file>[@std]` Add an external .NET DLL file.
* `-net-std <file>` Add a root std .NET DLL search path.
* `-c-arg <arg>` Pass option `arg` to the native Java/C# compiler.

> ##### Trivia: Run commands after compilation
>
> Use `-cmd` to run the specified command after a successful compilation. It can be used to run (testing) tools or to directly run the build, e.g. `-cmd java -jar bin/Main.jar` (for Java), `-cmd node main.js` (for Node.js) or `-cmd neko Main.n` (for Neko) etc.

##### Global compiler configuration macros: 

In order to include single modules, their paths can be listed directly on command line or in hxml: `haxe ... ModuleName pack.ModuleName`. For more specific includes or excludes, use these [initialization macros](macro-initialization):

* `--macro include(pack:String, recursive=true, ?ignore:Array<String>, ?classPaths:Array<String>, strict=false)` Includes all modules in package pack in the compilation. If `recursive` is true, the compiler recursively adds all sub-packages.
* `--macro exclude(pack:String, recursive=true` Exclude a specific class, enum, or all classes and enums in a package from being generated. Excluded types become `extern`. If `recursive` is true, the compiler recursively excludes all sub-packages.
* `--macro excludeFile(fileName:String)` Exclude classes and enums listed from given external file (one per line) from being generated.
* `--macro keep(?path:String, ?paths:Array<String>, recursive=true)` Marks a package, module or sub-type dot path to be kept by DCE. This also extends to the sub-types of resolved modules. If `recursive` is true, the compiler recursively keeps all sub-packages for package paths.
* `--macro includeFile(file:String, position)` Embed a JavaScript file at compile time. `position` can be either "top", "inline" or "closure".

The full documentation of these methods can be found in the [`haxe.macro.Compiler`](http://api.haxe.org/haxe/macro/Compiler.html) API documentation.

##### Help

* `haxe -version` Print the current Haxe compiler version.
* `haxe --help` Display this list of options.
* `haxe --help-defines` Print help for all [compiler specific defines](compiler-usage-flags).
* `haxe --help-metas` Print help for all [compiler metadata](lf-condition-compilation).

##### Related content

* [Compilation tutorials](http://code.haxe.org/category/compilation/) in the Haxe Code Cookbook.

<!--label:compiler-usage-hxml-->
### HXML

[Compiler arguments](compiler-usage) can be stored in a .hxml file and can be executed with `haxe <file.hxml>`.
In hxml it is possible to use newlines and comments which makes it easier to maintain Haxe build configurations.
It is possible to supply more arguments after the hxml file, e.g. `haxe build.hxml -debug`.

**Example:**

This example has a configuration which compiles the class file `website.HomePage.hx` to JavaScript into a file called `bin/homepage.js`, which is located in the `src` class path. And uses full dead code elimination.

```hxml
-cp src
-dce full
-js bin/homepage.js
-main website.HomePage
```

##### Multiple build compilations

Hxml configurations allow multiple compilation using these arguments:

* `--next` Separate several Haxe compilations.
* `--each` Append preceding parameters to all haxe compilations separated by `--next`. This reduces the repeating params.

**Example:**

This example has a configuration which compiles three different classes into their own JavaScript files. Each build uses `src` as class path and uses full dead code elimination.

```hxml
-cp src
-dce full

--each

-js bin/homepage.js
-main website.HomePage

--next  

-js bin/gallery.js
-main website.GalleryPage

--next  

-js bin/contact.js
-main website.ContactPage
```

##### Comments inside hxml

Inside .hxml files use a hash (i.e. `#`) to comment out the rest of the line. 

**Calling build configurations inside HXML:**

It is possible to create a configuration that looks like this:

```hxml
build-server.hxml  
--next  
build-website.hxml  
--next  
build-game.hxml
```



<!--label:compiler-usage-flags-->
### Global Compiler Flags

Starting from Haxe 3.0, you can get the list of supported [compiler flags](lf-condition-compilation) by running `haxe --help-defines`

Flag | Argument | Description | Platforms 
 --- | --- | --- | ---
<!--include:generated/defines.md-->


