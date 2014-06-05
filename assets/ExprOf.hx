import haxe.macro.Expr;
using Main;

class Main {
  static public function main() {
    identity("foo");
    identity(1);
    "foo".identity();
    // Int has no field identity
    //1.identity();
  }

  macro static function
  identity(e:ExprOf<String>) {
    return e;
  }
}