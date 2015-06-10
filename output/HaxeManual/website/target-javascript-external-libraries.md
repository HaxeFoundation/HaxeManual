## 12.1.2 Using external JavaScript libraries

The Haxe Standard Library comes with many externs for the JavaScript target. They provide access to the native APIs in a type-safe manner.
The [externs mechanism](lf-externs.md) assumes that the defined types exist at run-time but assumes nothing about how and where those types are defined. 

An example of an extern class is the [jQuery class](https://github.com/HaxeFoundation/haxe/blob/development/std/js/JQuery.hx#L83) of the Haxe Standard Library. 
To illustrate, here is a part of this extern class:

```haxe
@:initPackage
extern class JQuery implements ArrayAccess<Element> {
	function addClass( className : String ) : JQuery;
	function removeClass( ?className : String ) : JQuery;
	function hasClass( className : String ) : Bool;

	@:overload(function(html:String):JQuery{})
	@:overload(function(html:JQuery):JQuery{})
	function html() : String;
..
```

Note that functions can be overloaded to accept different types of arguments and return values, using the `@:overload` metadata. Function overloading works only in extern classes.
Using this extern, we can use jQuery like this:

```haxe
new JQuery("#my-div").addClass("brand-success").html("haxe is great!");
```

Beside externs, [Typedefs](type-system-typedef.md) can be another great way to name (or alias) complex JavaScript or JSON structures.

The package and class name of the extern class should be the same as defined in the external library. If that is not the case, rewrite the path of a class using `@:native`.

```haxe
package my.application.media;

@:native('external.library.media.video')
extern class Video {
..
```
The standard compilation options also provide more Haxe sources to be added to the project:

* To add a [Haxelib library](haxelib.md), use `-lib <library-name>`. There are many externs for popular native libraries.
* To force a whole package to be included in the project, use `--macro include('mypackage')` which will include all the classes declared in the given package and subpackages.

---

Previous section: [Getting started with Haxe/JavaScript](target-javascript-getting-started.md)

Next section: [Inject raw JavaScript](target-javascript-injection.md)