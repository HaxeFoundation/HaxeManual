class Main {
  static function main() {
    var r = ~/world/;
    var str = "hello world";
    // true : 'world' was found in the string
    trace(r.match(str));
    trace(r.match("hello !")); // false
  }
}
