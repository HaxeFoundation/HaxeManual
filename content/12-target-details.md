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
var output:Bool = Syntax.code("confirm({0})", myMessage);
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
Interacting with DOM elements. Haxe provides up to date typed interfaces to interact with the Document Object Model, allowing creation and update of DOM elements. 

Haxe can be used together with existing third-party libraries and frameworks, such as jQuery, React or Vue. To access third-party frameworks with a strongly-typed API, there are extern libraries available on [Haxelib](http://lib.haxe.org/t/js/). Alternatively, it is possible to create own externs (see [Using external JavaScript libraries](target-javascript-external-libraries)) or use the dynamic type to access any framework, see [Accessing Target-specific Syntax](target-syntax).

**Creating graphics using Canvas and WebGL**
Use Haxe to create graphical elements on a web page using WebGL. 

Libraries like [OpenFL](http://www.openfl.org/), [Heaps](http://heaps.io/) and [Kha](http://kha.tech/) make use of WebGL as one of their backends.

**Creating Haxe code that targets server-side JavaScript**
Working with server-side technology. Haxe can be used to create server-side JavaScript like Node.js.

[Getting started with Haxe/JavaScript](target-javascript-getting-started)

<!--label:target-javascript-getting-started-->
#### Getting started with Haxe/JavaScript

Haxe can be a powerful tool for developing JavaScript applications. Let's look at our first sample.
This is a very simple example showing the toolchain. 

Create a new folder and save this class as `Main.hx`.

```haxe
import js.Browser;
class Main {
    static function main() {
        var button = Browser.document.createButtonElement();
        button.textContent = "Click me!";
        button.onclick = function(event) {
            Browser.alert("Haxe is great");
        }
        Browser.document.body.appendChild(button);
    }
}
```

To compile, either run the following from the command line:

```hxml
haxe --js main-javascript.js --main Main
```

Another possibility is to create and run (double-click) a file called `compile.hxml`. In this example the hxml file should be in the same directory as the example class.

```hxml
--js main-javascript.js
--main Main
```

The output will be a main-javascript.js, which creates and adds a clickable button to the document body.

##### Run the JavaScript

To display the output in a browser, create an HTML-document called `index.html` and open it.

```xml
<!DOCTYPE html>
<html>
	<body>
		<script src="main-javascript.js"></script>
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

##### since Haxe 4.0.0

**Deprecated:** The jQuery and SWFObject externs have been removed from the standard library in Haxe 4. For compatibility purposes they are available in the [hx3compat](https://github.com/HaxeFoundation/hx3compat/) library. See [Haxe 3 Compatibility](std-hx3compat).

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

The Haxe Standard Library comes with externs of [jQuery](https://jquery.com/) and [SWFObject](http://blog.deconcept.com/swfobject/). Their version compatibility is summarized as follows:

Haxe version | Library               | Externs location 
 --- | --- | ---
4.0          | jQuery 1.12.1 / 2.2.1 | with [hx3compat](https://github.com/HaxeFoundation/hx3compat/): `js.jquery.*` 
4.0          | SFWObject 2.3         | with [hx3compat](https://github.com/HaxeFoundation/hx3compat/): `js.swfobject.*` 
3.3          | jQuery 1.12.1 / 2.2.1 | `js.jquery.*` 
3.3          | SWFObject 2.3         | `js.swfobject.*` 
3.2-         | jQuery 1.6.4          | `js.JQuery` 
3.2-         | SWFObject 1.5         | `js.SWFObject` 
 

There are many externs for other popular native libraries available on [Haxelib library](haxelib). To view a list of them, check out the [extern tag](http://lib.haxe.org/t/extern/).



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
* [Adobe Livedocs](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/)



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

<!--subtoc-->



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
<code>php-prefix=&lt;namespace&gt;</code> | Root namespace for generated PHP classes. E.g. if compiled with <code>-D php-prefix=some.sub</code>, then all classes will be generated in the <code>\ some\ sub</code> namespace. 
<code>php-lib=&lt;name&gt;</code> | Select the name for the PHP lib directory. 
<code>php-front=&lt;name&gt;</code> | Select the name for the PHP front file (default: <code>index.php</code>).

##### More information

* [Haxe/PHP API docs](https://api.haxe.org/php/)
* [PHP.net Documentation](http://php.net/docs.php)
* [PHP to Haxe tool](http://phptohaxe.haqteam.com/code.php)





<!--label:target-cpp-->
### C++

<!--subtoc-->

<!--label:target-cpp-getting-started-->
#### Getting started with Haxe/C++

The c++ target uses various c++ compilers, which are assumed to be already installed on the system, to create native executables or libraries.  The compilation happens in two phases.  Firstly, the Haxe compiler generates source, header and build files in an output directory.  Secondly, the "hxcpp" [Haxelib library](haxelib) is invoked to run the system compilers and linkers required to generate the ultimate result.

##### Prerequisites
Before you can use the C++ target, you need in install

* hxcpp, e.g. `haxelib install hxcpp`.
* A system or cross-compiler

##### System Compilers
System compilers are supported on the three primary operating systems - Mac, Linux, and Windows.  On Mac, it is recommended that you install the latest Xcode from the Mac App Store.  On Linux, it is recommended that you use the system package manager to install the compilers and on Windows, Microsoft Visual Studio is recommended.  On Windows, you can also use gcc-based compilers.  A minimal distribution is included in a [Haxelib library](haxelib), and can be installed with `haxelib install minimingw`.

##### Cross Compilers
Hxcpp can be used to compile for non-host architectures if you have a suitable cross-compiler installed.  The compilers are usually supplied in the form of a Software Development Kits (SDK), or in the case of iOS devices, come with the system compiler (Xcode).  Selecting which compiler to use is achieved by defining particular variables in the hxcpp build environment.  Note that the hxcpp build tool is only responsible for producing a native executable or a native library (static or dynamic), not the complete bundling and packaging of assets and meta-data that is typically required for mobile devices.  Additional Haxe libraries can be used for this task.

* [Haxe/C++ API docs](https://api.haxe.org/cpp/)



<!--label:target-cpp-build-environment-->
#### The Hxcpp Build Environment

The hxcpp build environment can be controlled by setting, or defining, variables in key-value pairs. Defining a key without a particular value is usually enough to trigger the desired behaviour, and these keys are often referred to as "defines".

##### Defining From the Command Line
The easiest way to change the hxcpp build environment is to pass the defines though the Haxe command line using `-D`.  Key-value pairs can also be passed this way, e.g.:

` haxe --main Main --cpp cpp -D android -D static_link -D PLATFORM=android-9 `

Here, `android` is defined - this causes hxcpp to cross-compile to android, `static_link` is defined, which causes a static (rather than dynamic) library to be created and the android target platform is set to a particular value.  This platform information is passed on to the SDK so it can generate the appropriate code.

Advanced users can add additional defines to the system at compile time using macros.  These definitions will also be passed on to the hxcpp build tool.

##### Defining From the System Environment Variables
The hxcpp build tool will import all the system environment variables, so you can configure the processes using the system like:

` setenv HXCPP_VERBOSE `

If you are running Haxe though an IDE, some care must be taken with environment variables since the variables may be read once from the environment in which the IDE was started, rather than changing when the variables are changed on the system.

##### Defining From .hxcpp_config.xml
The hxcpp build tool parses several "build files".  These files are in a basic xml file format, and can be used to set, or conditionally set, configuration variables.  As part of the build process, the `.hxcpp_config.xml` file, known as the configuration file, will be read (twice).  This file is located in the user's home directory (or user's profile directory on windows) and is the best place to configure variables that are specific to the system that rarely change, such as the location of the cross-compiler SDKs.  A placeholder file will be generated the first time hxcpp is run by a user on the machine.  You can see the exact location of this file in the build log if you compile with the `HXCPP_VERBOSE` define.

The configuration file is read twice.  The first time the `"vars"` section is read early in the configuration process, and is used to set up and configure the location of the compilers.  The second time, the `"exes"` section is read near the end of the processes and allows modification of the compiler or build process based on all the available information.  See [build.xml File Format](target-cpp-file-format) for details on the file format.

##### Defining Via @:buildXml Metadata
Configuration data can be injected into the "build.xml" file that is created by Haxe.  This is done attaching metadata to a Haxe class that is directly or indirectly included in the build.  For example:
```haxe
@:buildXml("
<target id='haxe'>
  <lib name='${haxelib:nme}/lib/${BINDIR}/libnme${LIBEXTRA}${LIBEXT}'/>
</target>
<include name='${haxelib:nme}/lib/NmeLink.xml'/>
")
@:keep class StaticNme
{
  ...
```

This metadata is best for adding libraries or include paths to the build.
Some notes:

* The @:keep metadata is added to prevent dead-code-elimination from removing this class
* Quoting can be a bit tricky - here the double-quotes are used for Haxe, and the single quotes are added to the build.xml.
* Injecting a single "include" command is a good way to manage the quoting issue.
* Knowledge of the build system is required to get this right. See [build.xml File Format](target-cpp-file-format) for details on the file format.
* The build.xml file is read after the choice of compiler has been made, so it is generally not suitable for configuring the compiler.

<!--label:target-cpp-file-format-->
#### Build.xml


The hxcpp build.xml build system is designed to make compiling, cross-compiling and linking easy on a large variety of operating systems and devices.  It was originally designed to build the haxe-generated c++ code but has evolved to replace the need for configuration tools in many open source libaries.

##### Running
The source code for the tool lives in "tools/hxcpp" in this repo.  When compiled, it can be run with the haxe 'haxelib' library tool.  This is usually done automatically by the haxe compiler after the cpp code has been generated.  It can be done maunually like:
```
haxelib run hxcpp build.xml key=value .... [target]
```

##### Configuration
The hxcpp build tool is configured using key-value pairs, or just using keys, known internally as 'defines'.  These can be set in severaly ways:
  - From system environment variables
  - From the command-line, with key=value
  - From haxe.  Keys defined in haxe with '-D key[=value]' are passed to the build too, where they can influence the build.  Certain defines need to be set on the haxe command line so that they can influence the generated code.
  - From the the .hxcpp_config.xml file in the users home(profile) directory.  This is a good place to set values the apply to the whole machine, like the location of SDKs etc.
  - The defines can be manipulated logically from within the build files themselves.

See [Defines](target-cpp-defines) for a list of standard defines.


##### Format
The compiler specification and target lists all use the same format.
  - uses xml parser
  - mostly declarative list of files and flags
  - order is important
    + overriding values is a valid technique
    + "commands" are run as they are parsed (eg, 'echo')
  - conditions via "if" and "unless" node attributes
  - substitution via '${VAR}' sysntax
  - need to define 'default' target

##### Conditions/Substitution
Most of the xml nodes support 'if' and 'unless' attributes.  These will enable or disable the whole node according the existance or non-existance of a define.  These can be combined with a space for "and" or two pipes for "or".

Substitution is supported via the dollars-brace syntax, and does simple text substitution.  In addition, there are a few dynamic variables that can be used:
 - "${VAR}" - normal replacement
 - "${removeQuotes:VAR}" - strips surrounding quotes from VAR, it any
 - "${dospath:VAR}" - converts VAR to backwards-slash path
 - "${dir:PathWithFilename}" - just the directory part of filename
 - "${this_dir}" - the location of the containing build.xml file


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

and some example uses:

```
 unsetenv SILENT
 haxelib run hxcpp example.xml
 haxelib run hxcpp example.xml WHO=world default
 setenv SILENT 1
 haxelib run hxcpp example.xml
 haxelib run hxcpp example.xml WHO=world
```

##### Details

The build.xml file contains configuration, targets, compilers, linkers and files. The details can be found in the subsections:

<!--subtoc-->
<!--label:target-cpp-build_xml-TopLevel-->
##### Structure of the top-level

The top-level nodes live inside an "xml" node, and can be:

- *set* - Set a "define", define being a general varaible.
  ```xml
  <set name="name" value="1" />
  ```

- *setenv* - Sets an hxcpp define and an envorinment variable for child processes.
   ```xml
   <setenv name="name" value="1" />
   ```
- *unset* - Unset a define.  if="name" will no longer be true
  ```xml
  <unset name="name" />
  ```

- *setup* - Used internally to call custom setup code to find SDKs etc.
  ```xml
  <setup name="androidNdk|blackberry|msvc|pdbserver|mingw|emscripten|nvcc" />
  ```

- *echo* - Print value to console.  Good for debugging.
  ```xml
  <echo value="text" />
  ```

- *error* - Print value to console and force error.  Good for checking prerequisites.
  ```xml
  <errot value="error message" />
  ```

- *pleaseUpdateHxcppTool* - Used to tell people updating git version that they need to recompile the build tool.
  ```xml
  <pleaseUpdateHxcppTool version="1" />
  ```

- *path* - Add an directory to the exe search path.
  ```xml
  <path name="directory_to_add" />
  ```

- *mkdir* - Create a directory.
  ```xml
  <mkdir name="directory" />
  ```

- *section* - Groups block of elements - usually ones that all respect the same if/unless condition.
  ```xml
  <section name="id" />  </section>
  ```

- *copy* - Copy file when node is parsed.
  ```xml
  <copy to="destination" from="src" />
  ```

- *import*/*include* - Read xml from another file. 'import' resets the relative base to the new file, include does not.
  ```xml
  <import name="filename" section="filter" noerror="true" />
  <include name="filename" section="filter" noerror="true" />
  ```
    + noerror - setting the optional noerror allows the file to be missing
    + section - setting the optional section will only reand the named section from the xml file.  Used by hxcpp_config.xml.

- *pragma* - Only include build file once, even with multiple include statements.
  ```xml
  <pragma once="true" />
  ```

- *nvccflag* - Add flag to all nvcc compiles.
  ```xml
  <nvccflag name="?name" value="-IincludePath" />
  ```

- *nvcclinkflag* - Add flag when linking with nvcc code.
  ```xml
  <nvcclinkflag name="?name" value="-arch=sm_30" />
  ```

- *files* - Define a file group, and set default tags.
  ```xml
  <files dir="dir" name="name" tags="tag1,tag2,tag3" >
   ...
  </files>
  ```
    + dir = directory to which the filenames in the group are relative
    + tags = comma separated list of flags tags

- *target* - Define a target, and set its toolid(link mode) and output name.
  ```xml
  <target name="name" overwrite="true" append="true" tool="linker" toolid="${haxelink}" output="filename" >
   ...
  </target>
  ```

- *copyFile* - Copy a file after given toolId is run into target output directory
  ```xml
  <copyFile name="destination" from="src" allowMissing="true" overwrite="true" toolId="filter" >
  ```

- *magiclib* - Internal for replacing dlls with object files
  ```xml
  <magiclib name="libname" replace="old dll" />
  ```

- *compiler* - Define a compiler.
  ```xml
  <compiler id="id" exe="command" replace="true" >
   ...
  </compiler>
  ```
    + Use optional 'replace' to overwrite, otherwise append
    + It is assumed only 1 compiler is active
    + exe can be overridden in the body of the definition

- *stripper* - Define a stripper, to remove debug information for release from gcc executables
  ```xml
  <stripper exe="command" replace="true" > </stripper>
  ```
    + Use optional 'replace' to overwrite, otherwise append

- *linker* - Define a linker.
  ```xml
  <linker id="id" exe="command" replace="true" > </linker>
  ```
    + Use optional 'replace' to overwrite, otherwise append
    + id could be 'static_link', 'dll' or 'exe'.  Usually all 3 linkers are defined.
    + exe can be overridden in the body of the definition

- *prelinker* - Define a prelinker.
  ```xml
  <prelinker name="id" replace="true" />
   ...
  </prelinker>
  ```


<!--label:target-cpp-build_xml-Files-->
##### Files

The files node defines a group of files that all share the same attributes, including relative directory, default compiler flags and dependencies.  The node can be used to define a set of header files on which other files can depend, or a set of source files to be compiled and included in a terget.

- *depend* - Declare that all files in the group depend on another file or another file group.
  ```xml
  <depend name="filename" />
  <depend files="filesId" />
  ```
    + name = If the named file changes then then all the files in the group need recompiling.
    + files = If any of the files in the named group changes then then all the files in the group need recompiling.

- *options* - Name of file containing compiler flags.  When the cache is not used, Options.txt helps detect when the options have changed, and therefore whether files need recompiling.
  ```xml
  <options name="Options.txt" />
  ```

- *config* - Name of file to generate that contains the #defines that were active when code was compiled.
  ```xml
  <config name="outfile.h" />
  ```

- *tag* - Add a default compiler flags tag too all files in group.  See [Tags](target-cpp-build_xml-Tags).
  ```xml
  <tag value="tag" />
  ```

- *addTwice* - When compiled to a library, add the library twice to the link line - once at the beginning and once at then end to satisfy linux selective linking.
  ```xml
  <addTwice value="tue" />
  ```

- *cache* - Use compiler cache for files in group.  See [compile cache](target-cpp-CompileCache) for more details.
  ```xml
  <cache value="true" project="name" asLibrary="true" />
  ```
    + project = name of project used to manage and group object files in the cache
    + asLibrary = link the objs into a .lib file, which can skip unneeded objs, but
     will also skip things that rely on static initializers to register handlers, so be careful.

- *include* - Include an external file list
  ```xml
  <include name="filename.xml" />
  ```

- *section* - Groups block of elements - usually ones that all respect the same if/unless condition.
  ```xml
  <section name="id" />  </section>
  ```


- *compilerflag* - Add a compilerflag when compiling files in group.
  ```xml
  <compilerflag name="name" value="value" />
  <compilerflag value="value" />
  ```
    + name, value = add 2 flags when compiling
    + value = add 1 flag when compiling

- *nvcc* - This group is compiled with nvcc.
  ```xml
  <nvcc />
  ```

- *objprefix* - An id prepended to generated obj name to allow alphabetical grouping of similar objs.
  ```xml
  <objprefix value="prefix" />
  ```

- *precompiledheader* - Use a precompiledheader of given name when compiling group
  ```xml
  <precompiledheader name="name" dir="directory" />
  ```
    + name = the include used when precompiling these files (without the .h)
    + directory = the location of this file

  eg, for `#include <lib/Header.h>`
    + name = "lib/Header"
    + directory = "${haxelib:somelib}/include"

- *file* - Add file to group, with optional attributes
  ```xml
  <file name="filename" tags="tag,tag1" filterout="define" embedName="embed" >
     <depend name="filename1" />
     <depend name="filename2" />
  </file>
  ```
     + name = name of file - may be absolute or relative to files.dir
     + tags = optional override of group tags.  See [Tags](target-cpp-build_xml-Tags).
     + filterout = allows files to be skipped at compile-time if the named define exists.
       This is useful when the define is set sometime after the file list is parsed.
     +  depend name = filename of additional dependency
     + embed = causes the file to be embedded as a enxtern c++ 'const char *' string constant of the specified name

<!--label:target-cpp-build_xml-Tags-->
##### Tags


Tags are identifiers that link compiler flags with spefific files.  Usually, they are defined in a files group with the 'tags' attribute as a comma separated list, and with the 'tag' attribute on a compiler 'flag' node.  Files are then compiled with all the flags that have matching tags.

By restricting tags to certain files, only a sub-set of files needs to be recompiled when conditions change, and files without the relevant tags can reuse their object files.  This can save a lot of time, since come flags only apply to a few files.

Files can override the group tags by specifying their own 'tags' attribute.  Groups can add tags with the 'tag' node.

Some tags have standard meanings when compiling haxe code:
 - *haxe* - The haxe tag adds all the required compiler flags to get haxe-generated code to compile correctly, and should be added to files that depend directly or indirectly on hxcpp.h.
 - *static* - This will add the STATIC_LINK define when approtriate, which is used for generating cffi glue.  It should be added to cffi code that might generate static libraries.
 - *gc* - These flags only affect the garbage-collection files
 - *hxstring* - These flags only affect String.cpp
 - *optimization tags* - each file is assumed to have exactly 1 optimization tags.  If none is explicitly specified, then the default is used depending on whether it is a debug or release build.  They are:
    + optim-std = alias for 'debug' or 'release' depending on build
    + debug
    + release
    + optim-none
    + optim-size

  Setting one of these tags is useful for compiling your library in release mode, even if haxe has -debug.  Some very big files are slow to compile in release mode, so using a less optimized mode can be faster.


The tags attrubute can be added to a haxe-generated file using the `@:fileXml` meta, eg:
```haxe
@:fileXml("tags='haxe,optim-none'")
class MyClass { ...
```

Here, the class is compiled with the normal haxe flags, but has the optimizations disabled, which can lead to much faster compiler times in some circumstances.
<!--label:target-cpp-build_xml-Targets-->
##### Targets


Targets are used to produce binaries, or to group other targets.  When compiling exes or dynamic libraries, they provide the additional link libraries.

By default, hxcpp will try to compile the 'default' target, so it is easiest to define this one - perhaps by simply adding a dependence on your other targets(s).

The target is defined with a 'toolid' attribute; exe, static_link or dll.  This defines which linker is run, but many of the target entries will be the same even if the linker is changed.

Targets can contain the following nodes:

- *subTargetName* - Build another target before building this one.
   ```xml
   <target id="subTargetName" />
   ```

- *merge* - Combine fields from another target.  This is usful if you want a target to function as static library or dll when compiled in its own, but also allow it to be used as a list of object files if another target wants to link in the object files directly.
   ```xml
   <merge id="otherTargetName" />
   ```

- *files* - Add a named group of compiled files to target.
   ```xml
   <files id="filesId"/>
   ```

- *section* - Group items - usually sharing common condition
   ```xml
   <section > </section>
   ```

- *lib* - Add a library to the link line.
   ```xml
   <lib (name|hxbase|base)="libName" />
   ```
     + name = the complete name is specified
     + base = the name without compiler-specific extension (.a/.lib) is specified
     + hxbase = the name without extension and achitecture (-v7/.iphoinesim) is specified

- *flag* - Add a single link flag.
   ```xml
   <flag value="flag"/>
   ```

- *vflag* - Add a pair of link flags.
   ```xml
   <vflag name="flag1" value="flag2"/>
   ```

- *depend* - Target depends on given filename.
   ```xml
   <depend name="filename"/>
   ```

- *dir* - Add a directory to the targets directory list.  These directories will get removed then the target is cleaned.
   ```xml
   <dir name="tempPath"/>
   ```

- *outdir* - Directory for build results - including "copyFile" targets
   ```xml
   <outdir name="path"/>
   ```

- *ext* - Extension for generated files.
   ```xml
   <ext name=".ext"/>
   ```
     + ext = extension - should contain "."

- *builddir* - The directory from which the targets build commands are run, and therefore the 
       relative base for some filenames, and destination for some compiler generated temps.
   ```xml
   <builddir name="path"/>
   ```

- *libpath* Add library search path to build command
   ```xml
   <libpath name="directory"/>
   ```
     + name = directory.  The particular linker will add the required flags

<!--label:target-cpp-build_xml-Compiler-->
##### Compiler

Compilers are run over each of the changed files in each of the filegroups in a target to create object files, which are then linked into the target.  Modification dates or hashes are used to tell if files need recompiling, of if the object file can be reused.



- *flag* - Add single arg to command-line.
  ```xml
  <flag value="value" tag="tag" />
  ```
    + value = text for flag added to command line
    + tag = optional filter to restrict flag to files with matching tag. See [Tags](target-cpp-build_xml-Tags).

- *cflag/cppflag/objcflag/mmflag* - Add flag when compiling specific file types.
  ```xml
  <cflag value="value" />
  <cppflag value="value" />
  <objcflag value="value" />
  <mmflag value="value" />
  ```
    + cflag = only added to .c files
    + cppflag = only added to .cpp files
    + objcflag = only added to .objc files
    + mmflag = only added to .mm objc++ files

- *pchflag* - Add flag when compiling precompiled header .h files.
  ```xml
  <pchflag value="value" />
  ```
    + pchflag = Usually `["-x", "c++-header"]` for apple to specify the "identity" of the header


- *pch* - Set the precompiled header style - "gcc" or "msvc".
  ```xml
  <pch value="gcc|msvc" />
  ```

- *objdir* - set name of directory used to store object files.  Should be unique for given set of compiler flags to avoid linking against wrong architecture.
  ```xml
  <objdir value="obj/somewhere" />
  ```
    + value = usually built progtamatically, like `obj/msvc${MSVC_VER}-rt${OBJEXT}${OBJCACHE}${XPOBJ}`

- *output* - Flag used to specifying compiler output name.
  ```xml
  <outflag value="-flag" />
  ```
    + value = flag value.  Note that it should contain a space character
      if the actual name should be a separate argument, like "-o ", or "-o"/"-out:" if it does not.

- *exe* = Override the executable command specified in the compiler attribute.
  ```xml
  <exe name="command" />
  ```
    + name = command.  Usually you would use 'path' to add the directory, then this is just the filename part.

- *ext* - Specify the object file extension
  ```xml
  <ext name=".obj" />
  ```
    + name = extension, including ".". Usually ".o" or ".obj".

- *getversion* - The command-line used to create text describing the version of the compiler.
   This is used for working out if the compiler has changed, and therefore the objs need recompiling.
  ```xml
  <getversion value="command" />
  ```
    + value = command to run.  It defaults to `compiler --version` which is usual for gcc based compilers.
       Setting it empty will disable caching.

- *section* - Group entries - usually sharing common condition
  ```xml
  <section > </section>
  ```

- *include* - include compiler options from another file.  Most compilers should include `<include name="toolchain/common-defines.xml" />` to add defines used by hxcpp.
  ```xml
  <include name="filename" />
  ```



<!--label:target-cpp-build_xml-Linker-->
##### Linker

Generally one linker is run per target to build a static library, dynamic library or exe.  The 'id' attribute of the linker specifies whch type of linking is performed.


- *exe* - Overwrite the exe command for this linker.
   ```xml
   <exe name="command" />
   ```

- *flag* - Add a single link flag.
   ```xml
   <flag value="flag"/>
   ```

- *ext* - Default extension for generated files - if not overridden by target.
   ```xml
   <ext value=".ext"/>
   ```
     + value = extension, including "."

- *outflag* - Flag for specifying lnker output name.
   ```xml
   <outflag value="-o"/>
   ```
     + value = linker flag.  Note that it should contain a space character
      if the actual name should be a separate argument, like "-o ", or "-o"/"-out:" if it does not.

- *section* - Group items - usually sharing common condition
   ```xml
   <section > </section>
   ```

- *libdir* - A temp directory name to build into.  This will capture the extra files the compiler
       generates, and then the desired file will be copied to the correct location.
   ```xml
   <libdir name="name"/>
   ```

- *lib* - Add a library to the link line.
   ```xml
   <lib (name|hxbase|base)="libName" />
   ```
     + name = the complete name is specified
     + base = the name without compiler-specific extension (.a/.lib) is specified
     + hxbase = the name without extension and achitecture (-v7/.iphoinesim) is specified

- *prefix* - Prefix for generated files.
   ```xml
   <prefix value="lib"/>
   ```
     + value = prefix.  This will usually be "lib" or nothing.

- *ranlib* - Whether ranlib needs to be run, and what command to use.  Usually only for unix-style static libraries
   ```xml
   <ranlib name="ranlib command"/>
   ```

- *libpathflag* - Flag used for adding library paths to command line.  It will be combined with *lib* entries.
   ```xml
   <libpathflag value="-L"/>
   ```

- *recreate* - Whether to delete the target file before re-running link command.
      The archive "ar" command likes to add obj files to existing archives, so deleting first can help.
   ```xml
   <recreate value="true"/>
   ```

- *expandAr* - Whether to extract the individual obj files from an archive and add these, rather than
       add the archive as a single library.  Can solve some link-order and static-initialization issues,
       but may make final exe bigger.
   ```xml
   <expandAr value="true"/>
   ```

- *fromfile* - If the linker supports taking a list of objs in a file, then this is flag for specifying the file.
   ```xml
   <fromfile value="flag" needsQuotes="true" />
   ```
     + value = flag for specifying file. 
     If the filename should be a separate argument, then the flag should end with a space.
     Usually `@` or `-filelist `.  Use empty to disable.
     + needsQuotes = is whether to quote the obj names in the file


<!--label:target-cpp-build_xml-Stripper-->
##### Stripper


A stripper is used to remove debug information in release builds on gcc-like systems.  It may contain entries:

- *exe* - Override stripper command
  ```xml
  <exe name="command"/>
  ```

- *flag* - Add flag to stripper command
   ```xml
   <flag value="flag"/>
   ```

<!--label:target-cpp-build_xml-HaxeTarget-->
##### The Haxe Target


When compiling from haxe, via hxcpp, a "Build.xml" file is generated in the output directory.  The file lists the generated files and dependencies and ultimately includes the "toolchain/haxe-target.xml" file, which describes how to combine these files.

##### Include Order
There are a few compilcations when setting the order in which things are configured, since a particular build might want to:
  - set the compiler
  - override some compiler settings
  - make decisions based on the compiler or settings
  - set or use standard file prefixes/suffixes 

##### Example Sequence
You can see which files are included by setting the HXCPP_VERBOSE define when compiling.  One example is for a hypothetical user 'Hugh' on a windows platform:

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

- setup.xml is read because no custom toolchain is specified, and this just include hxcpp_config
- the 'vars' section of hxcpp_config is read - mainly to setup SDK locations
- the hxcpp build tool then uses internal logic based on host and defines to work out which compiler/toolchain to use
- finish-setup then sets a bunch of standard defines for file-extensions and linking flags based on
   the type of toolchain being used.
- The provided buildfile (Build.xml) is then processed. It can use the standard defines from finish-setup.
- Build.xml imports the standard haxe-target buildfile, which adds standard runtime files
- The toolchain file is then parsed - making use of any settings from the main Build.xml and finish-setup.
  - This file includes the "common-defines.xml" from the compiler to inject standard haxe compiler flags
- hxcpp_config "exe" is parsed.  Historically to add libraries or build-paths to targets.


##### Standard Environment
finish-setup.xml is where the conventions are set. These variables include:
  - haxelink = dll|static_link|exe
  - LIBPREFIX = lib|""
  - LIBEXTRA =
     +  .iphonesim-64
     +  .iphonesim
     +  .iphoneos
     +  .iphoneos-v7
     +  .iphoneos-v7s
     +  .iphoneos-64
     +  .appletvsim-64
     +  .appletvsim
     +  .watchos
     +  .watchsimulator
     +  -x86
     +  -v7
     +  -64
  - HX_LINK_SUFFIX = LIBEXTRA | -19 (msvc 19)
  - LIBEXT = .a|.lib
  - DBG = ""|"-debug"
  - OBJEXT = "-list-of-config-ids" depending on available options

These variables are used by haxe-target - you can use them too.  Haxe then builds the "haxe" target, which uses some code like:
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

Here you can see the vaious file groups, which are enabled or not depending on the compiler mode, and some standard libraries that are needed for Linux.

##### Experimenting With Hxcpp Generated Code/Build.xml
If you are using external cpp code, or using meta-data to inject xml into the build process, and you are getting a compile or link error, then it can be useful to run the hxcpp build tool without re-running haxe.  This lets you hand-edit the build file or generated c++ code until you get things to work.  Once you have solved the issues using this technique, then you can move the changes back into the injected/external code.

First, compile haxe with '-v' flag.  This gives quite a bit of debug, but will include a like like this:
```
haxelib run hxcpp Build.xml haxe -Dhaxe3="1" -Dhaxe_ver="4.000" -Dhxcpp_api_level="332" -Dsource-header="Generated by Haxe 4.0.0" -I"" -I"C:/Users/Hugh/dev/haxe/std/cpp/_std/" -I"C:/Users/Hugh/dev/haxe/std/"
```

To use this, first change directories to your output directory.  This will be the one you specified with the "-cpp" haxe compiler option.  Then, cut and paste this command into a shell, cmd or batch file.



<!--label:target-cpp-build_xml-XmlInjection-->
##### Xml Injection


When using external code in hxcpp, it is often useful to add libraries, include paths or compiler flags to the build process.  This can be done with the `@:buildXml` class meta-data. eg,

```haxe
@:buildXml("
<target id='haxe'>
  <lib name='${haxelib:nme}/lib/${BINDIR}/libnme${LIBEXTRA}${LIBEXT}'/>
</target>
")
@:keep
class StaticNme
{
  ...
```

So, by referencing a given class (you just 'import' the class, no need to use it because it has the @:keep meta-data), the xml fragment is also included.

Here, the xml fragment is copied verbatim into the generated Build.xml immediately after the standard file lists.  This example adds a library to the haxe target, but you could also add flags to files nodes, or files to another files node or target.  Another possibility is to add an include command to pull in a whole external xml file.  This can help avoid some syntax awkwardness needed when quoting strings in meta-data, and allows a normal xml editor to be used.

It is also possible to replace the `__main__` file group to skip the standard initialization code and use a custom bootstrap procedure.

<!--label:target-cpp-defines-->
#### Defines


There are a number of standard defines you can use to control the hxcpp build.  Some of these are used by the haxe compiler, and affect then generated code.  Others apply to the build tool and affect how the code is compiled.

Defines affecting how the code is generated.  These need to be in the command line when calling haxe.

| Define                  | Meaning            |
|-------------------------|--------------------|
| *HXCPP_DEBUGGER*        | Add extra macros required by debugger.  Usually added automatically be debugger haxelib |
| *HXCPP_GC_GENERATIONAL* | Enable experimental generational garbage collector |
| *annotate_source*       | Add additional annotations to source code - useful for developing hxcpp |
| *dll_export*            | Export hxcpp runtime symbols |
| *file_extension*        | Set the extension (without the dot) of generated files.  eg "-D file_extension=mm" for objc++ code  |
| *force_native_property* | Make dynamic access of fields call property getters/setters where appropriate |
| *include_prefix*        | Place all generated include files in a sub-directory, eg "-D include_prefix=hxinc".  Useful for avoiding name clashes |
| *no-compilation*        | Generate the code, but do not compile it |
| *no-debug*              | Do not generate debug macros in code |
| *nocppiaast*            | Use legacy cppia generation instead of new more recent changes |
| *objc*                  | Generate objective-c++ classes |
| *scriptable*            | Enable extra runtime information required for scripting |



Defines affecting how the code is compiled.  These can be on the command line when calling haxe, or added via the hxcpp build environment.

| Define                  | Meaning            |
|-------------------------|--------------------|
| *HXCPP_GC_MOVING*       | Allow garbage collector to move memory to reduce fragmentation |
| *HXCPP_GC_SUMMARY*      | Print small profiling summary at end of program |
| *HXCPP_GC_DYNAMIC_SIZE* | Monitor GC times and expand memory working space if required |
| *HXCPP_GC_BIG_BLOCKS*   | Allow working memory greater than 1 Gig |
| *HXCPP_GC_DEBUG_LEVEL*  | Number 1-4 indicating additional debugging in GC |
| *HXCPP_DEBUG_LINK*      | Add symbols to final binary, even in release mode. |
| *HXCPP_STACK_TRACE*     | Have valid function-level stack traces, even in release mode. |
| *HXCPP_STACK_LINE*      | Include line information in stack traces, even in release mode. |
| *HXCPP_CHECK_POINTER*   | Add null-pointer checks,even in release mode. |
| *HXCPP_PROFILER*        | Add profiler support |
| *HXCPP_TELEMETRY*       | Add telementry support |
| *HXCPP_CPP11*           | Use c++11 features and link libraries |
| *exe_link*              | Generate executable file (rathen than dynamic library on android) |
| *static_link*           | Generate static library |
| *dll_link*              | Generate dynamic library |

Other defines:

| Define                  | Meaning            |
|-------------------------|--------------------|
| *HXCPP_VERBOSE*         | Print extra output from build tool. |
| *HXCPP_TIMES*           | Show some basic profiling information |
| *HXCPP_NEKO_BUILDTOOL*  | Force use of hxcpp.n, rather than compiled BuildTool.exe
| *HXCPP_NO_COLOR*        | Do not add colour-codes to tool output |
| *HXCPP_KEEP_TEMP*       | Does not delete the files created for file 'embedName' option |


Defines affecting target architecture.

| Define                  | Meaning            |
|-------------------------|--------------------|
| *HXCPP_M32*             | Force 32-bit compile for current desktop |
| *HXCPP_M64*             | Force 64-bit compile for current desktop |
| *HXCPP_ARMV6*           | Compile arm-based devices for armv6 |
| *HXCPP_ARM64*           | Compile arm-based devices for 64 bits |
| *HXCPP_ARMV7*           | Compile arm-based devices for armv7 |
| *HXCPP_ARMV7S*          | Compile arm-based devices for armv7s |
| *HXCPP_LINUX_ARMV7*     | Run on a linux ARMv7 device |
| *HXCPP_LINUX_ARM64*     | Run on a linux ARM64 device |
| *winrt*                 | Compile for windowsRt/windows UWP |
| *android*               | Compile for android |
| *PLATFORM*              | Specify the android platform for NDK compilation |
| *ANDROID_NDK_ROOT*      | Specify the location of the android NDK toolchain |
| *ANDROID_NDK_DIR*       | Specify the search location for finding the android NDK toolchain |
| *HXCPP_X86*             | Compile android for x86 architecture |
| *iphoneos*              | Compile for iphone iOS |
| *iphonesim*             | Compile for iphone simulator |
| *appletvos*             | Compile for apple tvOS |
| *appletvsim*            | Compile for apple tvOS simulator |
| *watchos*               | Compile for apple watchOS |
| *watchsimulator*        | Compile for apple watchOS simulator |
| *webos*                 | Compile for webOS |
| *tizen*                 | Compile for Tizen |
| *blackberry*            | Compile for Blackberry |
| *emscripten*            | Compile for Emscripten |
| *cygwin*                | Compile for windows using cygwin |
| *linux*                 | (Cross) Compile for linux |
| *rpi*                   | (Cross) Compile for raspberry pi |
| *mingw*                 | Compile for windows using mingw |
| *HXCPP_MINGW*           | Compile for windows using mingw |
| *NO_AUTO_MSVC*          | Do not detect msvc location, use the one already in the executable path |



<!--label:target-cpp-pointers-->
#### Using C++ Pointers

<!--subtoc-->

<!--label:target-cpp-CompileCache-->
#### The Hxcpp Cache

The hxcpp compile cache is used to share object files between projects. This can alleviate the need to ship static libraries with external projects, since developers who use the library can compile the library just once, and then reuse it between projects.

The cache uses a hashing mechanism to tell if the contents of a file or its dependencies has changed, and combines this with the compiler version and flags to make specific object files for each change and each compiler congiguration.  This also allows some common haxe runtime and haxe generated files to share their object files between projects, even if in different directories.

Additional benefits include keeping some files outside the source tree, and being able to remove these temp files easily.

##### Setup
A directory needs to be set aside to enable the cache.  If possible, this should be on fast storage, such as a SSD.  This is most easily done with an entry in the .hxcpp_config.xml file:
```xml
 <set name="HXCPP_COMPILE_CACHE" value="c:/hxcpp/cache" />
 <set name="HXCPP_CACHE_MB" value="4000" />
```
Keeping the path short can help in some border-line cases with some compilers where command-line length can become an issue.

The cache size defaults to 1 Gig.  For many cases, this is big enough.  However, on large projects, with several architectures and lots of debug information, this default can lead to "cache churn" where some files are evicted from the cache, even though they are likely to be used again.  Increasing the number of mega-bytes allocated to the cache can help here.

##### Using The Cache
To use the cashe with your own libraries, the files group should have 'cache' entry to tell hxcpp that you have considered dependency issues when designing the group.

  ```xml
  <cache value="true" project="name" asLibrary="true" />
  ```

  - project = name of project used to manage and group object files in the cache
  - asLibrary = link the objs into a .lib file.

When linking a file group 'asLibrary', the object files are compiled and then the library tool is used to make a library from these object files.  This library is then added to the linker.  This has a few implications:
   - Object files that to not resolve any symbols directly are not added to the final executable
     + Can make final exe size smaller
     + If the object file only contains a handler that is self-registering via static constructor,
        then the constructor may not get called, leading to bugs.
   - Can help on some systems where the linker command-line length is an issue.


##### Management
When compiling normally, hxcpp will check the cache size and evict the least used files to maintain the specified cache size.
Object files in the cache are grouped into "projects" to make management easier, and the hxcpp build tool can be used to explicitly manage the object files.
```
 haxelib run hxcpp cache [command] [project]
   Perform command on cache, either on specific project or all. commands:
    clear -- remove all files from cache
    days #days -- remove files older than "days"
    resize #megabytes -- Only keep #megabytes MB
    list -- list cache usage
    details -- list cache usage, per file
```
Start with
```
haxelib run hxcpp cache list
```
To get an idea of cache usage.


<!--label:target-cpp-ThreadsAndStacks-->
#### Threads And Stacks



##### Conservative, co-operation
Hxcpp uses conservative stop-the-world GC, where the threads need to co-operate.
 - Threads must not change GC pointers in the collection phase
 - The thread stacks/registers must be scanned for GC pointers
 - Threads must not block without letting the GC system know not to wait for them, otherwise GC blocks until end of block 
   + call hx::GCEnterBlocking() / gc_enter_blocking() / (cpp.vm.Gc.enterGCFreeZone() from Haxe) before potentially blocking system call (fs,network, etc)
   + call hx::GCExitBlocking() / gc_exit_blocking() / (cpp.vm.Gc.exitGCFreeZone() from Haxe) before making more GC calls
   + Might need to pre-allocate buffers
   + Don't forget the exit blocking on error condition

##### Foreign Threads
When you create a thread from haxe, it starts attached.  Before a non-haxe created thread can interact with hxcpp, some care must be taken, since GC allocations are done using a GC context per thread, and all threads must respect the stopped world.
  - Foreign threads must be attached-detached
     - SetTopOfStack(int * inTop,bool inPush)
     - *inTop* = pointer to top of stack to attach, or '0' to remove stack
     - *inPush* = usually true.  recursive attachment/detachment
  - Must not change things when the world is stopped
  - Must define their stack range for scanning
  - If you are attached, you may need to enter/exit gc free zone
  - Must release context when done, if no more calls are going to be made
  - Make sure local variables are covered in stack
    - compiler may reorder, so be careful
  - Read documentation because some things, eg audio callbacks, happen on other threads
  - You can use other techniques, eg
     - create a haxe thread, which blocks waiting for signal
     - foreign thread generates request and signals haxe thread
     - haxe thread performs job and generates data then signals foreign thread
     - foreign picks up data and carries on




##### Top of Stack

 - To understand how to handle threads, you need a mental picture of the c++ stack
 - The stack usually goes "down".  That is, if the first stack location is 10000, the next one will be 9999 etc.
 - Historical, but consistent.  Except for emscripten which goes up - but still use same terminology/picture, just change the less-thans to greater-thans in code.

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

Hxcpp then runs it main code, which starts with the macro HX_TOP_OF_STACK, which expands to something like:
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

Later, many generated functions deep, `__hxcpp_main` generates an allocation call which
triggers a collection

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

Enter/exit use similar technique, where the registers are captured and the bottomOfStack is 'locked-in' when the "enter gc free zone" call is made.
```
 8100  Array<Bullet>   bullets
       -- EnterGCFreeZone --
 8088 int   bottomOfStackTemp
      thread->setBottomOfStack(&bottomOfStackTemp)
      thread->captureRegisters()
      return
      * any changes here will not affect GC
```

Now, when another thread does a collection, the gc-free thread can be scanned from 8088 to 9976, regardless of any stuff happening lower dowsn the stack.


##### Not Called From Main 

Top of stack can be tricky to get right when a gui framework does not really have a "main".


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

Later, the haxeOnFrame callback is trigger, but not "below" `__hxcpp_main`

```
 9800  -- haxeOnFrame ---
     // Top of stack will be below bottom of stack.

```

Solutions:
  - Make sure you get in at top of main
    + may scan too much?
  - Ratchet up top-of-stack in callbacks, inForce = false
    + gc_set_top_of_stack(void * inTopOfStack,bool inForce);
  - Detach main thread after hxcpp_main and reattach each callback
    + android solution because render callbacks happen on different threads
    + gc_set_top_of_stack(&base,true); // attach
    + gc_set_top_of_stack(0,true); // detach



##### Debugging.
  - in debug mode, hxcpp will check for calls from unattached threads
  - hxcpp can log conservative ranges.  With a native debugger you can check the address of
     your local variables and ensure they are included.
  - hxcpp will scan native objects on the stack, but will not follow non-haxe pointers to other objects, so additional GC roots may be required.






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

* [hxjava haxelib](http://lib.haxe.org/p/hxjava). This is the support library for the Java backend of the Haxe compiler.
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





<!--label:target-cs-->
### C#

<!--subtoc-->

<!--label:target-cs-getting-started-->
#### Getting started with Haxe/C#

Haxe can be used as a language for .NET platform through its C# target. Let's make a simple program using .NET Console class:

[code asset](assets/HelloWorld.hx)

To compile Haxe to C# we need two obvious prerequisites installed:

* [hxcs haxelib](http://lib.haxe.org/p/hxcs). This is the support library for the C# backend of the Haxe compiler.
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

<!--subtoc-->



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
luarocks install lrexlib-pcre
luarocks install environ
luarocks install luasocket
luarocks install luv
```

On Lua 5.1, install the bitops library:
```sh
luarocks install luabitop
```

On Lua 5.3, install the bit32 library instead:
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
* [LuaJIT Homepage](http://luajit.org/)



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
* The Main class that invokes the string method as a simple example.

The multireturn behavior in Haxe is optimized based on usage.  If fields are
only accessed directly, the Haxe compiler will allocate the multireturn to
individual variables.  But, if you pass or assign the entire multireturn value,
the compiler will wrap all values into a table object.  This operation ensures
that multireturn variable handling only carries as much overhead as needed.





<!--label:target-hl-->
### HashLink

<!--subtoc-->


