## 12.1.5 Debugging JavaScript

Haxe is able to generate [source maps](http://www.html5rocks.com/en/tutorials/developertools/sourcemaps/), allowing Javascript debuggers to map from generated JavaScript back to the original Haxe source. This makes reading error stack traces, debugging with breakpoints, and profiling much easier.

Compiling with the `-debug` flag will create a .map alongside the .js file. Enable it in Chrome by clicking on the cog settings button in the bottom right of the Developer Tools window, and checking "Enable source maps". The pause button on the bottom left can be toggled to pause on uncaught exceptions.

---

Previous section: [JavaScript untyped functions](target-javascript-untyped.md)

Next section: [JavaScript target Metadata](target-javascript-metadata.md)