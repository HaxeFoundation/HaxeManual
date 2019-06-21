class Main {
  static public function main() {
    final a = "hello";
    var b = "world";
    trace(a, b); // hello, world
    b = "Haxe";
    trace(a, b); // hello, Haxe
    
    // the following line would cause a compilation error:
    // a = "bye";
  }
}