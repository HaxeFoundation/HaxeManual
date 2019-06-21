class MyClass {
  @:allow(I)
  static private var foo: Int;
}

interface I { }

class Main implements I {
  static public function main() {
    MyClass.foo;
  }
}