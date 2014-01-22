## 3.7.1 Module Sub-Types

A module sub-type is a type declared in a module with a different name than that module. This allows a single .hx file to contain multiple types, which can be accessed unqualified from within the module, and by using `package.Module.Type` from other modules:

```haxe
var e:haxe.macro.Expr.ExprDef;
```
Here, the sub-type `ExprDef` within module `haxe.macro.Expr` is accessed. By default, module sub-types are publicly available, but their visibility can be constrained to their enclosing module by adding the `private` keyword:

```haxe
private class C { ... }
private enum E { ... }
private typedef T { ... }
private abstract A { ... }
```
The accessibility can be controlled more fine-grained by using [access control](lf-access-control.md).

---

Previous section: [Modules and Paths](type-system-modules-and-paths.md)

Next section: [Import](type-system-import.md)