## 5.5 Array Declaration

Arrays are initialized by enclosing comma `,` separated values in brackets `[]`. A plain `[]` represents the empty array, whereas `[1, 2, 3]` initializes an array with three elements `1`, `2` and `3`.

The generated code may be less concise on platforms that do not support array initialization. Essentially, such initialization code then looks like this:

```haxe
var a = new Array();
a.push(1);
a.push(2);
a.push(3);
```
This should be considered when deciding if a function should be [inlined](class-field-inline.md) as it may inline more code than visible in the syntax.

Advanced initialization techniques are described in [Array Comprehension](lf-array-comprehension.md).

---

Previous section: [Constants](expression-constants.md)

Next section: [Object Declaration](expression-object-declaration.md)