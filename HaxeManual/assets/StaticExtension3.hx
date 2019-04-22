using Main.IntExtender;

class IntExtender {
  @:noUsing static public function double(i:Int) {
    return i * 2;
  }
  static public function triple(i:Int) {
    return i * 3;
  }
}

class Main {
  static public function main() {
    // works:
    trace(12.triple());
    // does not work because the method is marked with @:noUsing:
    //trace(12.double());
    // works as a normal static method:
    trace(IntExtender.double(12));
  }
}