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