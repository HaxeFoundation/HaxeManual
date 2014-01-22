## 2.3.1 Class constructor

Instances of classes are created by calling the class constructor, a process commonly referred to as **instantiation**. Another name for class instances is **object**, but we prefer the term class instance to emphasize the analogy between classes/class instances and [enums/enum instances](types-enum-instance.md). 

```haxe
var p = new Point(-1, 65);
```
This will yield an instance of class `Point`, which is assigned to a variable named `p`. The constructor of `Point` receives the two arguments `-1` and `65` and assigns them to the instance variables `x` and `y` respectively (compare its definition in [Class Instance](types-class-instance.md)). We will revisit the exact meaning of the `new` expression later in section [new](expression-new.md). For now, we just consider it as calling the class constructor and returning the appropriate object.

---

Previous section: [Class Instance](types-class-instance.md)

Next section: [Inheritance](types-class-inheritance.md)