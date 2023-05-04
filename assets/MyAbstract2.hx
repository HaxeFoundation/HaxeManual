abstract AbstractInt(Int) {
  inline public function new(i:Int) {
    this = i;
  }
  inline public function test() {
    Main.takeAbstractInt(abstract);
  }
}

class Main {
  static public function takeAbstractInt(x:AbstractInt) {
    // ...
  }

  static public function main() {
    var a = new AbstractInt(12);
    a.test();
  }
}
