enum Color {
  Red;
  Green;
  Blue;
}

class Main {
  static function main() {
    var myColor : Color = Blue;

    // compiler error: Unmatched patterns: Blue
    switch( myColor ){
      case Red: 0xFF0000;
      case Green: 0x00ff00;
    }
  }
}