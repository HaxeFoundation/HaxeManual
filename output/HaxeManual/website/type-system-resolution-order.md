## 3.7.3 Resolution Order

Resolution order comes into play as soon as unqualified identifiers are involved. These are [expressions](expression.md) in the form of `foo()`, `foo = 1` and `foo.field`. The last one in particular includes module paths such as `haxe.ds.StringMap`, where `haxe` is an unqualified identifier.  

We describe the resolution order algorithm here, which depends on the following state:

* the declared [local variables](expression-var.md) (including function arguments)
* the [imported](type-system-import.md) modules, types and statics
* the available [static extensions](lf-static-extension.md)
* the kind (static or member) of the current field
* the declared member fields on the current class and its parent classes
* the declared static fields on the current class
* the [expected type](dictionary.md#define-expected-type)
* the expression being `untyped` or not

<img src="../../assets/graphics/generated/type-system-resolution-order-diagram.png" alt="Resolution order of identifier `i'" title="Resolution order of identifier `i'" />

_Figure: Resolution order of identifier `i'_

Given an identifier `i`, the algorithm is as follows:

1. If i is `true`, `false`, `this`, `super` or `null`, resolve to the matching constant and halt.
2. If a local variable named `i` is accessible, resolve to it and halt.
3. If the current field is static, go to 6.
4. If the current class or any of its parent classes has a field named `i`, resolve to it and halt.
5. If a static extension with a first argument of the type of the current class is available, resolve to it and halt.
6. If the current class has a static field named `i`, resolve to it and halt.
7. If an enum constructor named `i` is declared on an imported enum, resolve to it and halt.
8. If a static named `i` is explicitly imported, resolve to it and halt.
9. If `i` starts with a lower-case character, go to 11.
10. If a type named `i` is available, resolve to it and halt.
11. If the expression is not in untyped mode, go to 14
12. If `i` equals `__this__`, resolve to the `this` constant and halt.
13. Generate a local variable named `i`, resolve to it and halt.
14. Fail

For step 10, it is also necessary to define the resolution order of types:

1. If a type named `i` is imported (directly or as part of a module), resolve to it and halt.
2. If the current package contains a module named `i` with a type named `i`, resolve to it and halt.
3. If a type named `i` is available at top-level, resolve to it and halt.
4. Fail

For step 1 of this algorithm as well as steps 5 and 7 of the previous one, the order of import resolution is important:

* Imported modules and static extensions are checked from bottom to top with the first match being picked.
* Within a given module, types are checked from top to bottom.
* For imports, a match is made if the name equals.
* For [static extensions](lf-static-extension.md), a match is made if the name equals and the first argument [unifies](type-system-unification.md). Within a given type being used as static extension, the fields are checked from top to bottom.

---

Previous section: [Import](type-system-import.md)

Next section: [Class Fields](class-field.md)