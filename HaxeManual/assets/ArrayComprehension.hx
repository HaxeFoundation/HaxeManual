class Main {
  static public function main() {
    var a = [for (i in 0...10) i];
    trace(a); // [0,1,2,3,4,5,6,7,8,9]

    var i = 0;
    var b = [while(i < 10) i++];
    trace(b); // [0,1,2,3,4,5,6,7,8,9]
  }
}