class Main {
  static function main() {
    var r = ~/world/;
    var s = "Hello, world!";
    var s2 = r.map(s, function(r) {
    return "Haxe";
    });
  trace(s2); // Hello, Haxe!
  }
}
