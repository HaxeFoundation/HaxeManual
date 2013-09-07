With haxe 3 it is no longer necessary to manually concatenate parts of a string due to the introduction of **String Interpolation**. Special identifiers, denoted by the dollar sign `$` within a String enclosed by single-quote `'` characters, are evaluated as if they were concatenated identifiers:

```
var x = 12;
trace('The value of x is $x'); // The value of x is 12
```
%TODO: add $
Furthermore, it is possible to include whole expressions in the string by using `$${expr}$`, with `expr` being any valid haxe expression:

```
var x = 12;
trace('The sum of $x and 3 is ${x + 3}'); // The sum of x and 3 is 15
``` 
String interpolation is a compile-time feature and has no impact on the runtime. The above example is equivalent to manual concatenation, which is exactly what the compiler generates:

```
trace("The sum of " +x+ " and 3 is " + (x + 3));
```
Of course the use of single-quote enclosed strings without any interpolation remains valid, but care has to be taken regarding the $ character as it triggers interpolation. If an actual dollar-sign should be used in the string, `$$` can be used.