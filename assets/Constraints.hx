typedef Measurable = {
  public var length(default, null):Int;
}

class Constraints {
  static public function main() {
    trace(test([]));
    trace(test(["bar", "foo"]));
    // String should be Iterable<String>
    //test("foo");
  }

  static function
  test<T:(Iterable<String>, Measurable)>(a:T) {
    if (a.length == 0) return "empty";
    return a.iterator().next();
  }
}