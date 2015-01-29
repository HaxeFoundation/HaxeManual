## 6.1.1 Global Compiler Flags

Starting from Haxe 3.0, you can get the list of supported [compiler flags](lf-condition-compilation.md) by running `haxe --help-defines`

##### Global Compiler Flags
 
 Flag  |  Description 
 --- | ---
<code>absolute-path</code>  |  Print absolute file path in trace output 
<code>advanced-telemetry</code>   |  Allow the SWF to be measured with Monocle tool 
<code>as3</code>  |  Defined when outputing flash9 as3 source code 
<code>check-xml-proxy</code>   |  Check the used fields of the xml proxy 
<code>core-api</code>   |  Defined in the core api context 
<code>cppia</code>   |  Generate experimental cpp instruction assembly 
<code>dce</code>   |  The current [Dead Code Elimination](cr-dce.md) mode 
<code>dce-debug</code>   |  Show [Dead Code Elimination](cr-dce.md) log 
<code>debug</code>   |  Activated when compiling with <code>-debug</code> 
<code>display</code>   |  Activated during completion 
<code>dll-export</code>   |  GenCPP experimental linking 
<code>dll-import</code>   |  GenCPP experimental linking 
<code>doc-gen</code>   |  Do not perform any removal/change in order to correctly generate documentation 
<code>dump</code>   |  Dump the complete typed AST for internal debugging 
<code>dump-dependencies</code>   |  Dump the classes dependencies 
<code>fdb</code>   |  Enable full flash debug infos for FDB interactive debugging 
<code>flash-strict</code>   |  More strict typing for flash target 
<code>flash-use-stage</code>   |  Keep the SWF library initial stage 
<code>format-warning</code>   |  Print a warning for each formated string. for 2.x compatibility 
<code>gencommon-debug</code>   |  GenCommon internal 
<code>haxe-boot</code>   |  Given the name 'haxe' to the flash boot class instead of a generated name 
<code>haxe-ver</code>   |  The current Haxe version value 
<code>hxcpp-api-level</code>   |  Provided to allow compatibility between hxcpp versions 
<code>include-prefix</code>   |  prepend path to generated include files 
<code>interp</code>   |  The code is compiled to be run with <code>--interp</code> 
<code>java-ver=[version:5-7]</code>   | Sets the Java version to be targeted 
<code>js-classic</code>   |  Don't use a function wrapper and strict mode in JS output 
<code>js-es5</code>   |  Generate JS for ES5-compliant runtimes 
<code>js-flatten</code>   |  Generate classes to use fewer object property lookups 
<code>macro</code>  | Defined when we compile code in the [macro context](macro.md) 
<code>macro-times</code>  | Display per-macro timing when used with <code>--times</code> 
<code>neko-source</code>  | Output neko source instead of bytecode 
<code>neko-v1</code>  |  Keep Neko 1.x compatibility 
<code>net-target=&lt;name&gt;</code>   |  Sets the .NET target. Defaults to net. xbox, micro _(Micro Framework_, compact _(Compact Framework)_ are some valid values  
<code>net-ver=&lt;version:20-45&gt;</code>   |  Sets the .NET version to be targeted 
<code>network-sandbox</code>   |  Use local network sandbox instead of local file access one 
<code>no-compilation</code>   |  Disable CPP final compilation 
<code>no-copt</code>   |  Disable completion optimization _(for debug purposes)_ 
<code>no-debug</code>   |  Remove all debug macros from cpp output 
<code>no-deprecation-warnings</code>  | Do not warn if fields annotated with <code>@:deprecated</code> are used 
<code>no-flash-override</code>   |  Change overrides on some basic classes into HX suffixed methods flash only 
<code>no-inline</code>   |  Disable [inlining](class-field-inline.md) 
<code>no-macro-cache</code>   |  Disable macro context caching 
<code>no-opt</code>   |  Disable optimizations 
<code>no-pattern-matching</code>   |  Disable [pattern matching](lf-pattern-matching.md) 
<code>no-root</code>   |  GenCS internal 
<code>no-swf-compress</code>   |  Disable SWF output compression 
<code>no-traces</code>   |  Disable all <code>trace</code> calls 
<code>php-prefix</code>   |  Compiled with <code>--php-prefix</code> 
<code>real-position</code>   |  Disables haxe source mapping when targetting C# 
<code>replace-files</code>   |  GenCommon internal 
<code>scriptable</code>   |  GenCPP internal 
<code>shallow-expose</code>   |  Expose types to surrounding scope of Haxe generated closure without writing to window object 
<code>source-map-content</code>   |  Include the hx sources as part of the JS source map 
<code>swc</code>   |  Output a SWC instead of a SWF 
<code>swf-compress-level=&lt;level:1-9&gt;</code>   |  Set the amount of compression for the SWF output 
<code>swf-debug-password=&lt;yourPassword&gt;</code>   |  Set a password for debugging. The password field is encrypted by using the MD5 algorithm and prevents unauthorised debugging of your swf. Without this flag -D fdb will use no password. 
<code>swf-direct-blit</code>   |  Use hardware acceleration to blit graphics 
<code>swf-gpu</code>   |  Use GPU compositing features when drawing graphics 
<code>swf-mark</code>   |  GenSWF8 internal 
<code>swf-metadata=&lt;file.xml&gt;</code>   |  Include contents of <code>&lt;file.xml&gt;</code> as metadata in the swf. 
<code>swf-preloader-frame</code>   |  Insert empty first frame in swf. To be used together with <code>-D flash-use-stage</code> and <code>-swf-lib</code> 
<code>swf-protected</code>   |  Compile Haxe private as protected in the SWF instead of public 
<code>swf-script-timeout</code>   |  Maximum ActionScript processing time before script stuck dialog box displays (in seconds) 
<code>swf-use-doabc</code>   |  Use DoAbc swf-tag instead of DoAbcDefine 
<code>sys</code>   |  Defined for all system platforms 
<code>unsafe</code>   |  Allow unsafe code when targeting C# 
<code>use-nekoc</code>   |  Use nekoc compiler instead of internal one 
<code>use-rtti-doc</code>   |  Allows access to documentation during compilation 
<code>vcproj</code>   |  GenCPP internal

---

Previous section: [Conditional Compilation](lf-condition-compilation.md)

Next section: [Externs](lf-externs.md)