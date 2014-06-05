abstract MyAbstract<T>(T) from T {
  public function new(t:T) this = t;

  function get() return this;

  static public function
  getString(v:MyAbstract<String>):String {
    return v.get();
  }
}

class SelectiveFunction {
  static public function main() {
    var a = new MyAbstract("foo");
    a.getString();
    var b = new MyAbstract(1);
    // Int should be MyAbstract<String>
    b.getString();
  }
}