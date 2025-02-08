`absolute-path` |  | Print absolute file path in trace output. | all
`advanced-telemetry` |  | Allow the SWF to be measured with Monocle tool. | flash
`analyzer-optimize` |  | Perform advanced optimizations. | all
`analyzer-times` | &lt;level: 0 &#x7C; 1 &#x7C; 2> | Record detailed timers for the analyzer | all
`annotate-source` |  | Add additional comments to generated source code. | cpp
`check-xml-proxy` |  | Check the used fields of the XML proxy. | all
`core-api` |  | Defined in the core API context. | all
`core-api-serialize` |  | Mark some generated core API classes with the `Serializable` attribute on C#. | cs
`cppia` |  | Generate cpp instruction assembly. | all
`cs-ver` | &lt;version> | The C# version to target. | cs
`nocppiaast` |  | Use legacy cppia generation. | all
`dce` | &lt;mode: std &#x7C; full &#x7C; no> | Set the dead code elimination mode. (default: std) See [cr-dce](cr-dce). | all
`dce-debug` |  | Show DCE log. See [cr-dce](cr-dce). | all
`debug` |  | Activated when compiling with -debug. | all
`disable-unicode-strings` |  | Disable Unicode support in `String` type. | cpp
`display` |  | Activated during completion. See [cr-completion](cr-completion). | all
`display-stdin` |  | Read the contents of a file specified in `--display` from standard input. | all
`dll-export` |  | GenCPP experimental linking. | cpp
`dll-import` |  | Handle Haxe-generated .NET DLL imports. | cs
`doc-gen` |  | Do not perform any removal/change in order to correctly generate documentation. | all
`dump` | &lt;mode: pretty &#x7C; record &#x7C; position &#x7C; legacy> | Dump typed AST in dump subdirectory using specified mode or non-prettified default. | all
`dump-path` | &lt;path> | Path to generate dumps to (default: "dump"). | all
`dump-dependencies` |  | Dump the classes dependencies in a dump subdirectory. | all
`dump-ignore-var-ids` |  | Remove variable IDs from non-pretty dumps (helps with diff). | all
`dynamic-interface-closures` |  | Use slow path for interface closures to save space. | cpp
`erase-generics` |  | Erase generic classes on C#. | cs
`eval-call-stack-depth` | &lt;depth> | Set maximum call stack depth for eval. (default: 1000) | eval
`eval-debugger` |  | Support debugger in macro/interp mode. Allows `host:port` value to open a socket. Implies eval-stack. | eval
`eval-print-depth` | &lt;depth> | Set maximum print depth (before replacing with '<...>') for eval. (default: 5) | eval
`eval-pretty-print` |  | Enable indented output for eval printing. | eval
`eval-stack` |  | Record stack information in macro/interp mode. | eval
`eval-times` |  | Record per-method execution times in macro/interp mode. Implies eval-stack. | eval
`filter-times` |  | Record per-filter execution times upon --times. | all
`fast-cast` |  | Enables an experimental casts cleanup on C# and Java. | cs, java
`fdb` |  | Enable full flash debug infos for FDB interactive debugging. | flash
`file-extension` |  | Output filename extension for cpp source code. | cpp
`flash-strict` |  | More strict typing for flash target. | flash
`flash-use-stage` |  | Keep the SWF library initial stage. | flash
`force-lib-check` |  | Force the compiler to check `--net-lib` and `--java-lib` added classes (internal). | cs, java
`force-native-property` |  | Tag all properties with `:nativeProperty` metadata for 3.1 compatibility. | cpp
`gencommon-debug` |  | GenCommon internal. | cs, java
`haxe3compat` |  | Gives warnings about transition from Haxe 3.x to Haxe 4.0. | all
`haxe-boot` |  | Give the name 'haxe' to the flash boot class instead of a generated name. | flash
`haxe-ver` |  | The current Haxe version value as decimal number. E.g. 3.407 for 3.4.7. | all
`haxe` |  | The current Haxe version value in SemVer format. | all
`haxe-next` |  | Enable experimental features that are meant to be released on next Haxe version. | all
`HAXE_OUTPUT_FILE` | &lt;name> | Force the full output name of the executable/library without library prefix and debug suffix. | cpp
`HAXE_OUTPUT_PART` | &lt;name> | Output name of the executable/library. (default: main class name) | cpp
`hl-ver` | &lt;version> | The HashLink version to target. (default: 1.10.0) | hl
`hxcpp-api-level` |  | Provided to allow compatibility between hxcpp versions. | cpp
`HXCPP-GC-GENERATIONAL` |  | Experimental Garbage Collector. | cpp
`HXCPP-DEBUGGER` |  | Include additional information for hxcpp-debugger. | cpp
`hxcpp-smart-strings` |  | Use wide strings in hxcpp. (Turned on by default unless `-D disable-unicode-strings` is specified.) | cpp
`include-prefix` |  | Prepend path to generated include files. | cpp
`interp` |  | The code is compiled to be run with `--interp`. | all
`jar-legacy-loader` |  | Use the legacy loader to load .jar files on the JVM target. | java
`java-ver` | &lt;version: 5-7> | Sets the Java version to be targeted. | java
`js-classic` |  | Don't use a function wrapper and strict mode in JS output. | js
`js-es` | &lt;version: 3 &#x7C; 5 &#x7C; 6> | Generate JS compliant with given ES standard version. (default: 5) See [target-javascript-es6](target-javascript-es6). | js
`js-enums-as-arrays` |  | Generate enum representation as array instead of as object. | js
`js_global` |  | Customizes the global object name. | js
`js-unflatten` |  | Generate nested objects for packages and types. | js
`js-source-map` |  | Generate JavaScript source map even in non-debug mode. Deprecated in favor of `-D source-map`. | js
`source-map` |  | Generate source map for compiled files. | php, js
`jvm` |  | Generate jvm directly. | java
`jvm.compression-level` |  | Set the compression level of the generated file between 0 (no compression) and 9 (highest compression). Default: 6 | java
`jvm.dynamic-level` |  | Controls the amount of dynamic support code being generated. 0 = none, 1 = field read/write optimization (default), 2 = compile-time method closures | java
`keep-old-output` |  | Keep old source files in the output directory. | cs, java
`loop-unroll-max-cost` | &lt;cost> | Maximum cost (number of expressions * iterations) before loop unrolling is canceled. (default: 250) | all
`lua-jit` |  | Enable the jit compiler for lua (version 5.2 only). | lua
`lua-vanilla` |  | Generate code lacking compiled extern lib support (e.g. utf8). | lua
`lua-ver` | &lt;version> | The lua version to target. | lua
`macro` |  | Defined when code is compiled in the macro context. See [macro](macro). | all
`macro-times` |  | Display per-macro timing when used with `--times`. | all
`net-ver` | &lt;version: 20-50> | Sets the .NET version to be targeted. | cs
`netcore-ver` | &lt;version: x.x.x> | Sets the .NET core version to be targeted | cs
`net-target` | &lt;name> | Sets the .NET target. `netcore` (.NET core), `xbox`, `micro` (Micro Framework), `compact` (Compact Framework) are some valid values. (default: `net`) | cs
`neko-source` |  | Output neko source instead of bytecode. | neko
`neko-no-haxelib-paths` |  | Disable hard-coded Haxelib ndll paths. | neko
`neko-v1` |  | Keep Neko 1.x compatibility. | neko
`network-sandbox` |  | Use local network sandbox instead of local file access one. | flash
`no-compilation` |  | Disable final compilation. | cs, java, cpp, hl
`no-debug` |  | Remove all debug macros from cpp output. | all
`no-deprecation-warnings` |  | Do not warn if fields annotated with `@:deprecated` are used. | all
`no-flash-override` |  | Change overrides on some basic classes into HX suffixed methods | flash
`no-opt` |  | Disable optimizations. | all
`no-inline` |  | Disable inlining. See [class-field-inline](class-field-inline). | all
`keep-inline-positions` |  | Don't substitute positions of inlined expressions with the position of the place of inlining. See [class-field-inline](class-field-inline). | all
`no-root` |  | Generate top-level types into the `haxe.root` namespace. | cs
`no-macro-cache` |  | Disable macro context caching. | all
`no-swf-compress` |  | Disable SWF output compression. | flash
`no-traces` |  | Disable all trace calls. | all
`objc` |  | Sets the hxcpp output to Objective-C++ classes. Must be defined for interop. | cpp
`old-error-format` |  | Use Haxe 3.x zero-based column error messages instead of new one-based format. | all
`php-prefix` | &lt;dot-separated namespace> | Root namespace for generated php classes. E.g. if compiled with`-D php-prefix=some.sub`, then all classes will be generated in `\some\sub` namespace. | php
`php-lib` | &lt;folder name> | Select the name for the php lib folder. | php
`php-front` | &lt;filename> | Select the name for the php front file. (default: `index.php`) | php
`python-version` | &lt;version> | The python version to target. (default: 3.3) | python
`real-position` |  | Disables Haxe source mapping when targeting C#, removes position comments in Java and Php output. | cs, java, php
`replace-files` |  | GenCommon internal. | cs, java
`retain-untyped-meta` |  | Prevents arbitrary expression metadata from being discarded upon typing. | all
`scriptable` |  | GenCPP internal. | cpp
`shallow-expose` |  | Expose types to surrounding scope of Haxe generated closure without writing to window object. | js
`source-header` |  | Print value as comment on top of generated files, use '' value to disable. | all
`source-map-content` |  | Include the Haxe sources as part of the JS source map. | js
`static` |  | Defined if the current target is static. | all
`std-encoding-utf8` |  | Force utf8 encoding for stdin, stdout and stderr | java, cs, python
`swc` |  | Output a SWC instead of a SWF. | flash
`swf-compress-level` | &lt;level: 1-9> | Set the amount of compression for the SWF output. | flash
`swf-debug-password` | &lt;password> | Set a password for debugging. | flash
`swf-direct-blit` |  | Use hardware acceleration to blit graphics. | flash
`swf-gpu` |  | Use GPU compositing features when drawing graphics. | flash
`swf-header` |  | define SWF header (width:height:fps:color) | flash
`swf-metadata` | &lt;file> | Include contents of the given file as metadata in the SWF. | flash
`swf-preloader-frame` |  | Insert empty first frame in SWF. | flash
`swf-protected` |  | Compile Haxe `private` as `protected` in the SWF instead of `public`. | flash
`swf-script-timeout` | &lt;time in seconds> | Maximum ActionScript processing time before script stuck dialog box displays. | flash
`swf-use-doabc` |  | Use `DoAbc` SWF-tag instead of `DoAbcDefine`. | flash
`sys` |  | Defined for all system platforms. | all
`unsafe` |  | Allow unsafe code when targeting C#. | cs
`use-nekoc` |  | Use `nekoc` compiler instead of the internal one. | neko
`utf16` |  | Defined for all platforms that use UTF-16 string encoding with UCS-2 API. | all
`vcproj` |  | GenCPP internal. | cpp
`warn-var-shadowing` |  | Warn about shadowing variable declarations. | all
`no-tre` |  | Disable tail recursion elimination. | all
`message.reporting` | &lt;mode: classic &#x7C; pretty &#x7C; indent> | Select message reporting mode for compiler output. (default: classic) | all
`message.no-color` |  | Disable ANSI color codes in message reporting. | all
`message.log-file` |  | Path to a text file to write message reporting to, in addition to regular output. | all
`message.log-format` | &lt;format: classic &#x7C; pretty &#x7C; indent> | Select message reporting mode for message log file. (default: indent) | all
