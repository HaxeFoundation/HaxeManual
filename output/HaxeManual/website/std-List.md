## 10.2.3 List

A `List` is a **collection** for storing elements.  On the surface, a list is similar to an [Array](std-Array.md).  However, the underlying implementation is very different.  This results in several functional differences:

1. A list can not be indexed using square brackets, i.e. `[0]`.
2. A list can not be initialized.
3. There are no list comprehensions.
4. A list can freely modify/add/remove elements while iterating over them.

A simple example for working with lists:
```haxe
class Main {
  static public function main() {
    var myList = new List<Int>();
    for (ii in 0...5)
      myList.add(ii);
    trace(myList); //{0, 1, 2, 3, 4}
  }
}


```

See the [List API](http://api.haxe.org/List.html) for details about the list methods.

---

Previous section: [Vector](std-vector.md)

Next section: [GenericStack](std-GenericStack.md)