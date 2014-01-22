## 10.2.2 Vector

A `Vector` is an optimized fixed-length **collection** of elements. Much like [Array](std-Array.md), it has one [type parameter](type-system-type-parameters.md) and all elements of a vector must be of the specified type, it can be **iterated over** using a [for loop](expression-for.md) and accessed using [array access syntax](types-abstract-array-access.md). However, unlike `Array` and `List`, vector length is specified on creation and cannot be changed later.

```haxe
class Main {
    static function main() {
        var vec = new haxe.ds.Vector(10);

        for (i in 0...vec.length) {
            vec[i] = i;
        }

        trace(vec[0]); // 0
        trace(vec[5]); // 5
        trace(vec[9]); // 9
    }
}

```

`haxe.ds.Vector` is implemented as an abstract type ([Abstract](types-abstract.md)) over a native array implementation for given target and can be faster for fixed-size collections, because the memory for storing its elements is pre-allocated.

---

Previous section: [Array](std-Array.md)

Next section: [List](std-List.md)