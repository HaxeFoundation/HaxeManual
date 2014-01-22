## 8.3.4 Implementation details

Haxe uses target platform's native resource embedding, if there is one, providing its own implementation otherwise.



* **Flash** resources are embedded as ByteArray definitions
* **C#** resources are included in the compiled assembly
* **Java** resources are packed in the resulting JAR file
* **C++** resources are stored in global byte array constants.
* **JavaScript** resources are serialized in Haxe serialization format and stored in a static field of `haxe.Resource` class.
* **Neko** resources are stored as strings in a static field of `haxe.Resource` class.

---

Previous section: [Retrieving binary resources](cr-resources-getBytes.md)

Next section: [Macros](macro.md)