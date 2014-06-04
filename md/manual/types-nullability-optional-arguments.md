## 2.2.1 Optional Arguments and Nullability

Optional arguments also have to be accounted when considering nullability.

In particular, there must be a distinction between **native** optional arguments which are not nullable and Haxe optional arguments which might be.  The distinction is made by using the question-mark optional argument:

```haxe
// x is a native Int (not nullable)
function foo(x : Int = 0) {...}
// y is Null<Int> (nullable)
function bar( ?y : Int) {...}
// z is also Null<Int>
function opt( ?z : Int = -1) {...}
```


> ##### Trivia: Argument vs Parameter
>
> In some other programming languages, **argument** and **parameter** are used interchangably.  In Haxe, **argument** is used when referring to methods, and **parameter** refers to [Type Parameters](type-system-type-parameters.md).

---

Previous section: [Nullability](types-nullability.md)

Next section: [Class Instance](types-class-instance.md)

Contribute: [fileAndLines](https://github.com/HaxeFoundation/HaxeManual/blob/master/02-types.tex#L215-215)