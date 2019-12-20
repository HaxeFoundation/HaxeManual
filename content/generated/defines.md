`absolute_path` |  | Print absolute file path in trace output. | all
`advanced-telemetry` |  | Allow the SWF to be measured with Monocle tool. | flash
`annotate_source` |  | Add additional comments to generated source code. | cpp
`as3` |  | Defined when outputting flash9 as3 source code. | all
`check_xml_proxy` |  | Check the used fields of the XML proxy. | all
`core_api` |  | Defined in the core API context. | all
`core_api_serialize` |  | Mark some generated core API classes with the `Serializable` attribute on C#. | cs
`cppia` |  | Generate cpp instruction assembly. | all
`cs_ver` |  | The C# version to target. | cs
`nocppiaast` |  | Use legacy cppia generation. | all
`dce` | &lt;mode: std &#x7C; full &#x7C; no> | Set the dead code elimination mode. (default: std) See [cr-dce](cr-dce). | all
`dce_debug` |  | Show DCE log. See [cr-dce](cr-dce). | all
`debug` |  | Activated when compiling with -debug. | all
`disable_unicode_strings` |  | Disable Unicode support in `String` type. | cpp
`display` |  | Activated during completion. See [cr-completion](cr-completion). | all
`display_stdin` |  | Read the contents of a file specified in `--display` from standard input. | all
`dll_export` |  | GenCPP experimental linking. | cpp
`dll_import` |  | Handle Haxe-generated .NET DLL imports. | cs
`doc_gen` |  | Do not perform any removal/change in order to correctly generate documentation. | all
`dump` | &lt;mode: pretty &#x7C; record &#x7C; position &#x7C; legacy> | Dump typed AST in dump subdirectory using specified mode or non-prettified default. | all
`dump_dependencies` |  | Dump the classes dependencies in a dump subdirectory. | all
`dump_ignore_var_ids` |  | Remove variable IDs from non-pretty dumps (helps with diff). | all
`dynamic_interface_closures` |  | Use slow path for interface closures to save space. | cpp
`erase_generics` |  | Erase generic classes on C#. | cs
`eval_call_stack_depth` | &lt;depth> | Set maximum call stack depth for eval. (default: 1000) | eval
`eval_debugger` |  | Support debugger in macro/interp mode. Allows `host:port` value to open a socket. Implies eval_stack. | eval
`eval_stack` |  | Record stack information in macro/interp mode. | eval
`eval_times` |  | Record per-method execution times in macro/interp mode. Implies eval_stack. | eval
`fast_cast` |  | Enables an experimental casts cleanup on C# and Java. | cs, java
`fdb` |  | Enable full flash debug infos for FDB interactive debugging. | flash
`file_extension` |  | Output filename extension for cpp source code. | cpp
`flash_strict` |  | More strict typing for flash target. | flash
`flash_use_stage` |  | Keep the SWF library initial stage. | flash
`force_lib_check` |  | Force the compiler to check `--net-lib` and `–-java-lib` added classes (internal). | cs, java
`force_native_property` |  | Tag all properties with `:nativeProperty` metadata for 3.1 compatibility. | cpp
`gencommon_debug` |  | GenCommon internal. | cs, java
`haxe3compat` |  | Gives warnings about transition from Haxe 3.x to Haxe 4.0. | all
`haxe_boot` |  | Give the name 'haxe' to the flash boot class instead of a generated name. | flash
`haxe_ver` |  | The current Haxe version value as decimal number. E.g. 3.407 for 3.4.7. | all
`haxe` |  | The current Haxe version value in SemVer format. | all
`hxcpp_api_level` |  | Provided to allow compatibility between hxcpp versions. | cpp
`hxcpp_gc_generational` |  | Experimental Garbage Collector. | cpp
`hxcpp_debugger` |  | Include additional information for hxcpp_debugger. | cpp
`hxcpp_smart_strings` |  | Use wide strings in hxcpp. (Turned on by default unless `-D disable_unicode_strings` is specified.) | cpp
`include_prefix` |  | Prepend path to generated include files. | cpp
`interp` |  | The code is compiled to be run with `--interp`. | all
`java_ver` | &lt;version: 5-7> | Sets the Java version to be targeted. | java
`js_classic` |  | Don't use a function wrapper and strict mode in JS output. | js
`js_es` | &lt;version number> | Generate JS compliant with given ES standard version. (default: 5) See [target-javascript-es6](target-javascript-es6). | js
`js_enums_as_arrays` |  | Generate enum representation as array instead of as object. | js
`js_unflatten` |  | Generate nested objects for packages and types. | js
`js_source_map` |  | Generate JavaScript source map even in non-debug mode. | js
`jvm` |  | Generate jvm directly. | java
`source_map` |  | Generate source map for compiled files. | php
`keep_old_output` |  | Keep old source files in the output directory. | cs, java
`loop_unroll_max_cost` | &lt;cost> | Maximum cost (number of expressions * iterations) before loop unrolling is canceled. (default: 250) | all
`lua_jit` |  | Enable the jit compiler for lua (version 5.2 only). | lua
`lua_vanilla` |  | Generate code lacking compiled extern lib support (e.g. utf8). | lua
`lua_ver` | &lt;version> | The lua version to target. | lua
`macro` |  | Defined when code is compiled in the macro context. See [macro](macro). | all
`macro_times` |  | Display per-macro timing when used with `--times`. | all
`net_ver` | &lt;version: 20-45> | Sets the .NET version to be targeted. | cs
`netcore_ver` | &lt;version: x.x.x> | Sets the .NET core version to be targeted | cs
`net_target` | &lt;name> | Sets the .NET target. `netcore` (.NET core), `xbox`, `micro` (Micro Framework), `compact` (Compact Framework) are some valid values. (default: `net`) | cs
`neko_source` |  | Output neko source instead of bytecode. | neko
`neko_v1` |  | Keep Neko 1.x compatibility. | neko
`network-sandbox` |  | Use local network sandbox instead of local file access one. | flash
`no-compilation` |  | Disable final compilation. | cs, java, cpp, hl
`no_copt` |  | Disable completion optimization (for debug purposes). | all
`no_debug` |  | Remove all debug macros from cpp output. | all
`no-deprecation-warnings` |  | Do not warn if fields annotated with `@:deprecated` are used. | all
`no-flash-override` |  | Change overrides on some basic classes into HX suffixed methods | flash
`no_opt` |  | Disable optimizations. | all
`no_inline` |  | Disable inlining. See [class-field-inline](class-field-inline). | all
`no_root` |  | Generate top-level types into the `haxe.root` namespace. | cs
`no_macro_cache` |  | Disable macro context caching. | all
`no_swf_compress` |  | Disable SWF output compression. | flash
`no_traces` |  | Disable all trace calls. | all
`objc` |  | Sets the hxcpp output to Objective-C++ classes. Must be defined for interop. | cpp
`old-constructor-inline` |  | Use old constructor inlining logic (from Haxe 3.4.2) instead of the reworked version. | all
`old-error-format` |  | Use Haxe 3.x zero-based column error messages instead of new one-based format. | all
`php_prefix` | &lt;dot-separated namespace> | Root namespace for generated php classes. E.g. if compiled with`-D php-prefix=some.sub`, then all classes will be generated in `\some\sub` namespace. | php
`php_lib` | &lt;folder name> | Select the name for the php lib folder. | php
`php_front` | &lt;filename> | Select the name for the php front file. (default: `index.php`) | php
`python_version` | &lt;version> | The python version to target. (default: 3.3) | python
`real_position` |  | Disables Haxe source mapping when targetting C#, removes position comments in Java and Php output. | cs, java, php
`replace_files` |  | GenCommon internal. | cs, java
`scriptable` |  | GenCPP internal. | cpp
`shallow-expose` |  | Expose types to surrounding scope of Haxe generated closure without writing to window object. | js
`source-header` |  | Print value as comment on top of generated files, use '' value to disable. | all
`source-map-content` |  | Include the Haxe sources as part of the JS source map. | js
`static` |  | Defined if the current target is static. | all
`swc` |  | Output a SWC instead of a SWF. | flash
`swf_compress_level` | &lt;level: 1-9> | Set the amount of compression for the SWF output. | flash
`swf_debug_password` | &lt;password> | Set a password for debugging. | flash
`swf_direct_blit` |  | Use hardware acceleration to blit graphics. | flash
`swf_gpu` |  | Use GPU compositing features when drawing graphics. | flash
`swf_metadata` | &lt;file> | Include contents of the given file as metadata in the SWF. | flash
`swf_preloader_frame` |  | Insert empty first frame in SWF. | flash
`swf_protected` |  | Compile Haxe `private` as `protected` in the SWF instead of `public`. | flash
`swf_script_timeout` | &lt;time in seconds> | Maximum ActionScript processing time before script stuck dialog box displays. | flash
`swf_use_doabc` |  | Use `DoAbc` SWF-tag instead of `DoAbcDefine`. | flash
`sys` |  | Defined for all system platforms. | all
`unsafe` |  | Allow unsafe code when targeting C#. | cs
`use_nekoc` |  | Use `nekoc` compiler instead of the internal one. | neko
`utf16` |  | Defined for all platforms that use UTF-16 string encoding with UCS-2 API. | all
`vcproj` |  | GenCPP internal. | cpp
`warn_var_shadowing` |  | Warn about shadowing variable declarations. | all
