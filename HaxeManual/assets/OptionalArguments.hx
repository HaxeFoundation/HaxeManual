class OptionalArguments {
  static public function main() {
    // ?i : Int -> ?s : String -> String
    $type(test);
    trace(test()); // i: null, s: null
    trace(test(1)); // i: 1, s: null
    trace(test(1, "foo")); // i: 1, s: foo
    trace(test("foo")); // i: null, s: foo
  }

  static function test(?i:Int, ?s:String) {
    return "i: " +i + ", s: " +s;
  }
}