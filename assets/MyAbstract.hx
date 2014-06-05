abstract AbstractInt(Int) {
  inline public function new(i:Int) {
    this = i;
  }
}

class MyAbstract {
  static public function main() {
    var a = new AbstractInt(12);
    trace(a); //12
  }
}
