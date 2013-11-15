## 2.1.5 Void

> ##### Define: Void
>
> Void denote the absence of a type. It is used to express that something (usually a function) has no value.


`Void` is a special case in the type system because it is not actually a type. It is used to express the absence of a type, which applies mostly to function arguments and return types.
We have already "seen" Void in the initial "Hello World" example:

```haxe
class HelloWorld {
	static public function main():Void {
		trace("Hello World");
	}
}
```
The function type will be explored in detail in section [Function](types-function.md), but a quick preview helps here: The type of function `main` in above example can be considered to be `Void->Void`, which reads as "it has no arguments and returns nothing".
Haxe does not allow fields and variables of type `Void`, and will complain if an attempt is made at declaring such:

```haxe
var x:Void; // Arguments and variables of type Void are not allowed
```

---

Previous section: [Bool](types-bool.md)

Next section: [Nullability](types-nullability.md)