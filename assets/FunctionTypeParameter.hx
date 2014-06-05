class FunctionTypeParameter {
  static public function main() {
    equals(1, 1);
    // runtime message: bar should be foo
    equals("foo", "bar");
    // compiler error: String should be Int
    equals(1, "foo");
  }

  static function
  equals<T>(expected:T, actual:T) {
    if (actual != expected) {
      trace('$actual should be $expected');
    }
  }
}