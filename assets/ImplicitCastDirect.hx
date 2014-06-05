abstract MyAbstract(Int) from Int to Int {
  inline function new(i:Int) {
    this = i;
  }
}

class ImplicitCastDirect {
  static public function main() {
    var a:MyAbstract = 12;
    var b:Int = a;
  }
}