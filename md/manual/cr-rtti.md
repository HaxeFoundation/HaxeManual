## 8.5 Runtime Type Information

The Haxe compiler generates runtime type information (RTTI) for classes that are annotated or extend classes that are annotated with the `:rtti` metadata. This information is stored as a XML string in a static field `__rtti` and can be processed through `haxe.rtti.XmlParser`. The resulting structure is described in [RTTI structure](cr-rtti-structure.md).

##### since Haxe 3.2.0

The type `haxe.rtti.Rtti` has been introduced in order to simplify working with RTTI. Retrieving this information is now very easy:

```haxe
@:rtti
class Main {
  var x:String;
  static function main() {
    var rtti = haxe.rtti.Rtti.getRtti(Main);
    trace(rtti);
  }
}
```

---

Previous section: [Resources](cr-resources.md)

Next section: [RTTI structure](cr-rtti-structure.md)