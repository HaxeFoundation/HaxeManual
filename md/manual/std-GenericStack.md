## 10.2.4 GenericStack

A `GenericStack`, like `Array` and `List` is a container for storing elements.  It has one [Type Parameters](type-system-type-parameters.md) and all elements of the array must be of the specified type. See the [http://api.haxe.org/haxe/ds/GenericStack.html](GenericStack API) for details about its methods.  Here is a small example program for initializing and working with a `GenericStack`.
```haxe
import haxe.ds.GenericStack;

class GenericStackExample {
    static public function main() {
        var myStack = new GenericStack<Int>();
        for (ii in 0...5)
            myStack.add(ii);
        trace(myStack); //{4, 3, 2, 1, 0}
        trace(myStack.pop()); //4
    }
}


```
> ##### Trivia: FastList
>
> In Haxe 2, the GenericStack class was known as FastList.  Since its behavior more closely resembled a typical stack, the name was changed for Haxe 3.
The **Generic** in `GenericStack` is literal.  It is attributed with the `:generic` metadata.  Depending on the target, this can lead to improved performance on static targets.  See [Generic](type-system-generic.md) for more details.

---

Previous section: [List](std-List.md)

Next section: [Map](std-Map.md)