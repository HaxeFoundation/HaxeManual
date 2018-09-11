## 10.9.2 Parsing Xml

The static method [Xml.parse](http://api.haxe.org/Xml.html#parse) can be used to parse **XML** data and obtain a Haxe value from it.

```haxe
var xml = Xml.parse('<root>Haxe is great!</root>').firstElement();
trace(xml.firstChild().nodeValue);
```

---

Previous section: [Getting started with Xml](std-Xml-getting-started.md)

Next section: [Encoding Xml](std-Xml-encoding.md)