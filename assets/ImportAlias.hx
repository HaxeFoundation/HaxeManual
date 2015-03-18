import String.fromCharCode in f;

class Main {
  static function main() {
    var c1 = f(65);
    var c2 = f(66);
    trace(c1 + c2); // AB
  }
}