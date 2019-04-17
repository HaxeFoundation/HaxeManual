class Point {
  public var x:Int;
  public var y:Int;
  
  public function new(x:Int, y:Int) {
    this.x = x;
    this.y = y;
  }
}

class Main {
  static public function main() {
    var pt = inline new Point(3, 5);
    pt.x = pt.y + 10;
  }
}