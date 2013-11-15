## 6.5 Array Comprehension

Array comprehension in Haxe uses existing syntax to allow concise initialization of arrays. It is identified by `[for` or `[while` constructs:

```haxe
class Main {
	static public function main() {
		var a = [for (i in 0...10) i];
		trace(a); // [0,1,2,3,4,5,6,7,8,9]
		
		var i = 0;
		var b = [while(i < 10) i++];
		trace(b); // [0,1,2,3,4,5,6,7,8,9]
	}
}
```

Variable `a` is initialized to an array holding the numbers 0 to 9. The compiler generates code which adds the value of each loop iteration to the array, so the following code would be equivalent:

```haxe
var a = [];
for (i in 0...10) a.push(i);
```

Variable `b` is initialized to an array with the same values, but through a different comprehension style using `while` instead of `for`. Again, the following code would be equivalent:

```haxe
var i = 0;
var a = [];
while(i < 10) a.push(i++);
```

The loop expression can be anything, including conditions and nested loops, so the following works as expected:

```haxe
class AdvArrayComprehension {
	static public function main() {
		var a = [
			for (a in 1...11)
				for(b in 2...4)
					if (a % b == 0)
						a+ "/" +b
		];
		trace(a); // [2/2,3/3,4/2,6/2,6/3,8/2,9/3,10/2]
	}
}

```

---

Previous section: [String Interpolation](lf-string-interpolation.md)

Next section: [Function Bindings](lf-function-bindings.md)