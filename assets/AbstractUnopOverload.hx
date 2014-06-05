abstract MyAbstract(String) {
  public inline function new(s:String) {
    this = s;
  }

  @:op(++A) public function pre()
    return "pre" + this;
  @:op(A++) public function post()
    return this + "post";
}

class AbstractUnopOverload {
  static public function main() {
    var a = new MyAbstract("foo");
    trace(++a); // prefoo
    trace(a++); // foopost
  }
}