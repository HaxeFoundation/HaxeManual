## 8.3.1 Embedding resources

External files are embedded using the **-resource** compiler argument:


```haxe
-resource hello_message.txt@welcome
```

The string after the **@** symbol is the **resource identifier**. It will used in the code for retrieving the resource. It can be omitted (together with the **@** symbol), then the file name will become a resource identifier.

---

Previous section: [Resources](cr-resources.md)

Next section: [Retrieving text resources](cr-resources-getString.md)