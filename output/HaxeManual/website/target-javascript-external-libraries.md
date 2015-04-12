## 12.1.2 Using external Javascript libraries

The Haxe Standard Library comes with many externs for the Javascript target. They provide access to the native APIs in a type-safe manner.
The [externs mechanism](lf-externs.md) assumes that the defined types exist at run-time but assumes nothing about how and where those types are defined. 
To clarify, in most cases we have to add a `<script>`-tag that links the external library manually to the HTML-document.

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

Note that functions can be overloaded to accept different types of arguments and return values, using the `@:overload` metatag. Function overloading works only in extern classes.
Using this extern, we can use jQuery like this:

```haxe
new JQuery("#my-div").addClass("brand-success").html("haxe is great!");
```

Beside externs, [Typedefs](type-system-typedef.md) can be another great way to name (or alias) complex Javascript or JSON structures.

The package and class name of the extern class should be the same as defined in the external library. If that is not the case, rewrite the path of a class using `@:native`.

```haxe
package my.application.media;

@:native('external.library.media.video')
extern class Video {
..
```

In Haxe, it is possible to call an exposed function thanks to the `untyped` keyword. This can be useful in some cases if we don't want to write externs. Anything untyped that is valid syntax will be generated as it is.

```haxe
untyped window.trackEvent("page1");  
```

Using the magic `__js__` function we can inject pure Javascript code fragments into the output. This code can not be validated, so it accepts invalid code in the output, which is error-prone.
This could, for example, write a Javascript comment in the output.

```haxe
untyped __js__('// haxe is great!');
```

The standard compilation options also provide more Haxe sources to be added to the project:

* To add a [Haxelib library](haxelib.md), use `-lib <library-name>`. There are many externs for popular native libraries.
* To add another class path, use `-cp <directory>`.
* To force a whole package to be included in the project, use `--macro include('mypackage')` which will include all the classes declared in the given package and subpackages.

---

Previous section: [Getting started with Haxe/Javascript](target-javascript-getting-started.md)

Next section: [Javascript target Metatags](target-javascript-metatags.md)