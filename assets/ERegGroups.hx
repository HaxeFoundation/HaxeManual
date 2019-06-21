class Main {
  static function main() {
    var str = "Nicolas is 26 years old";
    var r =
      ~/([A-Za-z]+) is ([0-9]+) years old/;
    r.match(str);
    trace(r.matched(1)); // "Nicolas"
    trace(r.matched(2)); // "26"
  }
}
