## 11.2 haxelib.json

Each Haxe library requires a `haxelib.json` file in which the following attributes are defined:

* name: The name of the library. It must contain at least 3 characters among the following: `[A-Za-z0-9_-.]`. In particular, no spaces are allowed.
* url: The URL of the library, i.e. where more information can be found.
* license: The license under which the library is released. Can be `GPL`, `LGPL`, `BSD`, `Public` (for Public Domain) or `MIT`.
* tags: An array of tag-strings which are used on the repository website to sort libraries.
* description: The description of what the library is doing.
* version: The version string of the library. This is detailed in [Versioning](haxelib-json-versioning.md).
* classPath: The path string to the source files.
* releasenote: The release notes of the current version.
* contributors: An array of user names which identify contributors to the library. 
* dependencies: An object describing the dependencies of the library. This is detailed in [Dependencies](haxelib-json-dependencies.md).

The following JSON is a simple example of a haxelib.json:

```haxe
{
  "name": "useless_lib",
  "url" : "https://github.com/jasononeil/useless/",
  "license": "MIT",
  "tags": ["cross", "useless"],
  "description": "This library is useless in the same way on every platform.",
  "version": "1.0.0",
  "releasenote": "Initial release, everything is working correctly.",
  "contributors": ["Juraj","Jason","Nicolas"],
  "dependencies": {
    "tink_macro": "",
    "nme": "3.5.5"
  }
}
```

---

Previous section: [Using a Haxe library with the Haxe Compiler](haxelib-using-haxe.md)

Next section: [Versioning](haxelib-json-versioning.md)