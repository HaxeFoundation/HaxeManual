## 12.1.4 JavaScript untyped functions

These functions allow to access specific JavaScript platform features. It works only when the Haxe compiler is targeting JavaScript and should always be prefixed with `untyped`. 

**Important note:** Before using these functions, make sure there is no alternative available in the Haxe Standard Library. The resulting syntax can not be validated by the Haxe compiler, which may result in invalid or error-prone code in the output.

##### `untyped __js__(expr, params)`
[Injects raw JavaScript expressions](target-javascript-injection.md). It's allowed to use `{0}`, `{1}`, `{2}` etc in the expression and use the rest arguments to feed Haxe fields. The Haxe compiler will take care of the surrounding quotes if needed. The function can also return values.

```haxe
untyped __js__('alert("Haxe is great!")');
// output: alert("Haxe is great!");

var myMessage = "Haxe is great!";
untyped __js__('alert({0})', myMessage);
// output: 
//	var myMessage = "Haxe is great!";
//	alert(myMessage);

var myVar:Bool = untyped __js__('confirm({0})', "Are you sure?");
// output: var myVar = confirm("Are you sure?");

var hexString:String = untyped __js__('({0}).toString({1})', 255, 16);
// output: var hexString = (255).toString(16);
```

##### `untyped __instanceof__(o,cl)` 
Same as `o instanceof cl` in JavaScript.

```haxe
var myString = new String("Haxe is great");
var isString = untyped __instanceof__(myString, String);
output: var isString = (myString instanceof String);
```

##### `untyped __typeof__(o)` 
Same as `typeof o` in JavaScript.

```haxe
var isNodeJS = untyped __typeof__(window) == null;
output: var isNodeJS = typeof(window) == null;
```

##### `untyped __strict_eq__(a,b)` 
Same as `a === b`  in JavaScript, tests on [strict equality](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Equality_comparisons_and_sameness) (or "triple equals" or "identity").

```haxe
var a = "0";
var b = 0;
var isEqual = untyped __strict_eq__(a, b);
output: var isEqual = ((a) === b);
```

##### `untyped __strict_neq__(a,b)` 
Same as `a !== b`  in JavaScript, tests on negative strict equality.

```haxe
var a = "0";
var b = 0;
var isntEqual = untyped __strict_neq__(a, b);
output: var isntEqual = ((a) !== b);
```

##### Expression injection 

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

Previous section: [Inject raw JavaScript](target-javascript-injection.md)

Next section: [Debugging JavaScript](target-javascript-debugging.md)