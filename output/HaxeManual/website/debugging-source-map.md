## 13.5 Source Maps

Haxe is able to generate source maps, allowing debuggers to map from generated source back to the original Haxe source. This makes reading error stack traces, debugging with breakpoints, and profiling much easier.

When an error occurs, the developer is helped out by showing them where the error occurred in the original Haxe source file. This saves the developer time every single time they hit an error. The web console log messages also include links to the line that generated the log message, so these messages could link back to the original source lines as well. 

Compiling with the `-debug` flag will create a source map (.map) alongside the .js file. Source maps can also be generated for release builds with `-D js-source-map`.

---

Previous section: [Debugging in JavaScript](debugging-javascript.md)

Next section: [Source Maps in JavaScript](debugging-source-map-javascript.md)