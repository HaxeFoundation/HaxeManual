So far we have seen how types and haxe programs in general are structured. This section about class fields concludes the structural part and at the same time bridges to the behavioral part of haxe. This is because class fields are the place where [[manual/Expressions]] are at home.

There are three kinds of class fields:



* A [[manual/Variable]] class field holds a value of a certain type, which can be read or written.
* A [[manual/Property]] class field defines a custom access behavior for something that, outside the class, looks like a variable field.
* A [[manual/Method]] is a function which can be called to execute code.


Strictly speaking, a variable could be considered to be a property with certain access modifiers. Indeed, the haxe compiler does not distinguish variables and properties during its typing phase, but they remain separated at syntax level.

Regarding terminology, a method is a (static or non-static) function belonging to a class. Other functions, such as a [[manual/Closure]] in expressions, are not considered methods.