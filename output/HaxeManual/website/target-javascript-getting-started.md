## 12.1.1 Getting started with Haxe/JavaScript

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
haxe -js main-javascript.js -main Main
```

Another possibility is to create and run (double-click) a file called `compile.hxml`. In this example the hxml file should be in the same directory as the example class.

```hxml
-js main-javascript.js
-main Main
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

* [Debugging in JavaScript](debugging-javascript.md)
* [Haxe/JavaScript tutorials](https://code.haxe.org/category/javascript/)
* [Haxe JavaScript API docs](https://api.haxe.org/js/)
* [MDN JavaScript Reference](https://developer.mozilla.org/bm/docs/Web/JavaScript)
* [Haxe/Javascript documentation by Matthijs Kamstra](https://matthijskamstra.github.io/haxejs/)

---

Previous section: [JavaScript](target-javascript.md)

Next section: [Using external JavaScript libraries](target-javascript-external-libraries.md)