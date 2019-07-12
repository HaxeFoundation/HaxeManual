typedef Point2D = {
  var x:Int;
  var y:Int;
}

typedef Point3D = Point2D & {z:Int};

class Main {
  static public function main() {
    var point:Point3D = {x: 5, y: 3, z: 1};
  }
}
