## 4.4.4 Override

The access modifier `override` is required when a field is declared which also exists on a [parent class](types-class-inheritance.md). Its purpose is to ensure that the author of a class is aware of the override as this may not always be obvious in large class hierarchies. Likewise, having `override` on a field which does not actually override anything (e.g. due to a misspelled field name) triggers an error as well.

The effects of overriding fields are detailed in [Overriding Methods](class-field-overriding.md). This modifier is only allowed on [method](class-field-method.md) fields.

---

Previous section: [Dynamic](class-field-dynamic.md)

Next section: [Expressions](expression.md)