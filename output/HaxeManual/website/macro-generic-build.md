## 9.5.3 @:genericBuild

##### since Haxe 3.1.0

Normal [build-macros](macro-type-building.md) are run per-type and are already very powerful. In some cases it is useful to run a build macro per type **usage** instead, i.e. whenever it actually appears in the code. Among other things this allows accessing the concrete type parameters in the macro.

`@:genericBuild` is used just like `@:build` by adding it to a type with the argument being a macro call:

```haxe
// MyMacro.hx
import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.Type;

class MyMacro {
  static public function build() {
    switch (Context.getLocalType()) {
      case TInst(_, [t1]):
        trace(t1);
      case t:
        Context.error("Class expected", Context.currentPos());
    }
    return null;
  }
}

// Main.hx
@:genericBuild(MyMacro.build())
class MyType<T> { }

class Main {
  static function main() {
    var x:MyType<Int>;
    var x:MyType<String>;
  }
}
```

When running this example the compiler outputs `TAbstract(Int,[])` and `TInst(String,[])`, indicating that it is indeed aware of the concrete type parameters of `MyType`. The macro logic could use this information to generate a custom type (using `haxe.macro.Context.defineType`) or refer to an existing one. For brevity we return `null` here which asks the compiler to [infer](type-system-type-inference.md) the type.

In Haxe 3.1 the return type of a `@:genericBuild` macro has to be a `haxe.macro.Type`. Haxe 3.2 allows (and prefers) returning a `haxe.macro.ComplexType` instead, which is the syntactic representation of a type. This is easier to work with in many cases because types can simply be referenced by their paths.

###### Const type parameter

Haxe allows passing [constant expression](expression-constants.md) as a type parameter if the type parameter name is `Const`. This can be utilized in the context of `@:genericBuild` macros to pass information from the syntax directly to the macro:

```haxe
import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.Type;

class MyMacro {
  static public function build() {
    switch (Context.getLocalType()) {
      case TInst(_,[TInst(_.get() => { kind: KExpr(macro $v{(s:String)}) },_)]):
        trace(s);
      case t:
        Context.error("Class expected", Context.currentPos());
    }
    return null;
  }
}

// Main.hx
@:genericBuild(MyMacro.build())
class MyType<Const> { }

class Main {
  static function main() {
    var x:MyType<"myfile.txt">;
  }
}
```

Here the macro logic could load a file and use its contents to generate a custom type.

---

Previous section: [@:autoBuild](macro-auto-build.md)

Next section: [Limitations](macro-limitations.md)