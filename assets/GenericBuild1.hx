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