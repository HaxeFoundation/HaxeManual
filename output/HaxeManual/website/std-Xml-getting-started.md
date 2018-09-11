## 10.9.1 Getting started with Xml

##### Creating a root element

A `Xml` root element can be created using the `Xml.createElement` method.
```haxe
var root = Xml.createElement('root');
trace(root); // <root />
```

An root node element can also be created by parsing a `String` containing the XML data.
```haxe
var root = Xml.parse('<root />').firstElement();
trace(root); // <root />
```

##### Creating child elements

Adding child elements to the root can be done using the `addChild` method.
```haxe
var child:Xml = Xml.createElement('child'); 
root.addChild(child);
trace(root); // <root><child/></root>
```

Adding attributes to an element can be done by using the `set()` method.
```haxe
child.set('name', 'John');
trace(root); // <root><child name="John"/></root>
```

##### Accessing elements and values

This code parses an XML string into an object structure `Xml` and then accesses properties of the object.
```haxe
var xmlString = '<hello name="world!">Haxe is great!</hello>';
var xml:Xml = Xml.parse(xmlString).firstElement();

trace(xml.nodeName); // hello
trace(xml.get('name')); // world!
trace(xml.firstChild().nodeValue); // Haxe is great!
```

The difference between `firstChild` and `firstElement` is that the second function will return the first child with the type `Xml.Element`. 

##### Iterate on Xml elements
We can as well use other methods to iterate either over children or elements.
```haxe
for (child in xml) {
	// iterate on all children.
}
for (elt in xml.elements()) {
	// iterate on all elements.
}
for (user in xml.elementsNamed("user")) {
	// iterate on all elements with a nodeName "user".
}
for (att in xml.attributes()) {
	// iterator on all attributes.
}
```

See [Xml](http://api.haxe.org/Xml.html) API documentation for details about its methods.

---

Previous section: [Xml](std-Xml.md)

Next section: [Parsing Xml](std-Xml-parsing.md)