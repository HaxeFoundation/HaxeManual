## 12.1 JavaScript

Haxe provides the ability to target JavaScript. It does so by transpiling Haxe to JavaScript. The current implementation targets ECMAScript 5. But it is possible to target lower versions using `-D js-es=<value>`.

When choosing the JavaScript target, only the used Haxe code of the project (and used parts of the standard library) are transpiled to JavaScript. This results in optimal filesize which is also readable. [Source maps](debugging-source-map-javascript.md) are available and there are several ways to get [debug](debugging.md) information. The standard library aims to have same functionality across all targets.

##### Usage

You may want to compile Haxe to JavaScript in the following scenarios:

**Client-side JavaScript**
Interacting with DOM elements. Haxe provides up to date typed interfaces to interact with the Document Object Model, allowing creation and update of DOM elements. 

Haxe can be used together with existing third-party libraries and frameworks, such as jQuery, React or Vue. To access third-party frameworks with a strongly-typed API, there are extern libraries available on [Haxelib](http://lib.haxe.org/t/js/). Alternatively, it is possible to create own externs (see [Using external JavaScript libraries](target-javascript-external-libraries.md)) or use the dynamic type to access any framework, see [Using Untyped JavaScript](target-javascript-injection.md).

**Creating graphics using Canvas and WebGL**
Use Haxe to create graphical elements on a web page using WebGL. 

Libraries like [OpenFL](http://www.openfl.org/), [Heaps](http://heaps.io/) and [Kha](http://kha.tech/) make use of WebGL as one of their backends.

**Creating Haxe code that targets server-side JavaScript**
Working with server-side technology. Haxe can be used to create server-side JavaScript like Node.js.

[Getting started with Haxe/JavaScript](target-javascript-getting-started.md)

---

Previous section: [Target Details](target-details.md)

Next section: [Getting started with Haxe/JavaScript](target-javascript-getting-started.md)