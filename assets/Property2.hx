class Main {
  // read from outside, write only within Main
  public var ro(default, null):Int;

  // write from outside, read only within Main
  public var wo(null, default):Int;

  // access through getter get_x and setter
  // set_x
  public var x(get, set):Int;

  // read access through getter, no write
  // access
  public var y(get, never):Int;

  // required by field x
  function get_x() return 1;

  // required by field x
  function set_x(x) return x;

  // required by field y
  function get_y() return 1;

  function new() {
    var v = x;
    x = 2;
    x += 1;
  }

  static public function main() {
    new Main();
  }
}