## 12.1.3 Inject raw JavaScript

In Haxe, it is possible to call an exposed function thanks to the `untyped` keyword. This can be useful in some cases if we don't want to write externs. Anything untyped that is valid syntax will be generated as it is.

```haxe
untyped window.trackEvent("page1");  
```

###### Expression injection 

In some cases it may be needed to inject raw JavaScript code into Haxe-generated code. With the `__js__` function we can inject pure JavaScript code fragments into the output. This code is always untyped and can not be validated, so it accepts invalid code in the output, which is error-prone.
This could, for example, write a JavaScript comment in the output.

```haxe
untyped __js__('// haxe is great!');
```

A more useful demonstration would be to call a function and pass  arguments using the `__js__` function. This example illustrates how to call this function and how to pass parameters. Note that the **code interpolation** will wrap the quotes around strings in the generated output.

```haxe
// Haxe code:
var myVar = untyped __js__('myObject.myJavaScriptFunction({0}, {1})', "Mark", 31);
```

This will generate the following JavaScript code:
```haxe
// JavaScript Code
var myVar = myObject.myJavaScriptFunction("Mark", 31);
```

---

Previous section: [Using external JavaScript libraries](target-javascript-external-libraries.md)

Next section: [Debugging JavaScript](target-javascript-debugging.md)