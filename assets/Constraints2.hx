class Main {
  static public function main() {
    trace(test([]));
    trace(test(["bar", "foo"]));
  }

  static function test<T:Iterable<String>>(a:T) {
    return a.iterator().next();
  }
}