abstract MyAbstract(Int) from Int {
  @:op(a()) public function callNoArgs():Int
    return this;

  @:op(a()) public function callOneArg(x:Int):Int
    return x + this;
}

class Main {
  static public function main() {
    var s:MyAbstract = 42;
    trace(s()); // uses callNoArgs, outputs 42
    trace(s(1)); // uses callOneArg, outputs 43
  }
}
