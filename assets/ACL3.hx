class MyClass {
  static private var foo: Int;
}

class Main {
  @:access(MyClass.foo)
  static public function main() {
    MyClass.foo;
  }
}