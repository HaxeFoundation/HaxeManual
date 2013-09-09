## 4 Class Fields

> Define: Class Field
>
> A class field is a variable, property or method of a class which can either be static or non-static. Non-static fields are referred to as **member** fields, so we speak of e.g. a **static method** or a **member variable**.


So far we have seen how types and haxe programs in general are structured. This section about class fields concludes the structural part and at the same time bridges to the behavioral part of haxe. This is because class fields are the place where [Expressions](https://github.com/Simn/HaxeManual/tree/master/md/manual/5-Expressions.md) are at home.

There are three kinds of class fields:



* Variable: A [Variable](https://github.com/Simn/HaxeManual/tree/master/md/manual/4.1-Variable.md) class field holds a value of a certain type, which can be read or written.
* Property: A [Property](https://github.com/Simn/HaxeManual/tree/master/md/manual/4.2-Property.md) class field defines a custom access behavior for something that, outside the class, looks like a variable field.
* Method: A [Method](https://github.com/Simn/HaxeManual/tree/master/md/manual/4.3-Method.md) is a function which can be called to execute code.


Strictly speaking, a variable could be considered to be a property with certain access modifiers. Indeed, the haxe compiler does not distinguish variables and properties during its typing phase, but they remain separated at syntax level.

Regarding terminology, a method is a (static or non-static) function belonging to a class. Other functions, such as a [Closure](https://github.com/Simn/HaxeManual/tree/master/md/manual/5.9-Closure.md) in expressions, are not considered methods.

---

Previous section: [Module Sub-Types](https://github.com/Simn/HaxeManual/tree/master/md/manual/3.5.1-Module_Sub-Types.md)

Next section: [Variable](https://github.com/Simn/HaxeManual/tree/master/md/manual/4.1-Variable.md)