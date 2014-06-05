class Main {
  static function main() {
    var r = ~/b/;
    r.match("abc");
    trace(r.matchedLeft()); // a
    trace(r.matched(0)); // b
    trace(r.matchedRight()); // c
  }
}
