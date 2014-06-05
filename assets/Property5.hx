class Base {
  public function get_x() return 1;
}

class Main extends Base {
  // ok, get_x is declared by parent class
  public var x(get, null):Int;

  static public function main() {}
}