## 9.4 Tools

The Haxe Standard Library comes with a set of tool-classes to simplify working with macros. These classes work best as [static extensions](lf-static-extension.md) and can be brought into context either individually or as a whole through `using haxe.macro.Tools`. These classes are:



* `ComplexTypeTools`: Allows printing `ComplexType` instances in a human-readable way. Also allows determining the `Type` corresponding to a `ComplexType`.
* `ExprTools`: Allows printing `Expr` instances in a human-readable way. Also allows iterating and mapping expressions.
* `MacroStringTools`: Offers useful operations on strings and string expressions in macro context.
* `TypeTools`: Allows printing `Type` instances in a human-readable way. Also offers several useful operations on types, such as [unifying](type-system-unification.md) them or getting their corresponding `ComplexType`.



> ##### Trivia: The tinkerbell library and why Tools.hx works
>
> We learned about static extensions that using a **module** implies that all its types are brought into static extension context. As it turns out, such a type can also be a [typedef](type-system-typedef.md) to another type. The compiler then considers this type part of the module, and extends static extension accordingly.
> 
> This "trick" was first used in Juraj Kirchheim's **tinkerbell** library for exactly the same purpose. Tinkerbell provided many useful macro tools long before they made it into the Haxe Compiler and Haxe Standard Library. It remains the primary library for additional macro tools and offers other useful functionality as well.

---

Previous section: [Class Reification](macro-reification-class.md)

Next section: [Type Building](macro-type-building.md)