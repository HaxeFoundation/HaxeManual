## 3.7.1 Module Sub-Types

A module sub-type is a type declared in a module with a different name than that module. This allows a single .hx file to contain multiple types, which can be accessed unqualified from within the module, and by using `package.Module.Type` from other modules:

```haxe
var e:haxe.macro.Expr.ExprDef;
```

Here the sub-type `ExprDef` within module `haxe.macro.Expr` is accessed. 

The sub-type relation is not reflected at run-time. That is, public sub-types become a member of their containing package, which could lead to conflicts if two modules within the same package tried to define the same sub-type. Naturally, the Haxe compiler detects these cases and reports them accordingly. In the example above `ExprDef` is generated as `haxe.macro.ExprDef`.

Sub-types can also be made private:

```haxe
private class C { ... }
private enum E { ... }
private typedef T { ... }
private abstract A { ... }
```

> ##### Define: Private type
>
> A type can be made private by using the `private` modifier. As a result, the type can only be directly accessed from within the [module](dictionary.md#define-module) it is defined in.
> 
> Private types, unlike public ones, do not become a member of their containing package.

The accessibility of types can be controlled more fine-grained by using [access control](lf-access-control.md).

---

Previous section: [Modules and Paths](type-system-modules-and-paths.md)

Next section: [Import](type-system-import.md)