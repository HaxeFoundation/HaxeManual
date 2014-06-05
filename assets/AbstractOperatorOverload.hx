abstract MyAbstract(String) {
  public inline function new(s:String) {
    this = s;
  }

  @:op(A * B)
  public function repeat(rhs:Int):MyAbstract {
    var s:StringBuf = new StringBuf();
    for (i in 0...rhs)
      s.add(this);
    return new MyAbstract(s.toString());
  }
}

class AbstractOperatorOverload {
  static public function main() {
    var a = new MyAbstract("foo");
    trace(a * 3); // foofoofoo
  }
}