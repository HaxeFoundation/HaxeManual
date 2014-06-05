enum Color {
  Red;
  Green;
  Blue;
  Rgb(r:Int, g:Int, b:Int);
}

class Main {
  static function main() {
    var color = getColor();
    switch (color) {
      case Red: trace("Color was red");
      case Green: trace("Color was green");
      case Blue: trace("Color was blue");
      case Rgb(r, g, b):
        trace("Color had a red value of " +r);
    }
  }

  static function getColor():Color {
    return Rgb(255, 0, 255);
  }
}