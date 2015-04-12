class Main {
  static function main() {
    var str = "aaabcbcbcbz";
    // g : replace all instances
    var r = ~/b[^c]/g;
    // "aaabcbcbcxx"
    trace(r.replace(str,"xx"));
  }
}
