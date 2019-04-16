typedef PointX = {
  var x:Int;
}

typedef PointY = {
  var y:Int;
}

typedef PointXY = PointX & PointY;

class Main {
  static public function main() {
    var point:PointXY = {x: 5, y: 3};
  }
}