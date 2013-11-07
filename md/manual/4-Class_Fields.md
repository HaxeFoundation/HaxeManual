## 4 Class Fields

>TODO: A little different than the 'standard' OOP definitions. A thing contained in an object is usually called a 'member.'  Might be worth pointing out the difference to other 'OOP' languages.  
> ##### Define: Class Field
>
> A class field is a variable, property or method of a class.  It can either be static or non-static. Non-static fields are referred to as **member** fields, so we speak of e.g. a **static method** or a **member variable**.


So far we have seen how types and haxe programs in general are structured. This section about class fields concludes the structural part and bridges to the behavioral part of haxe: [expressions](5-Expressions.md) live in class fields!

There are three kinds of class fields:



* Variable: A [variable](4.1-Variable.md) class field holds a value of a certain type, which can be read or written.
* Property: A [property](4.2-Property.md) class field defines a custom access behavior for something that, outside the class, looks like a variable field.
* Method: A [method](4.3-Method.md) is a function which can be called to execute code.


Strictly speaking, a variable could be considered to be a property with certain access modifiers. Indeed, the haxe compiler does not distinguish variables and properties during its typing phase, but they remain separated at syntax level.

Regarding terminology, a method is a (static or non-static) function belonging to a class. Other functions, such as [closures](5.9-Closure.md) in expressions, are not considered methods.
>TODO: I think it makes sense to talk about flags here (static, dynamic, override, public, and private)

---

Previous section: [Resolution Order](3.7.3-Resolution_Order.md)

Next section: [Variable](4.1-Variable.md)