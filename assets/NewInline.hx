class Point {
  public var x:Float;
  public var y:Float;

  public inline function
  new(x:Float, y:Float) {
    this.x = x;
    this.y = y;
  }
}

class Main {
  static public function main() {
    var pt = new Point(1.2, 9.3);
  }
}