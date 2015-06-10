## 12.1.1 Getting started with Haxe/JavaScript

Haxe can be a powerful tool for developing JavaScript applications. Let's look at our first sample.
This is a very simple example showing the toolchain. 

Create a new folder and save this class as `Main.hx`.

```haxe
import js.Lib;
import js.Browser;
class Main {
    static function main() {
        var button = Browser.document.createButtonElement();
        button.textContent = "Click me!";
        button.onclick = function(event) {
            Lib.alert("Haxe is great");
        }
        Browser.document.body.appendChild(button);
    }
}
```

To compile, either run the following from the command line:

```haxe
haxe -js main-javascript.js -main Main -D js-flatten -dce full
```

Another possibility is to create and run (double-click) a file called `compile.hxml`. In this example the hxml-file should be in the same directory as the example class.

```haxe
-js main-javascript.js
-main Main
-D js-flatten
-dce full
```

The output will be a main-javascript.js, which creates and adds a clickable button to the document body.

###### Run the JavaScript

To display the output in a browser, create an HTML-document called `index.html` and open it.

```haxe
<!DOCTYPE html>
<html>
	<body>
		<script src="main-javascript.js">
	</body>
</html>
```

###### More information

* [Haxe JavaScript API docs](http://api.haxe.org/js/)
* [MDN JavaScript Reference](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference)

---

Previous section: [JavaScript](target-javascript.md)

Next section: [Using external JavaScript libraries](target-javascript-external-libraries.md)