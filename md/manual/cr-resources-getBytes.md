## 8.3.3 Retrieving binary resources

While it's not recommended to embed large binary files in the application, it still may be useful to embed binary data. Binary representation of an embedded resource can be accessed using the static method **getBytes** of `haxe.Resource`:

```haxe
class Main {
    static function main() {
        var bytes = haxe.Resource.getBytes("welcome");
        trace(bytes.readString(0, bytes.length));
    }
}

```

The return type of **getBytes** method is `haxe.io.Bytes`, an object providing access to individual bytes of the data.

---

Previous section: [Retrieving text resources](cr-resources-getString.md)

Next section: [Implementation details](cr-resources-impl.md)