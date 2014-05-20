## 8.3.2 Retrieving text resources

To retrieve the content of an embedded resource, we use the static method **getString** of `haxe.Resource` passing a **resource identifier** to it:

```haxe
class Main {
    static function main() {
        trace(haxe.Resource.getString("welcome"));
    }
}

```

The code above will display the content of the **hello_message.txt** file that we included earlier using **welcome** as the identifier.

---

Previous section: [Embedding resources](cr-resources-embed.md)

Next section: [Retrieving binary resources](cr-resources-getBytes.md)