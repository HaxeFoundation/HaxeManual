## 6.5 String Interpolation

With Haxe 3 it is no longer necessary to manually concatenate parts of a string due to the introduction of **String Interpolation**. Special identifiers, denoted by the dollar sign `$` within a String enclosed by single-quote `'` characters, are evaluated as if they were concatenated identifiers:

```haxe
var x = 12;
// The value of x is 12
trace('The value of x is $x');
```
Furthermore, it is possible to include whole expressions in the string by using `${expr}`, with `expr` being any valid Haxe expression:

```haxe
var x = 12;
// The sum of 12 and 3 is 15
trace('The sum of $x and 3 is ${x + 3}');
```
String interpolation is a compile-time feature and has no impact on the runtime. The above example is equivalent to manual concatenation, which is exactly what the compiler generates:

```haxe
trace("The sum of " + x +
  " and 3 is " + (x + 3));
```
Of course the use of single-quote enclosed strings without any interpolation remains valid, but care has to be taken regarding the $ character as it triggers interpolation. If an actual dollar-sign should be used in the string, `$$` can be used.

> ##### Trivia: String Interpolation before Haxe 3
>
> String Interpolation has been a Haxe feature since version 2.09. Back then, the macro `Std.format` had to be used, being both slower and less comfortable than the new string interpolation syntax.

---

Previous section: [Useless pattern checks](lf-pattern-matching-unused.md)

Next section: [Array Comprehension](lf-array-comprehension.md)