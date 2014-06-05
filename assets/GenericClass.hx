@:generic
class MyArray<T> {
  public function new() { }
}

class Main {
  static public function main() {
    var a = new MyArray<String>();
    var b = new MyArray<Int>();
  }
}