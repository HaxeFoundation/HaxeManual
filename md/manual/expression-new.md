## 5.11 new

The `new` keyword signals that a [class](types-class-instance.md) or an [abstract](types-abstract.md) is being instantiated. It is followed by the [type path](dictionary.md#type-path) of the type which is to be instantiated. It may also list explicit [type parameters](type-system-type-parameters.md) enclosed in `<>` and separated by comma `,`. After an opening parenthesis `()` follow the constructor arguments, again separated by comma `,`, with a closing parenthesis `)` at the end.

```haxe
class Main<T> {
	static public function main() {
		new Main<Int>(12, "foo");
	}
	
	function new(t:T, s:String) { }
}
```

Within the `main` method we instantiate an instance of `Main` itself, with an explicit type parameter `Int` and the arguments `12` and `"foo"`. As we can see, the syntax is very similar to the [function call syntax](expression-function-call.md) and it is common to speak of "constructor calls".

---

Previous section: [Local functions](expression-function.md)

Next section: [Inline constructors](expression-inline-constructor.md)