## 3.7.2 Import

If a type path is used multiple times in a .hx file, it might make sense to use an `import` to shorten it. This allows omitting the package when using the type:

```haxe
import haxe.ds.StringMap;

class Main {
  static public function main() {
    // instead of: new haxe.ds.StringMap();
    new StringMap();
  }
}
```

With `haxe.ds.StringMap` being imported in the first line, the compiler is able to resolve the unqualified identifier `StringMap` in the `main` function to this package. The module `StringMap` is said to be **imported** into the current file.

In this example, we are actually importing a **module**, not just a specific type within that module. This means that all types defined within the imported module are available:

```haxe
import haxe.macro.Expr;

class Main {
  static public function main() {
    var e:Binop = OpAdd;
  }
}
```

The type `Binop` is an [enum](types-enum-instance.md) declared in the module `haxe.macro.Expr`, and thus available after the import of said module. If we were to import only a specific type of that module, e.g. `import haxe.macro.Expr.ExprDef`, the program would fail to compile with `Class not found : Binop`.

There several aspects worth knowing about importing:



* The bottommost import takes priority (detailed in [Resolution Order](type-system-resolution-order.md)).
* The [static extension](lf-static-extension.md) keyword `using` implies the effect of `import`.
* If an enum is imported (directly or as part of a module import), all its [enum constructors](types-enum-constructor.md) are also imported (this is what allows the `OpAdd` usage in above example).



Furthermore, it is also possible to import [static fields](class-field.md) of a class and use them unqualified:

```haxe
import Math.random;

class Main {
  static public function main() {
    random();
  }
}
```



Special care has to be taken with field names or local variable names that conflict with a package name: Since they take priority over packages, a local variable named `haxe` blocks off usage the entire `haxe` package.

---

Previous section: [Module Sub-Types](type-system-module-sub-types.md)

Next section: [Resolution Order](type-system-resolution-order.md)

Contribute: [fileAndLines](https://github.com/HaxeFoundation/HaxeManual/blob/master/03-type-system.tex#L428-428)