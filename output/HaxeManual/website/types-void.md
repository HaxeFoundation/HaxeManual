## 2.1.5 Void

> ##### Define: Void
>
> Void denotes the absence of a type. It is used to express that something (usually a function) has no value.

`Void` is a special case in the type system because it is not actually a type. It is used to express the absence of a type, which applies mostly to function arguments and return types.
We have already "seen" Void in the initial "Hello World" example:

```haxe
class Main {
  static public function main():Void {
    trace("Hello World");
  }
}
```

The function type will be explored in detail in the section [Function Type](types-function.md) but a quick preview helps here: The type of the function `main` in the example above is `Void->Void`, which reads as "it has no arguments and returns nothing".
Haxe does not allow fields and variables of type `Void` and will complain if an attempt at declaring such is made:

```haxe
// Arguments and variables of type Void are not allowed
var x:Void;
```

---

Previous section: [Bool](types-bool.md)

Next section: [Nullability](types-nullability.md)