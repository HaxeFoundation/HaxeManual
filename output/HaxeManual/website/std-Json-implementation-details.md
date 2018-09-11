## 10.10.3 Implementation details

The [haxe.Json](http://api.haxe.org/haxe/Json.html) API automatically uses native implementation on targets where it is available, i.e. **JavaScript**, **Flash** and **PHP** and provides its own implementation for other targets.

Usage of Haxe own implementation can be forced with `-D haxeJSON` compiler argument. This will also provide serialization of [enums](types-enum-instance.md) by their index, [maps](std-Map.md) with string keys and class instances.

Older browsers (Internet Explorer 7, for instance) may not have native **JSON** implementation. In case it's required to support them, we can include one of the JSON implementations available on the internet in the HTML page. Alternatively, a `-D old_browser` compiler argument that will make `haxe.Json` try to use native JSON and, in case it's not available, fallback to its own implementation.

---

Previous section: [Encoding JSON](std-Json-encoding.md)

Next section: [Remoting](std-remoting.md)