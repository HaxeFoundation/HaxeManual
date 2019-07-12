class Main {
  static function main() {
    // correct
    Reflect.callMethod(Main, Reflect.field(Main, "f"), []);
    // wrong
    // Reflect.callMethod(Main, "f", []);
  }

  static function f() {
    trace("Called");
  }
}
