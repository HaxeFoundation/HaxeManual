import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.Type;

class GenericBuildMacro2 {
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