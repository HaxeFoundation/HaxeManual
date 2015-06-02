import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.Type;

class GenericBuildMacro1 {
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