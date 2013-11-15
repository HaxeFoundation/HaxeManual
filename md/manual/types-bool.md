## 2.1.4 Bool

> ##### Define: Bool
>
> Represents a value which can be either **true** or **false**
.
Values of type `Bool` appear commonly in **conditions** such as `if` (section [if](expression-if.md)) and `while` (section [while](expression-while.md)). The following **operators** accept and return `Bool` values:


* `&&` (and)
* `||` (or)
* `!` (not)


Haxe guarantees that compound boolean expressions are evaluated from left to right and only as far as necessary at runtime. For instance, an expression like `A && B` will evaluate `A` first and evaluate `B` only if the evaluation of `A` yielded `true`. Likewise, the expressions `A || B` will not evaluate `B` if the evaluation of `A` yielded `true`, because the value of `B` is irrelevant in that case.
This is important in some cases such as this:

```haxe
if (object != null && object.field == 1) { ... }
```
Accessing `object.field` if `object` is `null` would lead to a runtime error, but the check for `object != null` guards against it.

---

Previous section: [Numeric Operators](types-numeric-operators.md)

Next section: [Void](types-void.md)