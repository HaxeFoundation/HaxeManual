## 9.1 Macro Context

> ##### Define: Macro Context
>
> The macro context is the environment in which the macro is executed. Depending on the macro type, it can be considered to be a class being built or a function being typed. Contextual information can be obtained through the `haxe.macro.Context` API.

Haxe macros have access to different contextual information depending on the macro type. Other than querying such information, the context also allows some modifications such as defining a new type or registering certain callbacks. It is important to understand that not all information is available for all macro kinds, as the following examples demonstrate:

* Initialization macros will find that the `Context.getLocal*()` methods return `null`. There is no local type or method in the context of an initialization macro.
* Only build macros get a proper return value from `Context.getBuildFields()`. There are no fields being built for the other macro kinds.
* Build macros have a local type (if incomplete), but no local method, so `Context.getLocalMethod()` returns `null`.

The context API is complemented by the `haxe.macro.Compiler` API detailed in [Initialization macros](macro-initialization.md). While this API is available to all macro kinds, care has to be taken for any modification outside of initialization macros. This stems from the natural limitation of undefined [build order](macro-limitations-build-order.md), which could cause e.g. a flag definition through `Compiler.define()` to take effect before or after a [conditional compilation](lf-condition-compilation.md) check against that flag.

##### Related content

* See the [macro Context API documentation](http://api.haxe.org/haxe/macro/Context.html). 
* See the [macro snippets and tutorials](http://code.haxe.org/category/macros/) section in the Haxe Code Cookbook.

---

Previous section: [Macros](macro.md)

Next section: [Arguments](macro-arguments.md)