## 10.8.3 Implementation details

`haxe.Json` API automatically uses native implementation on targets where it is available, i.e. **JavaScript**, **Flash** and **PHP** and provides its own implementation for other targets.

Usage of Haxe own implementation can be forced with `-D haxeJSON` compiler argument. This will also provide serialization of [enums](types-enum-instance.md) by their index, [maps](std-Map.md) with string keys and class instances.

Older browsers (Internet Explorer 7, for instance) may not have native **JSON** implementation. In case it's required to support them, we can include in the HTML page one of the JSON implementations available on the internet or use `-D old_browser` compiler argument that will make `haxe.Json` try to use native JSON and fallback to its own implementation in case it's not available.

---

Previous section: [Encoding JSON](std-Json-encoding.md)

Next section: [Haxelib](haxelib.md)