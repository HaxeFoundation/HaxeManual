## 6.7 Map Comprehension

Map comprehension in Haxe uses existing syntax to allow concise initialization for `Map`. Maps are initialized like arrays, but use the map literal syntax with the `=>` operator. It is identified by `for` or `while` constructs:

```haxe
class Main {
  static public function main() {
    var a = [for (i in 0...5) i => 'number ${i}'];
    trace(a); // {0 => number 0, 1 => number 1, 2 => number 2, 3 => number 3, 4 => number 4}
    
    var i = 0;
    var b = [while(i < 5) i => 'number ${i++}'];
    trace(b); // {0 => number 0, 1 => number 1, 2 => number 2, 3 => number 3, 4 => number 4}
  }
}

```

Variable `a` is initialized to an `Map` holding keys from 0 to 4 and string values. The compiler generates code which adds the value of each loop iteration to the map, so the following code would be equivalent:

```haxe
var a = new Map();
for (i in 0...5) a.set(i, 'number ${i}');
```

Variable `b` is initialized to an `Map` with the same keys and values, but through a different comprehension style using `while` instead of `for`. Again, the following code would be equivalent:

```haxe
var i = 0;
var b = new Map();
while(i < 5) b.set(i, 'number ${i++}');
```

The loop expression can be anything, including conditions and nested loops, so the following works as expected:

```haxe
class Main {
  static public function main() {
    var a = [
      for (x in 0...5)
        for(y in 0...5)
          if (x != y)
            x => y
    ];
    // {0 => 4, 1 => 4, 2 => 4, 3 => 4, 4 => 3}
    trace(a);
  }
}

```

---

Previous section: [Array Comprehension](lf-array-comprehension.md)

Next section: [Iterators](lf-iterators.md)