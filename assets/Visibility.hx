class MyClass {
  static public function available() {
    unavailable();
  }
  static private function unavailable() { }
}

class Main {
  static public function main() {
    MyClass.available();
    // Cannot access private field unavailable
    MyClass.unavailable();
  }
}