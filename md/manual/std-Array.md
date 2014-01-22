## 10.2.1 Array

An `Array` is a **collection** for storing elements.  It has one [Type Parameters](type-system-type-parameters.md) and all elements of the array must be of the specified type.  Alternatively, arrays of mixed types are allowed if the type parameter is [Dynamic](types-dynamic.md).  See the below code snippet for an example. 
> ##### Trivia: Dynamic Arrays
>
> In Haxe 2, mixed type array declarations were allowed.  In Haxe 3, arrays can have mixed types ONLY if they are explicitly declared as **Array<Dynamic>**.
The following example shows some basic examples of working with arrays:
```haxe
class ArrayExample {
	static public function main() {
		//Compile error: Arrays of mixed types...
		//var myArray = [10, "Bob", false];

		//Dynamic Array with mixed types -- No Compile problems
		var myExplicitAray : Array<Dynamic> = [10, "Sally", true];

		//Initializing and iterating over an array
		var scores : Array<Int> = [110, 170, 35];
		var sum = 0;
		for (score in scores){
			sum += score;	 
		}
		trace(sum); //315

		//Growing and accessing undefined indices
		var scores : Array<Int> = [110, 170, 35];
		scores [5] = 92;
		trace(scores); //[110, 170, 35, null, null, 92]
		trace(scores[-5]); //null
	}
}


```


In Haxe, arrays are unbounded:  accessing or assigning an index outside the current size of the array does NOT result in an exception.  When assigning, the array grows and the inbetween elements are assigned **null** (or the **static target** alternative: see [Nullability](types-nullability.md) for more details).  When accessing, **null** is returned.  Accessing a negative index in an array also returns **null**.

Arrays can be **iterated over** using a [for](expression-for.md) loop.  However removing elements while iterating over an array is error prone (but just fine with a **List**).


See [Array Declaration](expression-array-declaration.md) for array initialization.  New arrays can also be created by [Array Comprehension](lf-array-comprehension.md).  The [http://api.haxe.org/Array.html](Array API) has details about Array methods.

---

Previous section: [Data Structures](std-ds.md)

Next section: [Vector](std-vector.md)