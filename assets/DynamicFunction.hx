class Main {
  static dynamic function test() {
    return "original";
  }

  static public function main() {
    trace(test()); // original
    test = function() { return "new"; }
    trace(test()); // new
  }
}