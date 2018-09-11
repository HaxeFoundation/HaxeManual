## 10.9.3 Encoding Xml

The method [xml.toString()](http://api.haxe.org/Xml.html#toString) can be used to obtain the `String` representation.
```haxe
var xml = Xml.createElement('root');
xml.addChild(Xml.createElement('child1'));
xml.addChild(Xml.createElement('child2'));

trace(xml.toString()); // <root><child1/><child2/></root>
```

---

Previous section: [Parsing Xml](std-Xml-parsing.md)

Next section: [Json](std-Json.md)