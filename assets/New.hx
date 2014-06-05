class Main<T> {
  static public function main() {
    new Main<Int>(12, "foo");
  }

  function new(t:T, s:String) { }
}