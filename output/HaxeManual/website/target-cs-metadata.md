## 12.8.4 Haxe/C# Metadata

This is the list of C# specific metadata. For more information, see also the complete list of all [Haxe built-in metadata](cr-metadata.md).

##### JavaScript metadata
 
 Metadata  | Usage  | Description 
 --- | --- | ---
@:nativeGen   |  on classes  | don't generate reflection, generate proper type parameters. This is useful for some sort of interop, but slows down reflection and structural typing 
@:nativeGen   |  on "flat" enums  | generate C# enum, but note that C# enums are not-nullable unlike haxe enums, so using null will be generated as a default enum value (0-indexed constructor). 
@:property   |  on non-physical fields (those with get/set/never accessors)  | generate native C# properties. useful for implementing extern interfaces or providing API for use from C# 
@:event   |  on variables  | generate an event delegate (this also requires pairing add_EventName, remove_EventName methods with relevant signatures 
@:protected   |  on a field  | mark field as protected instead of public (could affect reflection, but useful for hiding fields when providing API for use from outside Haxe) 
@:struct   |  on classes   |  generate struct instead of class

---

Previous section: [Haxe/C# Defines](target-cs-defines.md)

Next section: [Injecting raw C# code](target-cs-code-injection.md)