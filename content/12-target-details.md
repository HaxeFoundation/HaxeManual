<!--label:target-details-->
## Target Details

<!--subtoc-->

<!--label:target-syntax-->
### Accessing Target-specific Syntax

When writing code for a particular target, it might be necessary to access certain features that are only available on that target and inaccessible in Haxe code. It is still possible to access these features using the target-specific `Syntax` APIs:

* [`js.Syntax`](https://api.haxe.org/js/Syntax.html) - JavaScript syntax
* [`php.Syntax`](https://api.haxe.org/php/Syntax.html) - PHP syntax
* [`python.Syntax`](https://api.haxe.org/python/Syntax.html) - Python syntax

**Important note:** Before using these functions, make sure there is no alternative available in the Haxe Standard Library. The resulting syntax can not be validated by the Haxe compiler, which may result in invalid or error-prone code in the output. When checking if a particular feature is available in the standard library, consult the [API documentation](https://api.haxe.org/). Target-specific APIs are placed into a package named after the target, e.g. JavaScript-specific APIs are in the top-level `js` package. Most targets have a `Lib` class in their package which provides some common methods for that target.

##### `Syntax.code(expr, args...)`
##### since Haxe 4.0.0

Injects raw code expressions. The expression is a string which may include `{0}`, `{1}`, `{2}`, etc. - these are replaced with the corresponding arguments provided to the function. This is important if the code needs to reference Haxe fields, since the names of variables in the generated output may not correspond to their names in Haxe code. The Haxe compiler will take care of adding quotes if strings are provided. The function can also return values, although the return type is always `Dynamic`.

An example of `js.Syntax.code`:

```haxe
var myMessage = "Is Haxe great?";
var output:Bool = js.Syntax.code("confirm({0})", myMessage);
```

The generated JavaScript output is:

```haxe
var myMessage = "Is Haxe great?";
var output = confirm(myMessage);
```

Other functions are documented in the corresponding API sections. These generally include native operators that are not available in Haxe.

##### Other platforms

It is planned to implement `Syntax` APIs for other targets in future releases. For the time being, it is still possible to access target-specific syntax on some of the other platforms, albeit in a less type-safe manner, using an [`untyped`](type-system-untyped) expression:

* C++ `untyped __cpp__(expr, args...)`
* C# `untyped __cs__(expr, args...)`
* Java `untyped __java__(expr, args...)`
* Lua `untyped __lua__(expr, args...)`

The arguments for these follow exactly the same semantics as `Syntax.code`.



<!--label:target-javascript-->
### JavaScript

Haxe provides the ability to target JavaScript. It does so by transpiling Haxe to JavaScript. The current implementation targets ECMAScript 5. But it is possible to target lower versions using `-D js-es=<value>`.

When choosing the JavaScript target, only the used Haxe code of the project (and used parts of the standard library) are transpiled to JavaScript. This results in optimal filesize which is also readable. [Source maps](debugging-source-map-javascript) are available and there are several ways to get [debug](debugging) information. The standard library aims to have same functionality across all targets.

##### Usage

You may want to compile Haxe to JavaScript in the following scenarios:

**Client-side JavaScript**
Interacting with DOM elements. Haxe provides up-to-date typed interfaces to interact with the Document Object Model, allowing creation and update of DOM elements.

Haxe can be used together with existing third-party libraries and frameworks, such as jQuery, React or Vue. To access third-party frameworks with a strongly-typed API, there are extern libraries available on [Haxelib](https://lib.haxe.org/t/js/). Alternatively, it is possible to create own externs (see [Using external JavaScript libraries](target-javascript-external-libraries)) or use the dynamic type to access any framework, see [Accessing Target-specific Syntax](target-syntax).

**Creating graphics using Canvas and WebGL**
Use Haxe to create graphical elements on a web page using WebGL.

Libraries like [OpenFL](https://www.openfl.org/), [Heaps](https://heaps.io/) and [Kha](https://kha.tech/) make use of WebGL as one of their backends.

**Creating Haxe code that targets server-side JavaScript**
Working with server-side technology. Haxe can be used to create server-side JavaScript like Node.js.

<!--subtoc-->

<!--label:target-javascript-getting-started-->
#### Getting started with Haxe/JavaScript

Haxe can be a powerful tool for developing JavaScript applications. Let's look at our first sample.
This is a very basic example showing the toolchain.

Create a new folder and save this class as `Main.hx`.

```haxe
import js.Browser;
class Main {
    static function main() {
        var button = Browser.document.createButtonElement();
        button.textContent = "Click me!";
        button.onclick = (event) -> Browser.alert("Haxe is great");
        Browser.document.body.appendChild(button);
    }
}
```

To compile, either run the following from the command line:

```hxml
haxe --js js/app.js --main Main
```

Another possibility is to create and run (double-click) a file called `compile.hxml`. In this example the hxml file should be in the same directory as the example class.

```hxml
--js js/app.js
--main Main
```

The output will be _js/app.js_, which creates and adds a clickable button to the document body.

##### Run the JavaScript

To display the output in a browser, create an HTML-document called `index.html` and open it.

```xml
<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Haxe Application</title>
</head>
<body>
	<script src="js/app.js"></script>
</body>
</html>
```

##### More information

* [Debugging in JavaScript](debugging-javascript)
* [Haxe/JavaScript tutorials](https://code.haxe.org/category/javascript/)
* [Haxe JavaScript API docs](https://api.haxe.org/js/)
* [MDN JavaScript Reference](https://developer.mozilla.org/bm/docs/Web/JavaScript)
* [Haxe/Javascript documentation by Matthijs Kamstra](https://matthijskamstra.github.io/haxejs/)



<!--label:target-javascript-es6-->
#### ECMAScript 6 class generation

##### since Haxe 4.0

Starting with Haxe 4.0, Haxe can generate [ES6 class definitions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes) instead of classic function + prototype combination. This might be required when using third-party ES6 libraries, because native ES6 classes cannot be extended using the old method.

To enable ES6 generation mode, simply add `-D js-es=6` to the compiler arguments.

##### Accessing this before calling super constructors

One of significant differences between Haxe classes and ES6 classes reveals itself when inheritance is used. ES6 does not allow accessing `this` in any way before calling `super()` within a child class constructor, while Haxe allows calling `super()` at any place in the constructor.

Even when we don't explicitly access `this` before `super()` in Haxe code, it can still happen when a class has fields with initializer values.

Let's take a look at the following example:

```haxe
class Base {
  function new() {
    init();
  }
  function init() {
    trace("base init");
  }
}

class Child extends Base {
  var field = "hello";

  override function init() {
    trace(field);
  }
}
```

Haxe guarantees that the fields will be initialized before any constructor code is executed, and because accessing `this` (for setting the field value) before the `super()` call is not allowed in ES6, Haxe has to work this limitation around by transforming constructors like in the following example:

```js
class Base {
  constructor() {
    if(Base._hx_skip_constructor) {
      return;
    }
    this._hx_constructor();
  }
  _hx_constructor() {
    this.init();
  }
  init() {
    console.log("src/Main.hx:6:","base init");
  }
}
class Child extends Base {
  constructor() {
    Base._hx_skip_constructor = true;
    super();
    Base._hx_skip_constructor = false;
    this._hx_constructor();
  }
  _hx_constructor() {
    this.field = "hello";
    super._hx_constructor();
  }
  init() {
    console.log("src/Main.hx:14:",this.field);
  }
}
Base._hx_skip_constructor = false;
```

Note that the compiler does its best to be smart and only generates this workaround code when it's required.

##### When extending extern classes with constructors

One important limitation that one has to keep in mind is that it's obviously not possible for Haxe to do these transformations on [extern](https://haxe.org/manual/lf-externs.html) class implementations. That's why it is impossible to access `this` before calling `super()` at all when extending a native `extern` class. Haxe will detect these cases and emit a compile error pointing to first expression or field declaration that requires `this` access.

For example:

```haxe
extern class Base {
  function new();
}

class Child extends Base {
  var field = "hello";
}
```

Trying to compile this will fail with the following error: `Main.hx:6: characters 3-23 : Must call super() constructor before accessing this in classes derived from an extern class with constructor`

However, if the parent `extern` class would not have a constructor defined, this code would compile, because the compiler knows that it is safe to call a parent's empty `super()` constructor before anything else.

So, the following code:

```haxe
extern class Base {
}

class Child extends Base {
  var field = "hello";
}
```

Will generate the expected ES6 output:

```js
class Child extends Base {
  constructor() {
    super();
    this.field = "hello";
  }
}
```



<!--label:target-javascript-external-libraries-->
#### Using external JavaScript libraries


The [externs mechanism](lf-externs) provides access to the native APIs in a type-safe manner. It assumes that the defined types exist at run-time but assumes nothing about how and where those types are defined.

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

Beside externs, [Typedefs](type-system-typedef) can be another great way to name (or alias) a JavaScript type. The major difference between typedefs and externs is that, typedefs are duck-typed but externs are not. Typedefs are suitable for common data structures, e.g. point (`{x:Float, y:Float}`). Use of a point structure typedef for function arguments allows external JavaScript functions to accept point class instances from Haxe or from another JavaScript library. It is also useful for typing JSON objects.

**Deprecated:** Since Haxe 4.0.0: The jQuery and SWFObject externs have been removed from the standard library. For compatibility purposes they are available in the [hx3compat](https://github.com/HaxeFoundation/hx3compat/) library. See [Haxe 3 Compatibility](std-hx3compat).

Haxe version | Library               | Externs location
 --- | --- | ---
4.0          | jQuery 1.12.1 / 2.2.1 | with [hx3compat](https://github.com/HaxeFoundation/hx3compat/): `js.jquery.*`
4.0          | SFWObject 2.3         | with [hx3compat](https://github.com/HaxeFoundation/hx3compat/): `js.swfobject.*`
3.3          | jQuery 1.12.1 / 2.2.1 | `js.jquery.*`
3.3          | SWFObject 2.3         | `js.swfobject.*`
3.2-         | jQuery 1.6.4          | `js.JQuery`
3.2-         | SWFObject 1.5         | `js.SWFObject`


There are many externs for other popular native libraries available on [Haxelib library](haxelib). To view a list of them, check out the [extern tag](https://lib.haxe.org/t/extern/).



<!--label:target-javascript-metadata-->
#### JavaScript target Metadata

This is the list of JavaScript specific metadata. For more information, see also the complete list of all [Haxe built-in metadata](cr-metadata).

Metadata | Description
 --- | ---
@:expose _(?Name=Class path)_  |  Makes the class available on the <code>window</code> object or <code>exports</code> for node.js
@:jsRequire  |  Generate javascript module require expression for given extern
@:selfCall  |  Translates method calls into calling object directly



<!--label:target-javascript-expose-->
#### Exposing Haxe classes for JavaScript

It is possible to make Haxe classes or static fields available for usage in plain JavaScript.
To expose, add the `@:expose` metadata to the desired class or static fields.

This example exposes the Haxe class `MyClass`.

[code asset](assets/ClassExpose.hx)

It generates the following JavaScript output:

```js
(function ($hx_exports) { "use strict";
var MyClass = $hx_exports.MyClass = function(name) {
	this.name = name;
};
MyClass.prototype = {
	foo: function() {
		return "Greetings from " + this.name + "!";
	}
};
})(typeof window != "undefined" ? window : exports);
```

By passing globals (like `window` or `exports`) as parameters to our anonymous function in the JavaScript module, it becomes available which allows to expose the Haxe generated module.

In plain JavaScript it is now possible to create an instance of the class and call its public functions.

```js
// JavaScript code
var instance = new MyClass('Mark');
console.log(instance.foo()); // logs a message in the console
```

The package path of the Haxe class will be completely exposed. To rename the class or define a different package for the exposed class, use `@:expose("my.package.MyExternalClass")`

##### Shallow expose

When the code generated by Haxe is part of a larger JavaScript project and wrapped in a large closure it is not always necessary to expose the Haxe types to global variables.
Compiling the project using `-D shallow-expose` allows the types or static fields to be available for the surrounding scope of the generated closure only.

When the code is compiled using `-D shallow-expose`, the generated output will look like this:

```js
var $hx_exports = $hx_exports || {};
(function () { "use strict";
var MyClass = $hx_exports.MyClass = function(name) {
	this.name = name;
};
MyClass.prototype = {
	foo: function() {
		return "Greetings from " + this.name + "!";
	}
};
})();
var MyClass = $hx_exports.MyClass;
```

In this pattern, a var statement is used to expose the module; it doesn't write to the `window` or `exports` object.



<!--label:target-javascript-require-->
#### Loading extern classes using "require" function

##### since Haxe 3.2.0

Modern JavaScript platforms, such as Node.js provide a way of loading objects
from external modules using the "require" function. Haxe supports automatic generation
of "require" statements for `extern` classes.

This feature can be enabled by specifying `@:jsRequire` metadata for the extern class. If our `extern` class represents a whole module, we pass a single argument to the `@:jsRequire` metadata specifying the name of the module to load:

[code asset](assets/JSRequireModule.hx)

In case our `extern` class represents an object within a module, second `@:jsRequire` argument specifies an object to load from a module:

[code asset](assets/JSRequireObject.hx)

The second argument is a dotted-path, so we can load sub-objects in any hierarchy.

If we need to load custom JavaScript objects in runtime, a `js.Lib.require` function can be used. It takes `String` as its only argument and returns `Dynamic`, so it is advised to be assigned to a strictly typed variable.





<!--label:target-flash-->
### Flash

<!--subtoc-->

<!--label:target-flash-getting-started-->
#### Getting started with Haxe/Flash

Developing Flash applications is really easy with Haxe. Let's look at our first code sample.
This is a basic example showing most of the toolchain.

Create a new folder and save this class as `Main.hx`.

```haxe
import flash.Lib;
import flash.display.Shape;
class Main {
    static function main() {
        var stage = Lib.current.stage;

        // create a center aligned rounded gray square
        var shape = new Shape();
        shape.graphics.beginFill(0x333333);
		shape.graphics.drawRoundRect(0, 0, 100, 100, 10);
		shape.x = (stage.stageWidth - 100) / 2;
		shape.y = (stage.stageHeight - 100) / 2;

		stage.addChild(shape);
    }
}
```

To compile this, either run the following from the command line:

```hxml
haxe --swf main-flash.swf --main Main --swf-version 15 --swf-header 960:640:60:f68712
```

Another possibility is to create and run (double-click) a file called `compile.hxml`. In this example the hxml file should be in the same directory as the example class.

```hxml
--swf main-flash.swf
--main Main
--swf-version 15
--swf-header 960:640:60:f68712
```

The output will be a main-flash.swf with size 960x640 pixels at 60 FPS with an orange background color and a gray square in the center.

##### Display the Flash

Run the SWF standalone using the [Standalone Debugger FlashPlayer](https://www.adobe.com/support/flashplayer/downloads.html).

To display the output in a browser using the Flash plugin, create an HTML-document called `index.html` and open it.

```xml
<!DOCTYPE html>
<html>
	<body>
		<embed src="main-flash.swf" width="960" height="640">
	</body>
</html>
```

##### More information

* [Haxe/Flash API docs](https://api.haxe.org/flash/)
* [Adobe Livedocs](https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/)



<!--label:target-flash-resources-->
#### Embedding resources

Embedding resources is different in Haxe compared to ActionScript 3. Instead of using `[embed]` (AS3-metadata) use [Flash specific compiler metadata](target-flash-metadata) like `@:bitmap`, `@:font`, `@:sound` or `@:file`.

```haxe
import flash.Lib;
import flash.display.BitmapData;
import flash.display.Bitmap;

class Main {
  public static function main() {
    var img = new Bitmap( new MyBitmapData(0, 0) );
    Lib.current.addChild(img);
  }
}

@:bitmap("relative/path/to/myfile.png")
class MyBitmapData extends BitmapData { }
```



<!--label:target-flash-external-libraries-->
#### Using external Flash libraries

To embed external `.swf` or `.swc` libraries, use the following [compilation options](https://haxe.org/documentation/introduction/compiler-usage.html):

* `--swf-lib <file>` Embeds the SWF library in the compiled SWF.
* `--swf-lib-extern <file>` Adds the SWF library for type checking but doesn't include it in the compiled SWF.

The standard compilation options also provide more Haxe sources to be added to the project:

* To add another class path use `-p <directory>`.
* To add a [Haxelib library](haxelib) use `-L <library-name>`.
* To force a whole package to be included in the project, use `--macro include('mypackage')` which will include all the classes declared in the given package and subpackages.



<!--label:target-flash-metadata-->
#### Flash target Metadata

This is the list of Flash specific metadata. For a complete list see [Haxe built-in metadata](cr-metadata).

Metadata | Description
 --- | ---
@:bind  |  Override Swf class declaration
@:bitmap _(Bitmap file path)_  |  _Embeds given bitmap data into the class (must extend <code>flash.display.BitmapData</code>)
@:debug  |  Forces debug information to be generated into the Swf even without <code>--debug</code>
@:file(File path)  |  Includes a given binary file into the target Swf and associates it with the class (must extend <code>flash.utils.ByteArray</code>)
@:font _(TTF path Range String)_  |  Embeds the given TrueType font into the class (must extend <code>flash.text.Font</code>)
@:getter _(Class field name)_  |  Generates a native getter function on the given field
@:noDebug |  Does not generate debug information into the Swf even if <code>--debug</code> is set
@:ns  |  Internally used by the Swf generator to handle namespaces
@:setter _(Class field name)_  |  Generates a native setter function on the given field
@:sound _(File path)_  |  Includes a given _.wav_ or _.mp3_ file into the target Swf and associates it with the class (must extend <code>flash.media.Sound</code>)





<!--label:target-neko-->
### Neko

Haxe supports compilation to Neko bytecode. [Neko](https://nekovm.org/) is a virtual machine that was originally designed for Haxe. Neko is superseded by [HashLink](target-hl), introduced with Haxe 3.4.

<!--subtoc-->

<!--label:target-neko-getting-started-->
#### Getting started with Haxe/Neko

To get started with Haxe/Neko, create a new folder and save this class as `Main.hx`.

[code asset](assets/HelloWorld.hx)

To compile, either run the following from the command line:

```hxml
haxe --neko hello.n --main Main
```

Another possibility is to create and run (double-click) a file called `compile.hxml`. In this example the hxml file should be in the same directory as the example class.

```hxml
--neko hello.n
--main Main
```

The compiler outputs a binary file called `hello.n` in the current folder, which can be executed with `neko hello.n` from the command line.



<!--label:target-php-->
### PHP

<!--subtoc-->

<!--label:target-php-getting-started-->
#### Getting started with Haxe/PHP

To get started with Haxe/PHP, create a new folder and save this class as `Main.hx`.

[code asset](assets/HelloPHP.hx)

To compile, either run the following from the command line:

```hxml
haxe --php bin --main Main
```

Another possibility is to create and run (double-click) a file called `compile.hxml`. In this example the hxml file should be in the same directory as the example class.

```hxml
--php bin
--main Main
```

The compiler outputs in the given **bin**-folder, which contains the generated PHP classes that prints the traced message when you run it.

##### since Haxe 4.0.0

The generated PHP code is compatible with PHP 7.0.0 or later. Prior to Haxe 4, the minimum required version was PHP 5.1.0.



<!--label:target-php-defines-->
#### Defines

Define | Description
 --- | ---
<code>php-prefix=&lt;namespace&gt;</code> | Root namespace for generated PHP classes. E.g. if compiled with <code>-D php-prefix=some.sub</code>, then all classes will be generated in the <code>\some\sub</code> namespace.
<code>php-lib=&lt;name&gt;</code> | Select the name for the PHP lib directory.
<code>php-front=&lt;name&gt;</code> | Select the name for the PHP front file (default: <code>index.php</code>).

##### More information

* [Haxe/PHP API docs](https://api.haxe.org/php/)
* [PHP.net Documentation](https://php.net/docs.php)
* [PHP to Haxe tool](http://phptohaxe.haqteam.com/code.php)





<!--label:target-cpp-->
### C++

<!--subtoc-->

<!--label:target-cpp-getting-started-->
#### Getting started with Haxe/C++

The C++ target uses various C++ compilers, which are assumed to be already installed on the system, to create native executables or libraries. The compilation happens in two phases. Firstly, the Haxe compiler generates source, header and build files in an output directory. Secondly, the `hxcpp` [Haxelib library](haxelib) is invoked to run the system compilers and linkers required to generate the ultimate result.

##### Prerequisites

Before you can use the C++ target, you need to install:

- `hxcpp` - install with `haxelib install hxcpp`.
- A C++ compiler, such as `g++`, `clang++`, or MSVC++.

##### System Compilers

System compilers are supported on the three primary operating systems - Mac, Linux, and Windows.

On Mac, it is recommended that you install the latest Xcode from the Mac App Store.

On Linux, it is recommended that you use the system package manager to install the compilers.

On Windows, Microsoft Visual Studio is recommended. On Windows, you can also use `gcc`-based compilers. A minimal distribution is included in a Haxelib library, and can be installed with `haxelib install minimingw`.

##### Cross Compilers

`hxcpp` can be used to compile for non-host architectures if you have a suitable cross-compiler installed. The compilers are usually supplied in the form of a Software Development Kits (SDK), or in the case of iOS devices, come with the system compiler (Xcode). Selecting which compiler to use is achieved by defining particular variables in the `hxcpp` build environment. Note that the `hxcpp` build tool is only responsible for producing a native executable or a native library (static or dynamic), not the complete bundling and packaging of assets and meta-data that is typically required for mobile devices. Additional Haxe libraries can be used for this task.

##### More information

- [Haxe/C++ API documentation](https://api.haxe.org/cpp/)


<!--label:target-cpp-build-environment-->
#### The Hxcpp Build Environment

The `hxcpp` build environment can be controlled by setting or defining variables in key-value pairs. Defining a key without a particular value is usually enough to trigger the desired behavior, and these keys are often referred to as "defines".

See [Defines](target-cpp-defines) for a list of standard defines.

##### Defining from the Command Line

The easiest way to change the `hxcpp` build environment is to pass the defines though the Haxe command line using `-D`. Key-value pairs can also be passed this way, e.g.:

```
haxe --main Main --cpp cpp -D android -D static_link -D PLATFORM=android-9
```

Here:

 - `android` is defined - causes `hxcpp` to cross-compile to Android.
 - `static_link` is defined - causes a static (rather than dynamic) library to be created.
 - the android target platform (`PLATFORM`) is set to a particular value (`android-9`). This platform information is passed on to the SDK so it can generate the appropriate code.

Advanced users can add additional defines to the system at compile time using macros. These definitions will also be passed on to the `hxcpp` build tool.

##### Defining from System Environment Variables

The `hxcpp` build tool will import all the system environment variables, so you can configure the processes using the system like:

```
export HXCPP_VERBOSE=
```

Or, on Windows:

```
set HXCPP_VERBOSE=1
```

If you are running Haxe though an IDE, some care must be taken with environment variables since the variables may be read once from the environment in which the IDE was started, rather than changing when the variables are changed on the system.

##### Defining from `.hxcpp_config.xml`

The `hxcpp` build tool parses several "build files". These files are in a basic XML file format and can be used to set, or conditionally set, configuration variables. As part of the build process, the `.hxcpp_config.xml` file, known as the configuration file, will be read (twice). This file is located in the user's home directory (or user's profile directory on Windows) and is the best place to configure variables that are specific to the system that rarely change, such as the location of cross-compiler SDKs. A placeholder file will be generated the first time `hxcpp` is run by a user on the machine. You can see the exact location of this file in the build log if you compile with the `HXCPP_VERBOSE` define.

The configuration file is read twice. The first time the `vars` section is read early in the configuration process, and is used to set up and configure the location of compilers. The second time, the `exes` section is read near the end of the process and allows modification of the compiler or build process based on all the available information. See [`build.xml` file format](target-cpp-file-format) for details on the file format.

##### Defining via `@:buildXml` Metadata

Configuration data can be injected into the `build.xml` file that is created by Haxe. This is done attaching metadata to a Haxe class that is directly or indirectly included in the build. For example:

```haxe
@:buildXml("
<target id='haxe'>
  <lib name='${haxelib:nme}/lib/${BINDIR}/libnme${LIBEXTRA}${LIBEXT}'/>
</target>
<include name='${haxelib:nme}/lib/NmeLink.xml'/>
")
@:keep class StaticNme { ... }
```

This metadata is best for adding libraries or include paths to the build.
Some notes:

 - The `@:keep` metadata is added to prevent [dead code elimination](cr-dce) from removing this class.
 - Quoting can be a bit tricky - here the double-quotes are used for Haxe, and the single quotes are added to the `build.xml`.
 - Injecting a single "include" command is a good way to manage the quoting issue.
 - Knowledge of the build system is required to get this right. See [`build.xml` file format](target-cpp-file-format) for details on the file format.
 - The `build.xml` file is read after the choice of compiler has been made, so it is generally not suitable for configuring the compiler.

<!--label:target-cpp-file-format-->
#### Build.xml

The `hxcpp` `build.xml` build system is designed to make compiling, cross-compiling and linking easy on a large variety of operating systems and devices. It was originally designed to build the Haxe-generated C++ code but has evolved to replace the need for configuration tools in many open source libraries.

##### Running

The source code for the tool lives in `tools/hxcpp` in the `hxcpp` repo. When compiled, it can be run with the Haxelib tool. This is usually done automatically by the Haxe compiler after the C++ code has been generated. It can be done manually like:

```
haxelib run hxcpp build.xml key=value ... [target]
```

##### Configuration

See [the `hxcpp` build environment](target-cpp-build-environment).

##### Format

The compiler specification and target lists all use the same format.

 - Uses XML.
 - Mostly declarative list of files and flags.
 - Order is important:
   - Overriding values is a valid technique.
   - "commands" are run as they are parsed (e.g., `echo`).
 - Conditions are possible with `if` and `unless` node attributes.
 - Substitution is possible with `${VAR}` syntax.
 - The `default` target must be defined.

##### Conditions/Substitution

Most of the XML nodes support `if` and `unless` attributes. These will enable or disable the whole node according the existence or non-existence of a define. These can be combined with a space for "and" or two pipes for "or".

Substitution is supported via the dollars-brace syntax, and does basoc text substitution. In addition, there is some special syntax that can be used:

 - `${VAR}` - normal replacement.
 - `${removeQuotes:VAR}` - strips surrounding quotes from `VAR`, if any.
 - `${dospath:VAR}` - converts `VAR` to path with backward slashes (as used on Windows).
 - `${dir:PathWithFilename}` - just the directory part of a filename.
 - `${this_dir}` - location of the directory containing the `build.xml` file.

##### Example

The following code is saved as `example.xml`:

```xml
 <xml>
   <echo value="Hello ${WHO}" if="WHO" unless="SILENT" />
   <echo value="You are in ${haxelib:hxcpp}" unless="WHO||SILENT"/>
   <error value="Silent and who both specified" if="WHO SILENT"/>
   <target id="default" />
 </xml>
```

Some example usage:

```
unset SILENT
haxelib run hxcpp example.xml
haxelib run hxcpp example.xml WHO=world default
export SILENT=1
haxelib run hxcpp example.xml
haxelib run hxcpp example.xml WHO=world
```

Or, on Windows:

```
unsetenv SILENT
haxelib run hxcpp example.xml
haxelib run hxcpp example.xml WHO=world default
setenv SILENT 1
haxelib run hxcpp example.xml
haxelib run hxcpp example.xml WHO=world
```

##### Details

The `build.xml` file contains configuration, targets, compilers, linkers, and files. The details can be found in the subsections:

<!--subtoc-->

<!--label:target-cpp-build_xml-TopLevel-->
##### Structure of the top-level

The top-level nodes live inside an `<xml>` node, and can be:

- `set` - Sets a "define", define being a general variable.

```xml
<set name="name" value="1" />
```

- `setenv` - Sets an `hxcpp` define and an environment variable for child processes.

```xml
<setenv name="name" value="1" />
```

- `unset` - Unsets a define. `if="name"` will no longer be true.

```xml
<unset name="name" />
```

- `setup` - Used internally to call custom setup code to find SDKs etc.

```xml
<setup name="androidNdk|blackberry|msvc|pdbserver|mingw|emscripten|nvcc" />
```

- `echo` - Prints a value to console. Good for debugging.

```xml
<echo value="text" />
```

- `error` - Prints a value to console and forces an error. Good for checking prerequisites.

```xml
<error value="error message" />
```

- `pleaseUpdateHxcppTool` - Used to tell people updating git version that they need to recompile the build tool.

```xml
<pleaseUpdateHxcppTool version="1" />
```

- `path` - Adds a directory to the exe search path.

```xml
<path name="directory_to_add" />
```

- `mkdir` - Creates a directory.

```xml
<mkdir name="directory" />
```

- `section` - Groups blocks of elements - usually ones that all respect the same `if`/`unless` condition.

```xml
<section name="id" />...</section>
```

- `copy` - Copies a file when the node is parsed.

```xml
<copy to="destination" from="src" />
```

- `import`/`include` - Reads XML from another file. `import` resets the relative base to the new file, `include` does not.

    - `noerror` - when `true`, allows the file to be missing. (optional)
    - `section` - only read the named section from the XML file. Used by `hxcpp_config.xml`. (optional)

```xml
<import name="filename" section="filter" noerror="true" />
<include name="filename" section="filter" noerror="true" />
```

- `pragma` - Only include build file once, even with multiple include statements.

```xml
<pragma once="true" />
```

- `nvccflag` - Adds flag to all `nvcc` compiles.

```xml
<nvccflag name="?name" value="-IincludePath" />
```

- `nvcclinkflag` - Adds flag when linking with `nvcc` code.

```xml
<nvcclinkflag name="?name" value="-arch=sm_30" />
```

- `files` - Defines a file group, and sets default tags.

    - `dir` - directory to which the filenames in the group are relative.
    - `tags` - comma-separated list of tags.

```xml
<files dir="dir" name="name" tags="tag1,tag2,tag3" >...</files>
```

- `target` - Defines a target, and sets its `toolid` (link mode) and output name.

```xml
<target name="name" overwrite="true" append="true" tool="linker" toolid="${haxelink}" output="filename">...</target>
```

- `copyFile` - Copies a file after the given `toolId` is run into target output directory.

```xml
<copyFile name="destination" from="src" allowMissing="true" overwrite="true" toolId="filter" />
```

- `magiclib` - Internally used for replacing DLLs with object files.

```xml
<magiclib name="libname" replace="old dll" />
```

- `compiler` - Defines a compiler. It is assumed only 1 compiler is active.

    - `replace` - when `true` the compiler is overridden, otherwise the contents of this node are appended to an existing compiler with the same `id`. (optional)
    - `exe` - can be overridden in the body of the definition.

```xml
<compiler id="id" exe="command" replace="true">...</compiler>
```

- `stripper` - Defines a stripper, used to remove debug information for release from gcc executables.

    - `replace` - when `true` overwrites, otherwise appends. (optional)

```xml
<stripper exe="command" replace="true">...</stripper>
```

- `linker` - Defines a linker.

    - `replace` - when `true` overwrites, otherwise appends. (optional)
    - `id` - can be `static_link`, `dll`, or `exe`. Usually all 3 linkers are defined.
    - `exe` - can be overridden in the body of the definition.

```xml
<linker id="id" exe="command" replace="true">...</linker>
```

- `prelinker` - Defines a prelinker.

    - `replace` - when `true` overwrites, otherwise appends.

```xml
<prelinker name="id" replace="true" />...</prelinker>
```

<!--label:target-cpp-build_xml-Files-->
##### Files

The files node defines a group of files that all share the same attributes, including relative directory, default compiler flags and dependencies.  The node can be used to define a set of header files on which other files can depend, or a set of source files to be compiled and included in a target.

- `depend` - Declares that all files in the group depend on another file or another file group.

    - `name` - if the named file changes then all the files in the group need recompiling.
    - `files` - if any of the files in the named group changes then then all the files in the group need recompiling.

```xml
<depend name="filename" />
<depend files="filesId" />
```

- `options` - Sets the name of the file containing compiler flags. When the cache is not used, `Options.txt` helps detect when the options have changed, and therefore whether files need recompiling.

```xml
<options name="Options.txt" />
```

- `config` - Sets the name of the file to generate that contains the C++ preprocessor defines that were active when code was compiled.

```xml
<config name="outfile.h" />
```

- `tag` - Adds a default compiler tag for all files in the group. See [Tags](target-cpp-build_xml-Tags).

```xml
<tag value="tag" />
```

- `addTwice` - When compiled to a library, adds the library twice to the link line - once at the beginning and once at the end to satisfy Linux selective linking.

```xml
<addTwice value="true" />
```

- `cache` - Enables compiler cache for files in the group. See [compile cache](target-cpp-CompileCache) for more details.

    - `project` - name of project used to manage and group object files in the cache.
    - `asLibrary` - link the objects (`.obj`) into a `.lib` file, which can skip unneeded objects, but will also skip things that rely on static initializers to register handlers, so be careful.

```xml
<cache value="true" project="name" asLibrary="true" />
```

- `include` - Includes an external file list.

```xml
<include name="filename.xml" />
```

- `section` - Groups blocks of elements - usually ones that all respect the same `if`/`unless` condition.

```xml
<section name="id" />...</section>
```

- `compilerflag` - Adds a compiler flag when compiling files in the group.

    - `name` and `value` - adds 2 command-line arguments when compiling.
    - `value` - adds 1 command-line argument when compiling.

```xml
<compilerflag name="name" value="value" />
<compilerflag value="value" />
```

- `nvcc` - This group is compiled with nvcc.

```xml
<nvcc />
```

- `objprefix` - Sets the id prepended to generated object (`.obj`) name to allow alphabetical grouping of similar objects.

```xml
<objprefix value="prefix" />
```

- `precompiledheader` - Use a precompiled header of given name when compiling the group.

    - `name` - the include used when precompiling these files (without the .h).
    - `directory` - the location of this file.
    - e.g. for `#include <lib/Header.h>`:

        - `name="lib/Header"`
        - `directory="${haxelib:somelib}/include"`

```xml
<precompiledheader name="name" dir="directory" />
```

- `file` - Adds a file to the group, with optional attributes.

    - `name` - name of the file - may be absolute or relative to `dir`.
    - `tags` - overrides group tags. See [Tags](target-cpp-build_xml-Tags). (optional)
    - `filterout` - allows files to be skipped at compile-time if the named define exists. This is useful when the define is set sometime after the file list is parsed.
    - `embed` - causes the file to be embedded as an extern C++ `const char *` string constant of the specified name.
    - `<depend name="..." />` (child node) - filename of additional dependency.

```xml
<file name="filename" tags="tag,tag1" filterout="define" embedName="embed" >
   <depend name="filename1" />
   <depend name="filename2" />
</file>
```

<!--label:target-cpp-build_xml-Tags-->
##### Tags

Tags are identifiers that link compiler flags with specific files.  Usually, they are defined in a `files` group with the `tags` attribute as a comma-separated list, and with the `tag` attribute on a compiler `flag` node.  Files are then compiled with all the flags that have matching tags.

By restricting tags to certain files, only a sub-set of files needs to be recompiled when conditions change, and files without the relevant tags can reuse their object files. This can save a lot of compilation time, since some flags only apply to a few files.

Files can override the group tags by specifying their own `tags` attribute.  Groups can add tags with the `tag` node.

Some tags have standard meanings when compiling Haxe code:

  - `haxe` - adds all the required compiler flags to get Haxe-generated code to compile correctly, and should be added to all files that depend directly or indirectly on `hxcpp.h`.
  - `static` - will add the `STATIC_LINK` define when appropriate, which is used for generating CFFI glue code. It should be added to CFFI code that might generate static libraries.
  - `gc` - These flags only affect the garbage-collection files.
  - `hxstring` - These flags only affect `String.cpp`.
  - optimization tags - each file is assumed to have exactly 1 optimization tag. If none is explicitly specified, then the default is used depending on whether it is a debug or release build. They are:

    - `optim-std` - alias for `debug` or `release` depending on build.
    - `debug`
    - `release`
    - `optim-none`
    - `optim-size` - optimize for size.

Setting one of these tags is useful for compiling your library in release mode, even if haxe has `-debug`. Some very big files are slow to compile in release mode, so using a less optimized mode can be faster.

The tags attribute can be added to a Haxe-generated file using the `@:fileXml` meta, e.g.:

```haxe
@:fileXml("tags='haxe,optim-none'")
class MyClass { ... }
```

Here, the class is compiled with the normal Haxe flags, but has optimizations disabled, which can lead to much faster compilation times in some circumstances.

<!--label:target-cpp-build_xml-Targets-->
##### Targets

Targets are used to produce binaries, or to group other targets. When compiling executables or dynamic libraries, they provide the additional link libraries.

By default, `hxcpp` will try to compile the `default` target, so it is easiest to define this one - perhaps by simply adding a dependence on your other target(s).

The target is defined with a `toolid` attribute: `exe`, `static_link`, or `dll`. This defines which linker is used, but many of the target entries will be the same even if the linker is changed.

Targets can contain the following nodes:

- `subTargetName` - Builds another target before building this one.

```xml
<target id="subTargetName" />
```

- `merge` - Combines fields from another target. This is useful if you want a target to function as a static or dynamic library when compiled on its own, but also allow it to be used as a list of object files if another target wants to link in the object files directly.

```xml
<merge id="otherTargetName" />
```

- `files` - Adds a named group of compiled files to the target.

```xml
<files id="filesId"/>
```

- `section` - Groups blocks of elements - usually ones that all respect the same `if`/`unless` condition.

```xml
<section>...</section>
```

- `lib` - Adds a library to the link line.

    - `name` - the complete name is specified.
    - `base` - the name without a compiler-specific extension (.a/.lib) is specified.
    - `hxbase` - the name without an extension and architecture (`-v7`/`.iphonesim`) is specified.

```xml
<lib (name|hxbase|base)="libName" />
```

- `flag` - Adds a single link flag.

```xml
<flag value="flag"/>
```

- `vflag` - Adds a name-value pair of link arguments.

```xml
<vflag name="flag1" value="flag2"/>
```

- `depend` - Declares that the target depends on the given filename.

```xml
<depend name="filename" />
```

- `dir` - Adds a directory to the target's directory list. These directories will get removed when the target is cleaned.

```xml
<dir name="tempPath" />
```

- `outdir` - Sets the directory for build results - including "copyFile" targets.

```xml
<outdir name="path"/>
```

- `ext` - Sets the extension for the generated files.

    - `ext` - the extension, should contain ".".

```xml
<ext name=".ext"/>
```

- `builddir` - Sets the directory from which the target's build commands are run, and therefore the relative base for some filenames, and destination for some compiler-generated temporary files.

```xml
<builddir name="path"/>
```

- `libpath` - Add a library search path to the build command.

    - `name` - directory. The linker will add the required flags.

```xml
<libpath name="directory"/>
```

<!--label:target-cpp-build_xml-Compiler-->
##### Compiler

Compilers are run over each of the changed files in each of the file groups in a target to create object files, which are then linked into the target.  Modification dates or hashes are used to tell if files need recompiling, or if the object file can be reused.

- `flag` - Adds a single argument to the compiler command line.

    - `value` - flag added to the command line.
    - `tag` - optional filter to restrict flag to files with a matching tag. See [Tags](target-cpp-build_xml-Tags).

```xml
<flag value="value" tag="tag" />
```

- `cflag`/`cppflag`/`objcflag`/`mmflag` - Adds a flag when compiling specific file types.

    - `cflag` - only added to `.c` (C) files.
    - `cppflag` - only added to `.cpp` (C++) files.
    - `objcflag` - only added to `.objc` (Objective-C) files.
    - `mmflag` - only added to `.mm` (Objective-C++) files.

```xml
<cflag value="value" />
<cppflag value="value" />
<objcflag value="value" />
<mmflag value="value" />
```

- `pchflag` - Adds a flag when compiling precompiled header `.h` files.

    - `pchflag` - usually `["-x", "c++-header"]` for apple to specify the "identity" of the header.

```xml
<pchflag value="value" />
```

- `pch` - Sets the precompiled header style - `gcc` or `msvc`.

```xml
<pch value="gcc|msvc" />
```

- `objdir` - Sets the name of the directory used to store object files. Should be unique for a given set of compiler flags to avoid linking against the wrong architecture.

    - `value` - usually built programmatically, e.g. `obj/msvc${MSVC_VER}-rt${OBJEXT}${OBJCACHE}${XPOBJ}`.

```xml
<objdir value="obj/somewhere" />
```

- `output` - Sets the flag used to specify the compiler's output.

    - `value` - flag value. Note that it should contain a space character if the actual name should be a separate argument, like `-o<space>`, or `-o`/`-out:` if the name should be appended directly.

```xml
<outflag value="-flag" />
```

- `exe` - Overrides the executable command specified in the compiler attribute.

    - `name` - command. Usually you would use `path` to add the directory containing the executable, then specify the filename part only in this attribute.

```xml
<exe name="command" />
```

- `ext` - Sets the object file extension.

    - `name` - extension, including ".". `.o` on Linux and Mac, `.obj` on Windows.

```xml
<ext name=".obj" />
```

- `getversion` - Sets the command used to obtain the version of the compiler.  This is used for checking if the compiler has changed, and therefore whether the objects need recompiling.

    - `value` - command to run. It defaults to `(compiler) --version` which works for `gcc`-based compilers. Setting it to an empty value will disable caching.

```xml
<getversion value="command" />
```

- `section` - Groups blocks of elements - usually ones that all respect the same `if`/`unless` condition.

```xml
<section>...</section>
```

- `include` - Includes compiler options from another file. Most compilers should include `<include name="toolchain/common-defines.xml" />` to add the defines used by `hxcpp`.

```xml
<include name="filename" />
```

<!--label:target-cpp-build_xml-Linker-->
##### Linker

Generally only one linker is run per target to build a static library, dynamic library, or executable. The `id` attribute of the linker specifies which type of linking is performed.

- `exe` - Overwrites the command for this linker.

```xml
<exe name="command" />
```

- `flag` - Adds a single link flag.

```xml
<flag value="flag"/>
```

- `ext` - Default extension for generated files - if not overridden by target.

     - value - extension, including `.`.

```xml
<ext value=".ext"/>
```

- `outflag` - Sets the flag for specifying linker output name.

    - `value` - flag value. Note that it should contain a space character if the actual name should be a separate argument, like `-o<space>`, or `-o`/`-out:` if the name should be appended directly.

```xml
<outflag value="-o"/>
```

- `section` - Groups blocks of elements - usually ones that all respect the same `if`/`unless` condition.

```xml
<section>...</section>
```

- `libdir` - Sets the temporary directory name to build into. This will capture the extra files the compiler generates, then the desired file will be copied to the correct location.

```xml
<libdir name="name"/>
```

- `lib` - Adds a library to the link line.

    - `name` - the complete name is specified.
    - `base` - the name without a compiler-specific extension (.a/.lib) is specified.
    - `hxbase` - the name without an extension and architecture (`-v7`/`.iphonesim`) is specified.

```xml
<lib (name|hxbase|base)="libName" />
```

- `prefix` - Sets the prefix for generated files.

    - `value` - prefix. This will usually be `lib` or nothing.

```xml
<prefix value="lib"/>
```

- `ranlib` - Specifies whether `ranlib` needs to be run, and what command to use.  Usually used only for Unix-style static libraries.

```xml
<ranlib name="ranlib command"/>
```

- `libpathflag` - Sets the flag used for adding library paths to command line.  It will be combined with `lib` entries.

```xml
<libpathflag value="-L"/>
```

- `recreate` - Specifies whether to delete the target file before re-running the link command. The archive `ar` command sometimes adds object files to existing archives, so deleting first can help.

```xml
<recreate value="true"/>
```

- `expandAr` - Specifies whether to extract the individual object files from an archive and add these, rather than add the archive as a single library. Can solve some link-order and static-initialization issues, but may make the final executable bigger.

```xml
<expandAr value="true"/>
```

- `fromfile` - If the linker supports taking a list of objects in a single file, then this is flag for specifying the file.

    - `value` - flag for specifying the file. If the filename should be a separate argument, then the flag should end with a space. Usually `@` or `-filelist `. Set to empty to disable.
    - `needsQuotes` - whether to quote object names in the file.

```xml
<fromfile value="flag" needsQuotes="true" />
```

<!--label:target-cpp-build_xml-Stripper-->
##### Stripper

A stripper is used to remove debug information in release builds on `gcc`-like systems.

- `exe` - Overrides the stripper command.

```xml
<exe name="command"/>
```

- `flag` - Adds a flag to the stripper command.

```xml
<flag value="flag"/>
```

<!--label:target-cpp-build_xml-HaxeTarget-->
##### The Haxe Target

When compiling from Haxe via `hxcpp`, a `Build.xml` file is generated in the output directory. The file lists the generated files and dependencies and ultimately includes the `toolchain/haxe-target.xml` file, which describes how to combine these files.

##### Include Order

There are a few complications when setting the order in which things are configured, since a particular build might want to:

  - set the compiler
  - override some compiler settings
  - make decisions based on the compiler or settings
  - set or use standard file prefixes/suffixes

##### Example Sequence

You can see which files are included by setting the `HXCPP_VERBOSE` define when compiling. One example is for a hypothetical user 'Hugh' on a Windows platform:

```
Using makefile: Build.xml
No specified toolchain
 - Parsing include: C:/Users/Hugh/dev/hxcpp/toolchain/setup.xml
 - Parsing include: C:\Users\Hugh\.hxcpp_config.xml (section "vars")
Using Windows compiler: MSVC
 - Parsing include: C:/Users/Hugh/dev/hxcpp/toolchain/finish-setup.xml
 - Parsing makefile: C:\Users\Hugh\test\proj\cpp\Build.xml
 - Parsing include: C:/Users/Hugh/dev/hxcpp/build-tool/BuildCommon.xml
 - Parsing include: C:/Users/Hugh/dev/hxcpp/toolchain/haxe-target.xml
 - Parsing include: C:/Users/Hugh/dev/hxcpp/toolchain/msvc-toolchain.xml
 - Parsing compiler: C:/Users/Hugh/dev/hxcpp/toolchain/common-defines.xml
 - Parsing include: C:\Users\Hugh\.hxcpp_config.xml (section "exes")
```

1. `setup.xml` is read because no custom toolchain is specified, and this just includes `.hxcpp_config.xml`.
2. The `vars` section of `.hxcpp_config.xml` is read - mainly to setup SDK locations.
3. The `hxcpp` build tool then uses internal logic based on the host and defines to work out which compiler/toolchain to use. In this case, `MSVC` (Microsoft Visual Studio C++) is selected.
4. `finish-setup.xml` then sets some standard defines for file extensions and linking flags based on the type of toolchain being used.
5. The provided build file (`Build.xml`) is then processed. It can use the standard defines from `finish-setup.xml`.
6. `Build.xml` imports the standard Haxe target build files (`haxe-target.xml`), which adds the files required for the Haxe runtime.
7. The toolchain file (`msvc-toolchain.xml`) is then parsed - making use of any settings from the main `Build.xml` and `finish-setup.xml`. This file includes `common-defines.xml` inject standard Haxe compiler flags.
8. The `exes` section of `.hxcpp_config.xml` is read. Historically to add libraries or build-paths to targets.

##### Standard Environment

`finish-setup.xml` is where the conventions are set. These variables include:

- `haxelink` - `dll`, `static_link`, or `exe`
- `LIBPREFIX` - `lib` or empty
- `LIBEXTRA`:

    - `.iphonesim-64`
    - `.iphonesim`
    - `.iphoneos`
    - `.iphoneos-v7`
    - `.iphoneos-v7s`
    - `.iphoneos-64`
    - `.appletvsim-64`
    - `.appletvsim`
    - `.watchos`
    - `.watchsimulator`
    - `-x86`
    - `-v7`
    - `-64`

- `HX_LINK_SUFFIX` - `LIBEXTRA`, `-19` (MSVC 19)
- `LIBEXT` - `.a`, `.lib`
- `DBG` - `-debug` or empty
- `OBJEXT` - `-list-of-config-ids` depending on available options

These variables are used by `haxe-target.xml` - you can use them too. Haxe then builds the `haxe` target, which uses some code like:

```xml
  <set name="HAXE_OUTPUT_FILE" value="${LIBPREFIX}${HAXE_OUTPUT_PART}${DBG}" />

  <target id="haxe" tool="linker" toolid="${haxelink}" output="${HAXE_OUTPUT_FILE}">
    <ext value="${LIBEXTRA}.a" if="static_link" />
    <!-- ... -->
    <files id="__main__" unless="static_link" />
    <files id="__lib__" if="static_link"/>
    <files id="__resources__" />
    <files id="__externs__" />
    <files id="runtime" unless="dll_import" />
    <files id="cppia" if="scriptable" />
    <lib name="-lpthread" if="linux" unless="static_link" />
    <lib name="-ldl" if="linux" unless="static_link" />
  </target>
```

Here you can see the various file groups, which are enabled or disabled depending on the compiler mode, and some standard libraries that are needed for Linux.

##### Experimenting with `hxcpp`-generated code/`Build.xml`

If you are using external C++ code or using metadata to inject XML into the build process, and you are getting a compiler or linker error, then it can be useful to run the `hxcpp` build tool without re-running Haxe. This lets you manually edit the build file or generated C++ code until you get things to work. Once you have solved the issues using this technique, then you can move the changes back into the injected/external code.

First, invoke the Haxe compiler with the `-v` flag. This gives quite a bit of debug info, but will include a line like this:

```
haxelib run hxcpp Build.xml haxe -Dhaxe3="1" -Dhaxe_ver="4.000" -Dhxcpp_api_level="332" -Dsource-header="Generated by Haxe 4.0.0" -I"" -I"C:/Users/Hugh/dev/haxe/std/cpp/_std/" -I"C:/Users/Hugh/dev/haxe/std/"
```

To use this, first change directories to your output directory. This is the directory specified in the `--cpp` Haxe compiler option. Then copy and paste the `haxelib run ...` command into a shell, command or batch file.

<!--label:target-cpp-build_xml-XmlInjection-->
##### Xml Injection

When using external code in `hxcpp`, it is often useful to add libraries, include paths or compiler flags to the build process. This can be done with the `@:buildXml` class metadata. E.g.:

```haxe
@:buildXml("
<target id='haxe'>
  <lib name='${haxelib:nme}/lib/${BINDIR}/libnme${LIBEXTRA}${LIBEXT}'/>
</target>
")
@:keep
class StaticNme { ... }
```

By referencing the given class (by simply `import`-ing it, no need to use it properly because it has the `@:keep` metadata), the XML fragment is also included.

Here, the XML fragment is copied verbatim into the generated `Build.xml` immediately after the standard file lists. This example adds a library to the haxe target, but you could also add flags to `files` nodes, or files to another `files` node or target. Another possibility is to add an `include` command to pull in a whole external XML file. This can help avoid some syntax awkwardness needed when quoting strings in metadata, and allows a normal XML editor to be used.

It is also possible to replace the `__main__` file group to skip the standard initialization code and use a custom bootstrap procedure.

<!--label:target-cpp-defines-->
#### Defines

There are a number of standard defines you can use to control the `hxcpp` build. Some of these are used by the Haxe compiler, and affect the generated code. Others apply to the build tool and affect how the code is compiled.

##### Code generation

Defines affecting how the code is generated. These need to be in the command line when calling haxe.

| Define                  | Meaning            |
|-------------------------|--------------------|
| `HXCPP_DEBUGGER`        | Add extra macros required by debugger. Usually added automatically by the debugger haxelib. |
| `HXCPP_GC_GENERATIONAL` | Enable experimental generational garbage collector. |
| `annotate_source`       | Add additional annotations to the generated source code - useful for developing `hxcpp`. |
| `dll_export`            | Export `hxcpp` runtime symbols. |
| `file_extension`        | Set the extension (without the dot) of generated files. E.g. `-D file_extension=mm` for Objective-C++ code. |
| `force_native_property` | Make dynamic access to fields call property getters/setters where appropriate. |
| `include_prefix`        | Place all generated include files in a sub-directory, e.g. `-D include_prefix=hxinc`. Useful for avoiding name clashes. |
| `no-compilation`        | Generate code, but do not compile it. |
| `no-debug`              | Do not generate debug macros in code |
| `nocppiaast`            | Use legacy `cppia` generation instead of new, more recent changes. |
| `objc`                  | Generate Objective-C++ classes. |
| `scriptable`            | Enable extra runtime information required for scripting. |

##### Compilation

Defines affecting how the code is compiled. These can be on the command line when calling haxe, or added via the `hxcpp` build environment.

| Define                  | Meaning            |
|-------------------------|--------------------|
| `HXCPP_GC_MOVING`       | Allow garbage collector to move memory to reduce fragmentation. |
| `HXCPP_GC_SUMMARY`      | Print small profiling summary when the program exits. |
| `HXCPP_GC_DYNAMIC_SIZE` | Monitor GC times and expand memory working space if required. |
| `HXCPP_GC_BIG_BLOCKS`   | Allow working memory greater than 1 gigabyte. |
| `HXCPP_GC_DEBUG_LEVEL`  | Specify a level (`1-4`) indicating additional debugging in GC. |
| `HXCPP_DEBUG_LINK`      | Add symbols to final binary, even in release mode. |
| `HXCPP_STACK_TRACE`     | Have valid function-level stack traces, even in release mode. |
| `HXCPP_STACK_LINE`      | Include line information in stack traces, even in release mode. |
| `HXCPP_CHECK_POINTER`   | Add null-pointer checks, even in release mode. |
| `HXCPP_PROFILER`        | Add profiler support. |
| `HXCPP_TELEMETRY`       | Add telemetry support. |
| `HXCPP_CPP11`           | Use C++11 features and link libraries. |
| `exe_link`              | Generate executable file (rather than dynamic library on Android). |
| `static_link`           | Generate static library. |
| `dll_link`              | Generate dynamic library. |

##### Other

| Define                  | Meaning            |
|-------------------------|--------------------|
| `HXCPP_VERBOSE`         | Print extra output from build tool. |
| `HXCPP_TIMES`           | Show some basic profiling information. |
| `HXCPP_NEKO_BUILDTOOL`  | Force use of `hxcpp.n`, rather than the compiled `BuildTool.exe`. |
| `HXCPP_NO_COLOR`        | Do not add color-codes to build tool output. |
| `HXCPP_KEEP_TEMP`       | Do not delete the files created for file `embedName` option. |

##### Target architecture

| Define              | Meaning            |
|---------------------|--------------------|
| `HXCPP_M32`         | Force 32-bit compile for current desktop. |
| `HXCPP_M64`         | Force 64-bit compile for current desktop. |
| `HXCPP_ARMV6`       | Compile ARM-based devices for `armv6`. |
| `HXCPP_ARM64`       | Compile ARM-based devices for 64 bits. |
| `HXCPP_ARMV7`       | Compile ARM-based devices for `armv7`. |
| `HXCPP_ARMV7S`      | Compile ARM-based devices for `armv7s`. |
| `HXCPP_LINUX_ARMV7` | Compile for a Linux ARMv7 device. |
| `HXCPP_LINUX_ARM64` | Compile for a Linux ARM64 device. |
| `winrt`             | Compile for windowsRt/windows UWP. |
| `android`           | Compile for Android. |
| `PLATFORM`          | Specify the Android platform for NDK compilation. |
| `ANDROID_NDK_ROOT`  | Specify the location of the Android NDK toolchain. |
| `ANDROID_NDK_DIR`   | Specify the search location for finding the android NDK toolchain. |
| `HXCPP_X86`         | Compile android for x86 architecture. |
| `iphoneos`          | Compile for iPhone iOS. |
| `iphonesim`         | Compile for iPhone simulator. |
| `appletvos`         | Compile for Apple tvOS. |
| `appletvsim`        | Compile for Apple tvOS simulator. |
| `watchos`           | Compile for Apple watchOS. |
| `watchsimulator`    | Compile for Apple watchOS simulator. |
| `webos`             | Compile for webOS. |
| `tizen`             | Compile for Tizen. |
| `blackberry`        | Compile for Blackberry- |
| `emscripten`        | Compile for Emscripten. |
| `cygwin`            | Compile for Windows using Cygwin. |
| `linux`             | (Cross) Compile for Linux. |
| `rpi`               | (Cross) Compile for Raspberry Pi. |
| `mingw`             | Compile for Windows using MinGW. |
| `HXCPP_MINGW`       | Compile for Windows using MinGW. |
| `NO_AUTO_MSVC`      | Do not detect MSVC location, use the one already in the executable path. |

<!--label:target-cpp-CompileCache-->
#### The Hxcpp Cache

The `hxcpp` compile cache is used to share object files between projects. This can alleviate the need to ship static libraries with external projects, since developers who use the library can compile the library just once, and then reuse it between projects.

The cache uses a hashing mechanism to tell if the contents of a file or its dependencies have changed, and combines this with the compiler version and flags to make specific object files for each change and each compiler configuration. This also allows some common Haxe runtime and Haxe-generated files to share their object files between projects, even if in different directories.

Additional benefits include keeping some files outside the source tree, and being able to remove these temporary files easily.

##### Setup

A directory needs to be set aside to enable the cache. If possible, this should be on fast storage, such as an SSD. This is most easily done with an entry in the `.hxcpp_config.xml` file:

```xml
<set name="HXCPP_COMPILE_CACHE" value="c:/hxcpp/cache" />
<set name="HXCPP_CACHE_MB" value="4000" />
```

Keeping the path short can help in some border-line cases with some compilers where command-line length can become an issue.

The cache size defaults to 1 gigabyte. For many cases, this is big enough. However, on large projects, with several architectures and a lot of debug information, this default can lead to "cache churn" where some files are evicted from the cache, even though they are likely to be used again.  Increasing the number of space allocated to the cache can help.

##### Using The Cache

To use the cache with your own libraries, the files group should have a `cache` entry to tell `hxcpp` that you have considered dependency issues when designing the group.

```xml
<cache value="true" project="name" asLibrary="true" />
```

See [Files - `cache`](target-cpp-build_xml-Files) for more details.

##### Management

When compiling normally, `hxcpp` will check the cache size and evict the least used files to maintain the specified cache size. Object files in the cache are grouped into "projects" to make management easier, and the `hxcpp` build tool can be used to explicitly manage the object files.

```
haxelib run hxcpp cache [command] [project]
  Perform command on cache, either on specific project or all. commands:
   clear -- remove all files from cache
   days #days -- remove files older than "days"
   resize #megabytes -- Only keep #megabytes MB
   list -- list cache usage
   details -- list cache usage, per file
```

Start with:

```
haxelib run hxcpp cache list
```

To get an idea of cache usage.


<!--label:target-cpp-ThreadsAndStacks-->
#### Threads And Stacks

##### Conservative, co-operation

`hxcpp` uses a conservative stop-the-world GC, where the threads need to co-operate.

 - Threads must not change GC pointers in the collection phase.
 - The thread stacks/registers must be scanned for GC pointers.
 - Threads must not block without letting the GC system know not to wait for them, otherwise GC blocks until the end of block.
   - Call `hx::GCEnterBlocking()` / `gc_enter_blocking()` / `cpp.vm.Gc.enterGCFreeZone()` from Haxe before a potentially blocking system call (filesystem, network, etc).
   - Call `hx::GCExitBlocking()` / `gc_exit_blocking()` / `cpp.vm.Gc.exitGCFreeZone()` from Haxe before making more GC calls.
   - Might need to pre-allocate buffers.
   - Don't forget to exit blocking on error conditions.

##### Foreign Threads

When you create a thread from Haxe, it starts attached. Before a non-Haxe created thread can interact with `hxcpp`, some care must be taken, since GC allocations are done using a GC context per thread, and all threads must respect the stopped world.

  - Foreign threads must be attached-detached
     - `SetTopOfStack(int * inTop,bool inPush)`
     - `inTop` - pointer to top of stack to attach, or `0` to remove stack.
     - `inPush` - usually `true`. Recursive attachment/detachment.
  - Must not change things when the world is stopped.
  - Must define their stack range for scanning.
  - If you are attached, you may need to enter/exit GC-free zone.
  - Must release context when done, if no more calls are going to be made.
  - Make sure local variables are covered in the stack.
    - Compiler may reorder, so be careful.
  - Read documentation because some things, e.g. audio callbacks, happen on other threads.
  - You can use other techniques, e.g.:
     - Create a Haxe thread, which blocks waiting for a signal.
     - Foreign thread generates request and signals Haxe thread.
     - Haxe thread performs job and generates data then signals foreign thread.
     - Foreign thread picks up data and carries on.

##### Top of Stack

 - To understand how to handle threads, you need a mental picture of the C++ stack.
 - The stack usually grows "down". That is, if the first stack location is 10000, the next one will be 9999 etc.
 - Historical, but consistent. Except for `emscripten` which goes up - but still use same terminology/picture, just change the less-thans to greater-thans in code.

Say the system starts each program stack at 10000, the stack might look like this, with local variables and arguments pushed on the stack:

```
 10000
 -----------------------------------------------
 9996  startup temp variable
 9992  startup temp variable
       -- main function --
 9988  main return address    - order and details of this are ABI specific
 9984  char ** argv
 9980  int     argc
```

`hxcpp` then runs the main code, which starts with the macro `HX_TOP_OF_STACK`, which expands to something like:

```
   int t0 = 99;
   hx::SetTopOfStack(&t0,false);
   ...
   __boot_all();
   __hxcpp_main();

       -- main function --
 9988  main return address      order and details of this are ABI specific
 9984  char ** argv
 9980  int     argc
 9976  int     t0
       -- hx::SetTopOfStack --

    records '9976' as top of stack for this thread
```

Later, many generated functions deep, `__hxcpp_main` generates an allocation call which triggers a collection.

```
 ...
 8100  Array<Bullet>   bullets
       -- alloc Enemy --
 ...
       -- Call collect --

 8050 int   bottomOfStackTemp
      MarkConservative(&bottomOfStackTemp, 9976) -> scans stack from 8050 -> 9976
      MarkConservative(Capture registers)

```

Enter/exit use a similar technique, where the registers are captured and the `bottomOfStack` is 'locked-in' when the "enter GC-free zone" call is made.

```
 8100  Array<Bullet>   bullets
       -- EnterGCFreeZone --
 8088 int   bottomOfStackTemp
      thread->setBottomOfStack(&bottomOfStackTemp)
      thread->captureRegisters()
      return
      * any changes here will not affect GC
```

Now, when another thread performs a collection, the GC-free thread can be scanned from 8088 to 9976, regardless of any stuff happening lower down the stack.

##### Not Called From Main

Top of stack can be tricky to get right when a GUI framework does not really have a "main".

```
 10000
 -----------------------------------------------
 9996  startup temp variable
 9992  startup temp variable
       -- main function --
       setupWindows(onReadyCallback)......
          ...
 8000
       -- onReadyCallback --
 7976  int     t0
       SetTopOfStack(&t0,false) -> 7966
       __hxcpp_main();
          setOnFrameCallack(haxeOnFrame)
          return;
```

Later, the `haxeOnFrame` callback is triggered, but not "below" `__hxcpp_main`

```
 9800  -- haxeOnFrame ---
     // Top of stack will be below bottom of stack.
```

Solutions:

  - Make sure you get in at top of main
    - may scan too much?
  - Ratchet up top-of-stack in callbacks, `inForce = false`
    - `gc_set_top_of_stack(void * inTopOfStack,bool inForce);`
  - Detach main thread after `hxcpp_main` and reattach each callback
    - Android solution because render callbacks happen on different threads
    - `gc_set_top_of_stack(&base,true);` - attach
    - `gc_set_top_of_stack(0,true);` - detach

##### Debugging.

  - In debug mode, `hxcpp` will check for calls from unattached threads.
  - `hxcpp` can log conservative ranges. With a native debugger you can check the address of your local variables and ensure they are included.
  - `hxcpp` will scan native objects on the stack, but will not follow non-Haxe pointers to other objects, so additional GC roots may be required.

<!--label:target-cpp-ErrorCodes-->
#### Error Codes

<!--subtoc-->

<!--label:target-cpp-ErrorCodes-CPP0000-->
##### CPP0000 - Internal Error

###### Description

This error usually indicates a compiler bug, if you produce this error please open an issue with the code which causes it.

<!--label:target-cpp-ErrorCodes-CPP0001-->
##### CPP0001 - Missing Value Semantics

###### Description

Native marshalling types must be annotated with value semantics to ensure the generated code is sound. Classes or enums annotated with `:cpp.ValueType` or `:cpp.PointerType` but without `:semantics(value)` will generate this error.

###### Examples

The following examples generate CPP0001.

```haxe
// CPP0001
@:cpp.ValueType
extern class Foo {
    function new():Void;
}

function main() {
    final f = new Foo();
}
```

```haxe
// CPP0001
@:cpp.ValueType
extern enum abstract Foo(Int) {
    var Bar;
    var Baz;
}

function main() {
    final f = Foo.Bar;
}
```

```haxe
// CPP0001
@:cpp.PointerType
extern class Foo {}

function main() {
    final f : Foo = null;
}
```

<!--label:target-cpp-ErrorCodes-CPP0002-->
##### CPP0002 - Native Marshalling Types and Function Closures

###### Description

Member functions of extern classes annotated with `:cpp.ValueType` or `:cpp.PointerType` can only be directly invoked, attempting to create closures from these member functions will generate this error.

###### Examples

The following examples generate CPP0002.

```haxe
@:semantics(value)
@:cpp.ValueType
extern class Foo {
    function new():Void;

    function bar():Void;
}

function main() {
    final f = new Foo();
    final c = f.bar; // CPP0002

    c();
}
```

```haxe
@:semantics(value)
@:cpp.PointerType
extern class Foo {
    static function allocate():Foo;
    function bar():Void;
}

function main() {
    final f = Foo.allocate();
    final c = f.bar; // CPP0002

    c();
}
```

<!--label:target-cpp-ErrorCodes-CPP0003-->
##### CPP0003 - Invalid Marshalling Type Parameter

###### Description

Extern types annotated with `:cpp.ValueType` or `:cpp.PointerType` cannot use GC objects as type parameters, attempting to do so will generate this error.

###### Examples

The following example generates CPPP0003.

```haxe
// CPP0003
@:semantics(value)
@:cpp.ValueType
extern class Foo<T> {
    function new():Void;
}

function main() {
    final f = new Foo<String>();
}
```

<!--label:target-cpp-ErrorCodes-CPP0004-->
##### CPP0004 - Pointer Constructors

###### Description

Extern classes annotated with `cpp.PointerType` cannot have constructors, adding a constructor to these classes will generate this error.

###### Examples

The following example generates CPP0004.

```haxe
@:semantics(value)
@:cpp.PointerType
extern class Foo {
    function new():Void; // CPP0004
}

function main() {
    final f = new Foo();
}
```

<!--label:target-cpp-ErrorCodes-CPP0005-->
##### CPP0005 - Undeclared Marshalling Value Type Variable

###### Description

Extern classes and enums annotated with `cpp.ValueType` can live on the stack and are considered not nullable, to support undeclared local variables this would necessitate the underlying native type to have a default constructor which is might not have. Due to this, undeclared local variables of marshalling value types are not supported, doing so generates this error.

###### Examples

The following example generates CPP0005.

```haxe
@:semantics(value)
@:cpp.ValueType
extern class Foo {
    function new():Void;
}

function main() {
    var f : Foo; // CPP0005

    if (Math.random() > 0.5) {
        f = new Foo();
    }
}
```

<!--label:target-cpp-ErrorCodes-CPP0006-->
##### CPP0006 - Invalid Namespace Field

###### Description

The namespace field in the marshalling type annotation must be an array of string literals, providing anything else will result in this error.

###### Examples

The following examples generate CPP0006.

```haxe
@:semantics(value)
@:cpp.ValueType({ namespace : 'foo' }) // CPP0006
extern class Bar {
    function new():Void;
}

function main() {
    final b = new Bar();
}
```

```haxe
@:semantics(value)
@:cpp.ValueType({ namespace : [ Foo ] }) // CPP0006
extern class Bar {
    function new():Void;
}

function main() {
    final b = new Bar();
}
```

```haxe
@:semantics(value)
@:cpp.ValueType({ namespace : [ 'foo', 12 ] }) // CPP0006
extern class Bar {
    function new():Void;
}

function main() {
    final b = new Bar();
}
```

<!--label:target-cpp-ErrorCodes-CPP0007-->
##### CPP0007 - Invalid Type Field

###### Description

The type field in the marshalling type annotation must be a string literal, providing anything else will result in this error.

###### Examples

The following examples generate CPP0007.

```haxe
@:semantics(value)
@:cpp.ValueType({ type : Foo }) // CPP0007
extern class Bar {
    function new():Void;
}

function main() {
    final b = new Bar();
}
```

```haxe
@:semantics(value)
@:cpp.ValueType({ type : 12 }) // CPP0007
extern class Bar {
    function new():Void;
}

function main() {
    final b = new Bar();
}
```

<!--label:target-cpp-ErrorCodes-CPP0008-->
##### CPP0008 - Invalid Flags Field

###### Description

The flags field in the marshalling type annotation must be an array of identifiers, providing anything else will result in this error.

###### Examples

The following examples generate CPP0008.

```haxe
@:semantics(value)
@:cpp.ValueType({ flags : StackOnly })
extern class Foo {
    function new():Void;
}

function main() {
    final f = new Foo();
}
```

```haxe
@:semantics(value)
@:cpp.ValueType({ flags : [ 'StackOnly' ] })
extern class Foo {
    function new():Void;
}

function main() {
    final f = new Foo();
}
```

<!--label:target-cpp-ErrorCodes-CPP0009-->
##### CPP0009 - Extending Managed Type

###### Description

Extern classes annotated with `cpp.ManagedType` cannot currently be extended by non extern classes due to differences in how super constructors can be called in Haxe and C++. Attempting to subclass one of these extern classes with a non-extern class will generate this error.

###### Examples

The following example generates CPP0009.

```haxe
@:semantics(value)
@:cpp.ManagedType
extern class Foo {}

class Bar extends Foo {
    public function new() {}
}

function main() {
    final b = new Bar();
}
```

<!--label:target-cpp-ErrorCodes-CPP0010-->
##### CPP0010 - Unable to Resolve Type Parameter

###### Description

Type parameters in normal haxe objects use type erasure, but type parameters in native marshalling types represent C++ template parameters. Due to this difference a type parameter needs to be resolvable to it's concrete type, if Haxe is unable to do this, this error is generated.

To resolve this issue you should explicitly add a type hint or type check which will allow Haxe to resolve the parameter.

###### Examples

The following example generates CPP0010.

```haxe
@:semantics(value)
@:cpp.ValueType
extern class Foo {
    function new():Void;
    function bar<T>():T;
}

function main() {
    final f = new Foo();

    trace(f.bar()); // CPP0010
}
```

Since `trace` accepts `Dynamic` as it's first argument there is nothing for Haxe's type inference to unify `T` against which results in this error. the following two examples are ways you can resolve this error.

```haxe
@:semantics(value)
@:cpp.ValueType
extern class Foo {
    function new():Void;
    function bar<T>():T;
}

function main() {
    final f = new Foo();

    trace((f.bar() : Int)); // Type check to allow Haxe to resolve T with Int.
}
```

```haxe
@:semantics(value)
@:cpp.ValueType
extern class Foo {
    function new():Void;
    function bar<T>():T;
}

function main() {
    final f = new Foo();
    final v : Int = f.bar(); // Variable with type hint to allow Haxe to resolve T with Int.

    trace(v);
}
```

<!--label:target-cpp-ErrorCodes-CPP0011-->
##### CPP0011 - Promoted Stack Only Value Type

###### Description

Extern classes or enums annotated with `cpp.ValueType` and which contain the `StackOnly` flag are forbidden from being promoted to the heap. There are many ways a type can be silently promoted to the heap, the following examples show a few such cases.

###### Examples

The following examples generate CPP0011.

```haxe
@:semantics(value)
@:cpp.ValueType({ flags : [ StackOnly ] })
extern class Foo {
    function new():Void;
}

function main() {
    final f : Null<Foo> = new Foo(); // CPP0011, nullable value types are required to go on the heap.
}
```

```haxe
@:semantics(value)
@:cpp.ValueType({ flags : [ StackOnly ] })
extern class Foo {
    function new():Void;
}

function main() {
    final f = new Foo(); // CPP0011, variables captured in a closure are required to go on the heap.
    final c = () -> {
        trace(f);
    }

    c();
}
```

```haxe
@:semantics(value)
@:cpp.ValueType({ flags : [ StackOnly ] })
extern class Foo {
    function new():Void;
}

function bar(o:Dynamic) {
    trace(o);
}

function main() {
    final f = new Foo(); // CPP0011, converting a value type to Dynamic requires boxing it onto the heap.
    
    bar(f);
}
```

```haxe
@:semantics(value)
@:cpp.ValueType({ flags : [ StackOnly ] })
extern class Foo {
    function new():Void;
}

class Bar {
    var f : Foo; // CPP0011, class fields of value types are required to be on the heap.

    public function new() {
        f = new Foo();
    }
}

function main() {
    final f = new Bar();
}
```

<!--label:target-cppia-->
### Cppia

<!--subtoc-->

<!--label:target-cppia-getting-started-->
#### Getting started with Haxe/Cppia

Cppia is a scriptable cpp subtarget for Haxe. A cppia script is an instructions assembly script that can be run inside a cppia host and gives you runtime speed at near-zero compilation time. It also lets you add performance critical code to the host, which gives you full cpp runtime speed for those parts.

##### More information

* [Cppia API documentation](https://api.haxe.org/cpp/cppia/index.html)
* [Cppia tutorial](https://code.haxe.org/category/other/working-with-cppia/index.html)





<!--label:target-java-->
### Java

<!--subtoc-->

<!--label:target-java-getting-started-->
#### Getting started with Haxe/Java

To get started with Haxe/Java, create a new folder and save this class as `Main.hx`.

[code asset](assets/HelloWorld.hx)

To compile Haxe to Java we need two obvious prerequisites installed:

* [hxjava haxelib](https://lib.haxe.org/p/hxjava). This is the support library for the Java backend of the Haxe compiler.
* [JRE - Java Runtime Environment](https://java.com/download/).

Run the following from the command line:

```hxml
haxe --java bin --main Main
```

Another possibility is to create and run (double-click) a file called `compile.hxml`. In this example the hxml-file should be in the same directory as the example class.

```hxml
--java bin
--main Main
```

The compiler outputs in the given **bin**-folder, which contains the generated sources / .jar files which prints the traced message when you execute it.

To execute, run the following command:

```sh
java -jar bin/Main.jar
```

##### More information

* [Haxe/Java API docs](https://api.haxe.org/java/)
* [Java Platform Documentation](https://docs.oracle.com/javase/)




<!--label:target-jvm-->
### JVM

<!--subtoc-->

<!--label:target-jvm-getting-started-->
#### Getting started with Haxe/JVM

To get started with Haxe/JVM, create a new folder and save this class as `Main.hx`.

[code asset](assets/HelloWorld.hx)

To compile Haxe to JVM bytecode, you'll first need to install the [hxjava haxelib](https://lib.haxe.org/p/hxjava). This is the Haxe Java support library, including build scripts and support code. Then run the following from the command line:

```sh
haxe --jvm bin/Main.jar --main Main
```

To save yourself some typing, you may create a `.hxml` file (say, `jvm.hxml`) in your project's top-level directory, containing:

```hxml
--jvm bin/Main.jar
--main Main
```

and run it with the `haxe` command:

```sh
haxe jvm.hxml
```

to produce the bin/Main.jar file.

To execute the jar file, you'll need to have a JRE (Java Runtime Environment) installed, such as [OpenJDK](https://openjdk.java.net/) or a commercially-supported JRE. Then run the jar file using the following command:

```sh
java -jar bin/Main.jar
```


##### More information

* [Haxe/Java API docs](https://api.haxe.org/java/)
* [Java Platform Documentation](https://docs.oracle.com/javase/)





<!--label:target-cs-->
### C#

<!--subtoc-->

<!--label:target-cs-getting-started-->
#### Getting started with Haxe/C#

Haxe can be used as a language for .NET platform through its C# target. Let's make a basic program using .NET Console class:

[code asset](assets/HelloWorld.hx)

To compile Haxe to C# we need two obvious prerequisites installed:

* [hxcs haxelib](https://lib.haxe.org/p/hxcs). This is the support library for the C# backend of the Haxe compiler.
* [.NET development framework (either Microsoft.NET or Mono)](https://www.microsoft.com/net)

After that we can compile to C# using the `--cs` option from either the command line or an hxml-file:

```hxml
haxe --cs out --main Main
```

The compiler will output C# sources into  **out/src** folder, then call C# compiler to build  **Main.exe** file into  **out/bin** folder.

##### More information

* [Haxe/C# API docs](https://api.haxe.org/cs/)
* [C# Documentation](https://msdn.microsoft.com/en-us/library/kx37x362.aspx)



<!--label:target-cs-external-libraries-->
#### .NET version and external libraries

By default, Haxe uses basic .NET 2.0 API provided by hxcs library (it ships mscorlib.dll and System.dll from the Mono project). We can specify different .NET version by providing `-D net-ver=xx` define, where xx is major and minor digits of .NET version number, i.e. `-D net-ver=40` for setting .NET version to 4.0. Note that currently, hxcs library only ships DLL files for .NET 2.0 and 4.0.

##### Using custom .NET distribution

We can make Haxe use a custom set of DLL files as standard .NET framework. To do that, we need to first learn about how Haxe finds standard .NET libraries. Haxe/C# looks for .DLL files in a directory path, constructed from three components:

* .NET version (set by `-D net-ver=xx`, defaults to `20` as described above)
* .NET target (by default set to `net`, but could be changed using `-D net-target=xxx`, where `xxx` could be `micro`, `compact` or some other).
* .NET std path (set by `--net-std` option, by default points to netlib directory inside hxcs library)

The resulting search path will be `<net_std_path>/<net_target>-<net_ver>/`, taking in the consideration default values described above, without any specific configuration haxe will load all .NET DLL files found in `<hxcs_install_path>/netlib/net-20/`.

Now if we provide the following options:

```hxml
-D net-target=micro -D net-ver=35 --net-std=/dotnet
```

Haxe will load all .NET DLL files found in `/dotnet/micro-35/`.

##### Using external libraries

Haxe can directly load .NET assembly files (.DLL) and convert its type definitions for use as Haxe types. To load a .NET assembly, use `--net-lib library.dll` compiler option. Haxe will then automatically parse types defined in that assembly file and make them available for import as Haxe types.

Some changes are performed to type naming of C# classes to make them fit into Haxe type system, namely:

* Namespaces are lowercased to follow Haxe package naming rules, so i.e. `UnityEngine` becomes `unityengine` (note that `System` namespace is also prefixed with `cs`, so  `System.Core` becomes  `cs.system.core`)
* Inner classes are generated as `OuterClassName_InnerClassName` and placed into the `OuterClassName` module. So for example for an inner class `B` inside a class `A` inside a namespace `Something`, the full Haxe type path will be `something.A.A_B`. Note however, that if you do `import something.A`, both `A` and `A_B` class will be available within your module as per standard Haxe import mechanism.
* Classes with type parameters have numbers of type params appended to their name, for example `Dictionary<K,V>` becomes `Dictionary_2<K,V>`



<!--label:target-cs-defines-->
#### Haxe/C# Defines

Besides `-D net-ver` and `-D net-target`:

* `-D dll` compile to a .NET assembly instead of an executable file. Added automatically when no `--main` is specified.
* `-D real-position` don't generate #line directives that map C# expression positions to original .hx files. Useful for tracking down issues related to code generation.
* `-D no-root` generate package-less haxe types in the haxe.root namespace to avoid conflicts with other types in the root namespace
* `-D erase-generics` fully erase type parameters from generated C# files and generate non-generic classes. This is useful in some cases, like working with .NET Micro Framework or preventing generics-related issues with Unity3D AOT compiler.
* `-D no-compilation` only generate C# sources and don't invoke C# compiler on them.
* `-D keep-old-output` by default haxe cleans up stale generated source files from the output directory. This define disables that behaviour.
* `-D dll-import`

Haxe automatically adds `NET_xx` defines where xx is major and minor version numbers .NET versions up to selected one. For example, when using .NET 4.0 (by providing `-D net-ver=40`), we have the following defines set automatically: `NET_20`, `NET_21`, `NET_30`, ` NET_35` and `NET_40`. If we had `-D net-ver=30`, we would only have `NET_20`, `NET_21` and `NET_30`.



<!--label:target-cs-metadata-->
#### Haxe/C# Metadata

This is the list of C# specific metadata. For more information, see also the complete list of all [Haxe built-in metadata](cr-metadata).

Metadata | Usage | Description
 --- | --- | ---
@:nativeGen  |  on classes | don't generate reflection, generate proper type parameters. This is useful for some sort of interop, but slows down reflection and structural typing
@:nativeGen  |  on "flat" enums | generate C# enum, but note that C# enums are not-nullable unlike haxe enums, so using null will be generated as a default enum value (0-indexed constructor).
@:property  |  on non-physical fields (those with get/set/never accessors) | generate native C# properties. useful for implementing extern interfaces or providing API for use from C#
@:event  |  on variables | generate an event delegate (this also requires pairing add_EventName, remove_EventName methods with relevant signatures
@:protected  |  on a field | mark field as protected instead of public (could affect reflection, but useful for hiding fields when providing API for use from outside Haxe)
@:struct  |  on classes  |  generate struct instead of class



<!--label:target-cs-code-injection-->
#### Injecting raw C# code

##### Class code injection

TODO: @:classCode

##### Function code injection

We can use `@:functionCode` metadata for a method to generate raw C# code inside a method body. It completely replaces any haxe expressions in method body. For example:

```haxe
@:functionCode("return (v is int);")
function isInt(v:Dynamic):Bool {
    return false;
}
```

Which will generate:

```haxe
public virtual bool isInt(object v) {
    return (v is int);
}
```



<!--label:target-python-->
### Python

Haxe supports compilation to Python 3.3+ code.

<!--subtoc-->

<!--label:target-python-getting-started-->
#### Getting started with Haxe/Python

To get started with Haxe/Python, create a new folder and save this class as `Main.hx`.

[code asset](assets/HelloWorld.hx)

To compile, either run the following from the command line:

```hxml
haxe --python hello.py --main Main
```

Another possibility is to create and run (double-click) a file called `compile.hxml`. In this example the hxml file should be in the same directory as the example class.

```hxml
--python hello.py
--main Main
```

The compiler outputs a file called `hello.py` in the current folder, which can be executed with `python hello.py` (or `python3 hello.py` in case Python 2 is the default on the system) from the command line.

<!--label:target-lua-->
### Lua

<!--subtoc-->

<!--label:target-lua-getting-started-->
#### Getting started with Haxe/Lua

To get started with Haxe for Lua, it's necessary to pick a Lua version and install
dependencies.  All versions of Lua are supported, but may require different
libraries.  Lua 5.1, 5.2, 5.3, and LuaJIT 2.0 and 2.1 (beta) are supported.

Lua is a very lightweight language that ships with a much smaller  feature set
than Haxe.  In some cases (e.g. regex), it's necessary to install supplementary
libraries that are used to support basic Haxe functionality.

In order to cover all dependencies, it is recommended to install and use
[LuaRocks](https://github.com/luarocks/luarocks/wiki/Download).  However,
if you do not utilize relevant behavior (e.g. regex) on a given platform,
or if you are using an embedded Lua client, then it is not necessary to
install any packages for basic language functionality.

With LuaRocks, install the following packages:

```sh
luarocks install lrexlib-pcre2
luarocks install luasocket
luarocks install luasec
luarocks install luv
luarocks install luautf8
luarocks install hx-lua-simdjson
```

On Lua 5.1 or Lua 5.4+, install the bit32 library:
```sh
luarocks install bit32
```

When developing for multiple Lua versions, it is recommended to use
the Python package [hererocks](https://github.com/mpeterv/hererocks).

With Lua installed, it is possible to write a simple command line application.

Create a new folder, and save this class as `Main.hx`.

```haxe
class Main {
    static function main() {
        trace("hello world");
    }
}
```

To compile, run the following:
```hxml
haxe --lua out.lua --main Main
```

##### More information

* [Lua Homepage](https://www.lua.org/)
* [LuaJIT Homepage](https://luajit.org/)



<!--label:target-lua-external-libraries-->
#### Using external Lua libraries

The [extern functionality](lf-externs) in Haxe provides a way of declaring type signatures
for native Lua libraries.



<!--label:target-lua-flags-->
#### Version flags

The Lua target enables the following define flags for the Haxe complier:

* `-D lua-ver` Enable special features for a specific Lua version. Currently, this flag will enable extern methods that are specific to certain versions (e.g. table.pack in Lua > 5.2).
* `-D luajit` Enable special features for LuaJIT.  Currently this flag will enable the `jit` and `ffi` module namespaces.
* `-D lua-vanilla` Generate code lacking some functionality (e.g. UTF-8) but with no additional library dependencies.



<!--label:target-lua-multireturns-->
#### Multireturns

Lua allows for multiple values to be returned from a given function.  Haxe
does not support this by default, but can allow extern definitions to reference
multireturn values through the `@:multiReturn` metadata.

```haxe
class Main {
    static function main() {
        var strfind = NativeString.find("foobar", "bar");
        trace(strfind.begin);
        trace(strfind.end);
    }
}

@:native("string")
extern class NativeString {
	public static function find(str : String, target : String): StringFind;
}

@:multiReturn extern class StringFind {
	var begin : Int;
	var end : Int;
}
```

This example has three parts:

* The extern class `NativeString` which is an extern for the base `string` library in Lua.
* The `StringFind` class which is marked as `@:multiReturn` that describes the return values.
* The Main class that invokes the string method as a basic example.

The multireturn behavior in Haxe is optimized based on usage.  If fields are
only accessed directly, the Haxe compiler will allocate the multireturn to
individual variables.  But, if you pass or assign the entire multireturn value,
the compiler will wrap all values into a table object.  This operation ensures
that multireturn variable handling only carries as much overhead as needed.



<!--label:target-hl-->
### HashLink

##### since Haxe 3.4.0

Haxe supports compilation to HashLink bytecode or HashLink/C code. [HashLink](https://hashlink.haxe.org/) is a virtual machine designed for Haxe.

<!--subtoc-->

<!--label:target-hl-getting-started-->
#### Getting started with Haxe/HashLink

##### Prerequisites

In order to run Hashlink bytecode and compile Hashlink/C, the Hashlink binaries must be installed. These binaries can be obtained either by downloading a [release version](https://github.com/HaxeFoundation/hashlink/releases) or by [building them from source](https://github.com/HaxeFoundation/hashlink).

Additionally, for compiling Haxe to Hashlink/C, the `hashlink` haxelib package must also be installed. It is recommended to install it directly from source, via the command:

```
haxelib git hashlink https://github.com/HaxeFoundation/hashlink.git master other/haxelib/
```


##### Sample

To get started with Haxe/HashLink, create a new folder and save this class as `Main.hx`.

[code asset](assets/HelloWorld.hx)

To compile, either run the following from the command line:

```hxml
haxe --hl hello.hl --main Main
```

Another possibility is to create and run (double-click) a file called `compile.hxml`. In this example the hxml file should be in the same directory as the example class.

```hxml
--hl hello.hl
--main Main
```

The compiler outputs a file called `hello.hl` in the current folder, which can be executed with `hl hello.hl` from the command line.

##### More information

- [Haxe/HashLink API documentation](https://api.haxe.org/hl/)

<!--label:target-hl-c-compilation-->
#### HashLink/C Compilation

Haxe supports two modes of compilation for HashLink:

 - Compilation to HashLink bytecode. This mode has a very fast compilation time, so it is suitable for daily development.
 - Compilation to HashLink/C code, compiled with a native compiler to a regular executable. This mode results in the best performance, so it is suitable for final releases.

##### HashLink bytecode

Compiling to HashLink bytecode is achieved by specifying a `.hl` output in the `--hl` argument:

```
haxe --main Main --hl output.hl
```

This produces a single `output.hl` bytecode file, which can be executed with the HashLink JIT virtual machine with:

```
hl output.hl
```

##### HashLink/C code

Before compiling to Hashlink/C, the `hashlink` haxelib library must be installed. [See here](target-hl-getting-started#prerequisites) for details.

Haxe code can then be compiled to HashLink/C code by specifying `.c` output in the `--hl` argument:

```
haxe --main Main --hl out/main.c
```

This produces files in the `out` directory, which can be compiled to a native executable with a C compiler such as `gcc`.

```
gcc -O3 -o hello -std=c++ -I out out/main.c -lhl [-L/path/to/required/hdll]
```

Note that during native compilation, the HL library must be linked. [See here](target-hl-getting-started#prerequisites) for information on obtaining Hashlink binaries.

##### Hashlink/C with Visual Studio

On Windows, to make compilation easier, it is also possible to generate Visual Studio project files.

First, the `HASHLINK` environment variable must be set up, pointing to the Hashlink install location. This is necessary as it is used within the project files to locate the Hashlink sources.

The project files can then be generated by adding the `-D hlgen.makefile` define to the compilation command:

```
haxe --main Main --hl out/main.c -D hlgen.makefile=vs2019
```

This produces a `main.sln` file in the  `out` directory, which can simply be opened in Visual Studio and built without any extra setup.
