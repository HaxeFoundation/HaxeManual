## 7 Compiler Usage

###### Basic Usage

The Haxe Compiler is typically invoked from command line with several arguments which have to answer two questions:

* What should be compiled?
* What should the output be?

To answer the first question, it is usually sufficient to provide a class path via the `-cp path` argument, along with the main class to be compiled via the `-main dot_path` argument. The Haxe Compiler then resolves the main class file and begins compilation.

The second question usually comes down to providing an argument specifying the desired target. Each Haxe target has a dedicated command line switch, such as `-js file_name` for JavaScript and `-php directory` for PHP. Depending on the nature of the target, the argument value is either a file name (for `-js`, `-swf` and `neko`) or a directory path.

###### Common arguments

**Input:**

* `-cp path` Adds a class path where `.hx` source files or packages (sub-directories) can be found.
* `-lib library_name` Adds a [Haxelib](haxelib.md) library.
* `-main dot_path` Sets the main class.

**Output:**

* `-js file_name` Generates [JavaScript](target-javascript.md) source code in specified file.
* `-as3 directory` Generates ActionScript 3 source code in specified directory.
* `-swf file_name` Generates the specified file as [Flash](target-flash.md) .swf.
* `-neko file_name` Generates [Neko](#) binary as specified file.
* `-php directory` Generates [PHP](target-php.md) source code in specified directory.
* `-cpp directory` Generates [C++](target-cpp.md) source code in specified directory and compiles it using native C++ compiler.
* `-cs directory` Generates [C#](#) source code in specified directory.
* `-java directory` Generates [Java](#) source code in specified directory and compiles it using the Java Compiler.
* `-python file_name` Generates [Python](target-python.md) source code in the specified file.

---

Previous section: [Inline constructors](lf-inline-constructor.md)

Next section: [Compiler Features](cr-features.md)