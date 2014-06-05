import haxe.macro.Expr;

class Main {
  static public function main() {
    myMacro("foo", a, b, c);
  }

  macro static function
  myMacro(e1:Expr, extra:Array<Expr>) {
    for (e in extra) {
      trace(e);
    }
    return macro null;
  }
}