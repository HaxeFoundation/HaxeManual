## 12.4.2 PHP untyped functions

These functions allow to access specific PHP platform features. It works only when the Haxe compiler is targeting PHP and should always be prefixed with `untyped`. 

**Important note:** Before using these functions, make sure there is no alternative available in the Haxe Standard Library. The resulting syntax can not be validated by the Haxe compiler, which may result in invalid or error-prone code in the output.

##### `untyped __php__(expr)`
Injects raw PHP code expressions. It's possible to pass fields from Haxe source code using [String Interpolation](lf-string-interpolation.md).

```haxe
var value:String = "test";
untyped __php__("echo '<pre>'; print_r($value); echo '</pre>';");
// output: echo '<pre>'; print_r('test'); echo '</pre>';
```

##### `untyped __call__(function, arg, arg, arg...)`
Calls a PHP function with the desired number of arguments and returns what the PHP function returns.

```haxe
var value = untyped __call__("array", 1,2,3); 
// output returns a NativeArray with values [1,2,3]
```

##### `untyped __var__(global, paramName)`
Get the values from global vars. Note that the dollar sign in the Haxe code is omitted.

```haxe
var value : String = untyped __var__('_SERVER', 'REQUEST_METHOD')  
// output: $value = $_SERVER['REQUEST_METHOD']
```

##### `untyped __physeq__(val1, val2)`
Strict equals test between the two values. Returns a `Bool`.

```haxe
var isFalse = untyped __physeq__(false, value);
// output: $isFalse = false === $value;
```

---

Previous section: [Getting started with Haxe/PHP](target-php-getting-started.md)

Next section: [C++](target-cpp.md)