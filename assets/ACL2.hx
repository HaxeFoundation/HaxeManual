class MyClass {
  @:allow(Main.main)
  static private var foo: Int;
}

class Main {
  static public function main() {
    MyClass.foo;
  }
}