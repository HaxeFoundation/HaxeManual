import haxe.macro.Expr;

class Main {
  static public function main() {
    var x = 0;
    var b = add(x++);
    trace(x); // 2
  }

  macro static function add(e:Expr) {
    return macro $e + $e;
  }
}