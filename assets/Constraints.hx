typedef Measurable = {
  public var length(default, null):Int;
}

class Main {
  static public function main() {
    trace(test([]));
    trace(test(["bar", "foo"]));
    // String should be Iterable<String>
    // test("foo");
  }

  #if (haxe_ver >= 4)
  static function test<T:Iterable<String> & Measurable>(a:T) {
  #else
  static function test<T:(Iterable<String>, Measurable)>(a:T) {
  #end
    if (a.length == 0)
      return "empty";
    return a.iterator().next();
  }
}
