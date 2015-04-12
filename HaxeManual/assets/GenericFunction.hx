class Main {
  static public function main() {
    method("foo");
    method(1);
  }

  @:generic static function method<T>(t:T) { }
}