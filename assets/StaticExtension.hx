using Main.IntExtender;

class IntExtender {
  static public function triple(i:Int) {
    return i * 3;
  }
}

class Main {
  static public function main() {
    trace(12.triple());
  }
}