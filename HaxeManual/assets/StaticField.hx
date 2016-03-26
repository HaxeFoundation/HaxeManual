class Main {
  static function main() {
    Main.staticField; // static read
    Main.staticField = 2; // static write
  }

  static var staticField:Int;
}