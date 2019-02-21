## 10.9.4 Simplified Xml access

The [haxe.xml.Access](https://api.haxe.org/haxe/xml/Access.html) API exists to provide a dot-syntax access to the most common `Xml` methods.

Since Haxe 4 this class is named `haxe.xml.Access`. In Haxe 3 it was known as `haxe.xml.Fast`.

Here's an example of XML Access usage:
```haxe
// parse some XML data
var xml = Xml.parse("
  <user name='John'>
    <phone>
      <number>0000</number>
      <number>111</number>
    </phone>
  </user>
");
// wrap the Xml for Access
var access = new haxe.xml.Access(xml.firstElement());

// access attributes
trace(access.att.name); // attribute "name"
if (access.has.age) trace( access.att.age ); // optional attribute

// access the "phone" child, which is wrapped with haxe.xml.Access too
var phone = access.node.phone;

// iterate over numbers
for (p in phone.nodes.number) {
  trace(p.innerData);
}
```
This code works the same on all platforms.

##### Accessors
There are different accessors that can be used with the Access API:

* `.name` returns the name of the current element (same as `Xml.nodeName`).
* `.x` returns the current corresponding `Xml` node.
* `.att.<name>` access to a given attribute. An exception is thrown if the attribute doesn't exists.
* `.has.<name>` check the existence of an attribute.
* `.elements` the list of all sub-elements (which are the nodes with type `Xml.Element`).
* `.node.<name>` access to the first sub element with the given name. An exception is thrown if the element doesn't exists.
* `.nodes.<name>` returns a List of elements with the given name.
* `.hasNode.<name>` check the existence of a sub node with the given name.
* `.innerData` returns the inner `PCDATA` or `CDATA` of the node. An exception is thrown if there is no data or if there not only data but also other nodes.
* `.innerHTML` returns the XML string built with all the sub nodes, excluding the current one.

##### Self-closed nodes
Please note that we cannot access self-closed nodes as "regular" ones. 
For example, provided this XML:

```haxe
var xml = Xml.parse("<xml>
  <myNode1></myNode1>
  <myNode2/>
</xml>");

var access = new haxe.xml.Access(xml.firstElement());

var myNode1Value = access.node.myNode1.innerData; 
// no problem

var myNode2Value = access.node.myNode2.innerData; 
// ERROR, an exception is thrown!
```

If the XML might contain self-closed nodes, check `hasNode.innerData` before and default to an alternative value.

```haxe
var myNode2Value = access.node.myNode2.hasNode.innerData ? access.node.myNode2.innerData : null; 
```

---

Previous section: [Encoding Xml](std-Xml-encoding.md)

Next section: [Json](std-Json.md)