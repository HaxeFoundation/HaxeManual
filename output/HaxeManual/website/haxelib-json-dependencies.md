## 11.2.2 Dependencies

As of Haxe 3.1.0, haxelib supports only exact version matching for dependencies. Dependencies are defined as part of the [haxelib.json](haxelib-json.md), with the library name serving as key and the expected version (if required) as value in the format described in [Versioning](haxelib-json-versioning.md).

We have seen an example of this when introducing haxelib.json:

```haxe
"dependencies": {
  "tink_macros": "",
  "nme": "3.5.5"
}
```

This adds two dependencies to the given Haxe library:

1. The library "tink_macros" can be used in any version. Haxelib will then always try to use the latest version.
2. The library "nme" is required in version "3.5.5". Haxelib will make sure that this exact version is used, avoiding potential breaking changes with future versions.

---

Previous section: [Versioning](haxelib-json-versioning.md)

Next section: [extraParams.hxml](haxelib-extraParams.md)