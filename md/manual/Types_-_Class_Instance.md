Similar to many object-oriented languages, classes in haxe are the primary data structure for the majority of programs. Each haxe class has an explicit name, an implied path and zero or more class fields. Here we will focus on the general structure of classes and their relations, while leaving the details of class fields for [[manual/Class_Fields]].

The following code example serves as basis for the remainder of this section:

```
class Point {
	var x : Int;
	var y : Int;
	public function new(x,y) {
		this.x = x;
		this.y = y;
	}
	public function toString() {
		return "Point("+x+","+y+")";
	}
}
```
Semantically, this class represents a point in discrete 2-dimensional space, but this is not important here. Let us instead describe the structure:



* The keyword `class` denotes that we are declaring a class.
* `Point` is the name of the class and could be anything conforming to the rules for type identifiers.
* Enclosed in curly braces `${}$` are the class fields,
* which consist of two **variable** fields `x` and `y` of type `Int`
* followed by a special **function** field named `new`, which is the **constructor** of the class,
* as well as a normal function `toString`


There is a special type in haxe which is compatible with all classes: