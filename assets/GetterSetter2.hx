class Main {
  // This field cannot be accessed because it
  // is not a real variable
  public var x(get, set):Int;

  function get_x() {
    return x;
  }

  function set_x(x) {
    return this.x = x;
  }

  static public function main() {}
}
