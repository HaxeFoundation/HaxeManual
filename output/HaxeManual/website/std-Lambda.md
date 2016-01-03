## 10.5 Lambda

> ##### Define: Lambda
>
> Lambda is a functional language concept within Haxe that allows you to apply a function to a list or [iterators](lf-iterators.md). The Lambda class is a collection of functional methods in order to use functional-style programming with Haxe.

It is ideally used with `using Lambda` (see [Static Extension](lf-static-extension.md)) and then acts as an extension to `Iterable` types. 

On static platforms, working with the `Iterable` structure might be slower than performing the operations directly on known types, such as `Array` and `List`.

##### Lambda Functions
The Lambda class allows us to operate on an entire `Iterable` at once.
This is often preferable to looping routines since it is less error prone and easier to read. 
For convenience, the `Array` and `List` class contains some of the frequently used methods from the Lambda class.

It is helpful to look at an example. The exists function is specified as:

```haxe
static function exists<A>( it : Iterable<A>, f : A -> Bool ) : Bool
```

Most Lambda functions are called in similar ways. The first argument for all of the Lambda functions is the `Iterable` on which to operate. Many also take a function as an argument.

* `Lambda.array`, `Lambda.list` Convert Iterable to `Array` or `List`. It always returns a new instance.
* `Lambda.count` Count the number of elements.  If the Iterable is a `Array` or `List` it is faster to use its length property.
* `Lambda.empty` Determine if the Iterable is empty. For all Iterables it is best to use the this function; it's also faster than compare the length (or result of Lambda.count) to zero.
* `Lambda.has` Determine if the specified element is in the Iterable.
* `Lambda.exists` Determine if criteria is satisfied by an element.
* `Lambda.indexOf` Find out the index of the specified element.
* `Lambda.find` Find first element of given search function.
* `Lambda.foreach` Determine if every element satisfies a criteria.
* `Lambda.iter` Call a function for each element.
* `Lambda.concat` Merge two Iterables, returning a new List.
* `Lambda.filter` Find the elements that satisfy a criteria, returning a new List.
* `Lambda.map`, `Lambda.mapi` Apply a conversion to each element, returning a new List.
* `Lambda.fold` Functional fold, which is also known as reduce, accumulate, compress or inject.

This example demonstrates the Lambda filter and map on a set of strings:

```haxe
using Lambda;
class Main {
    static function main() {
        var words = ['car', 'boat', 'cat', 'frog'];

		var isThreeLetters = function(word) return word.length == 3;
		var capitalize = function(word) return word.toUpperCase();

		// Three letter words and capitalized. 
		trace(words.filter(isThreeLetters).map(capitalize)); // [CAR,CAT]
    }
}
``` 

This example demonstrates the Lambda count, has, foreach and fold function on a set of ints.

```haxe
using Lambda;
class Main {
    static function main() {
        var numbers = [1, 3, 5, 6, 7, 8];

		trace(numbers.count()); // 6
		trace(numbers.has(4)); // false

        // test if all numbers are greater/smaller than 20
		trace(numbers.foreach(function(v) return v < 20)); // true
        trace(numbers.foreach(function(v) return v > 20)); // false

        // sum all the numbers
		var sum = function(num, total) return total += num;
		trace(numbers.fold(sum, 0)); // 30
    }
}
``` 

See the [Lambda API](http://api.haxe.org/Lambda.html) for all available functions.

---

Previous section: [Extensions](std-math-extensions.md)

Next section: [Template](std-template.md)