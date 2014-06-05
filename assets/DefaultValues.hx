class DefaultValues {
  static public function main() {
    // ?i : Int -> ?s : String -> String
    $type(test);
    trace(test()); // i: 12, s: bar
    trace(test(1)); // i: 1, s: bar
    trace(test(1, "foo")); // i: 1, s: foo
    trace(test("foo")); // i: 12, s: foo
  }

  static function test(i = 12, s = "bar") {
    return "i: " +i + ", s: " +s;
  }
}