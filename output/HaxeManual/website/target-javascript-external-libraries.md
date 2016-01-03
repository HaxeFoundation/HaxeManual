## 12.1.2 Using external JavaScript libraries

The [externs mechanism](lf-externs.md) provides access to the native APIs in a type-safe manner. It assumes that the defined types exist at run-time but assumes nothing about how and where those types are defined. 

An example of an extern class is the [jQuery class](https://github.com/HaxeFoundation/haxe/blob/development/std/js/jquery/JQuery.hx) of the Haxe Standard Library. 
To illustrate, here is a simplified version of this extern class:

```haxe
package js.jquery;
@:native("$") extern class JQuery {
	/**
		Creates DOM elements on the fly from the provided string of raw HTML.
		OR
		Accepts a string containing a CSS selector which is then used to match a set of elements.
		OR
		Binds a function to be executed when the DOM has finished loading.
	**/
	@:selfCall
	@:overload(function(element:js.html.Element):Void { })
	@:overload(function(selection:js.jquery.JQuery):Void { })
	@:overload(function(callback:haxe.Constraints.Function):Void { })
	@:overload(function(selector:String, ?context:haxe.extern.EitherType<js.html.Element, js.jquery.JQuery>):Void { })
	public function new():Void;

	/**
		Adds the specified class(es) to each element in the set of matched elements.
	**/
	@:overload(function(_function:Int -> String -> String):js.jquery.JQuery { })
	public function addClass(className:String):js.jquery.JQuery;

	/**
		Get the HTML contents of the first element in the set of matched elements.
		OR
		Set the HTML contents of each element in the set of matched elements.
	**/
	@:overload(function(htmlString:String):js.jquery.JQuery { })
	@:overload(function(_function:Int -> String -> String):js.jquery.JQuery { })
	public function html():String;
}
```

Note that functions can be overloaded to accept different types of arguments and return values, using the `@:overload` metadata. Function overloading works only in externs.

Using this extern, we can use jQuery like this:

```haxe
import js.jquery.*;
..
new JQuery("#my-div").addClass("brand-success").html("haxe is great!");
..
```

The package and class name of the extern class should be the same as defined in the external library. If that is not the case, rewrite the path of a class using `@:native`.

```haxe
package my.application.media;

@:native('external.library.media.video')
extern class Video {
..
```

Some JavaScript libraries favor instantiating classes without using the `new` keyword. To prevent the Haxe compiler outputting the `new` keyword when using a class, we can attach a `@:selfCall` metadata to its constructor. For example, when we instantiate the jQuery extern class above, `new JQuery()` will be outputted as `$()` instead of `new $()`. The `@:selfCall` metadata can also be attached to a method. In this case, the method will be interpreted as a direct call to the object, illustrated as follows:

```haxe
extern class Functor {
	public function new():Void;
	@:selfCall function call():Void;
}

class Test {
	static function main() {
		var f = new Functor();
		f.call(); // will be outputted as `f();`
	}
}
```

Beside externs, [Typedefs](type-system-typedef.md) can be another great way to name (or alias) a JavaScript type. The major difference between typedefs and externs is that, typedefs are duck-typed but externs are not. Typedefs are suitable for common data structures, e.g. point (`{x:Float, y:Float}`). Use of a point structure typedef for function arguments allows external JavaScript functions to accept point class instances from Haxe or from another JavaScript library. It is also useful for typing JSON objects.

The Haxe Standard Library comes with externs of [jQuery](https://jquery.com/) and [SWFObject](http://blog.deconcept.com/swfobject/). Their version compatibility is summarized as follows:

Haxe version  | Library                | Externs location 
 --- | --- | ---
3.3           | jQuery 1.11.3 / 2.1.4  | <code>js.jquery.*</code> 
3.2-          | jQuery 1.6.4           | <code>js.JQuery</code> 
3.3           | SWFObject 2.3          | <code>js.swfobject.*</code> 
3.2-          | SWFObject 1.5          | <code>js.SWFObject</code> 
 

There are many externs for other popular native libraries available on [Haxelib library](haxelib.md). To view a list of them, check out the [extern tag](http://lib.haxe.org/t/extern/).

---

Previous section: [Getting started with Haxe/JavaScript](target-javascript-getting-started.md)

Next section: [Inject raw JavaScript](target-javascript-injection.md)