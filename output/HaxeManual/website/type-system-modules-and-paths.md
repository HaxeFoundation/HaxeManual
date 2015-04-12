## 3.7 Modules and Paths

> ##### Define: Module
>
> All Haxe code is organized in modules, which are addressed using paths. In essence, each .hx file represents a module which may contain several types. A type may be `private`, in which case only its containing module can access it.

The distinction of a module and its containing type of the same name is blurry by design. In fact, addressing `haxe.ds.StringMap<Int>` can be considered shorthand for `haxe.ds.StringMap.StringMap<Int>`. The latter version consists of four parts:

1. the package `haxe.ds`
2. the module name `StringMap`
3. the type name `StringMap`
4. the type parameter `Int`

If the module and type name are equal, the duplicate can be removed, leading to the `haxe.ds.StringMap<Int>` short version. However, knowing about the extended version helps with understanding how [module sub-types](type-system-module-sub-types.md) are addressed.

Paths can be shortened further by using an [import](type-system-import.md), which typically allows omitting the package part of a path. This may lead to usage of unqualified identifiers, for which understanding the [resolution order](type-system-resolution-order.md) is required.

> ##### Define: Type path
>
> The (dot-)path to a type consists of the package, the module name and the type name. Its general form is `pack1.pack2.packN.ModuleName.TypeName`.

---

Previous section: [Limitations](type-system-inference-limitations.md)

Next section: [Module Sub-Types](type-system-module-sub-types.md)