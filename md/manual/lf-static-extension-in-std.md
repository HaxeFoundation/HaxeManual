## 6.2.1 In the Haxe Standard Library

Several classes in the Haxe Standard Library are suitable for static extension usage. The next example shows the usage of `StringTools`:

```haxe
using StringTools;

class Main {
	static public function main() {
		"adc".replace("d", "b");
	}
}
```

While `String` does not have a `replace` functionality by itself, the `using StringTools` static extension provides one. As usual, the Javascript output nicely shows the transformation:

```haxe
Main.main = function() {
	StringTools.replace("adc","d","b");
}
```

The following classes from the Haxe Standard Library are designed to be used as static extensions:



* `StringTools`: Provides extended functionality on strings, such as replacing or trimming.
* `Lambda`: Provides functional methods on iterables.
* `haxe.EnumTools`: Provides type information functionality on enums and their instances.
* `haxe.macro.Tools`: Provides different extensions for working with macros (see [Tools](macro-tools.md)).





> ##### Trivia: "using" using
>
> Since the `using` keyword was added to the language, it has been common to talk about certain problems with "using using" or the effect of "using using". This makes for awkward English in many cases, so the author of this manual decided to call the feature by what it actually is: Static extension.

---

Previous section: [Static Extension](lf-static-extension.md)

Next section: [Pattern Matching](lf-pattern-matching.md)