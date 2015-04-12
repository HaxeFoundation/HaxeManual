class Main {
  static public function main() {
    switch(3) {
      case add(_, 1) => mul(_, 3) => a:
        trace(a);
    }
  }

  static function add(i1:Int, i2:Int) {
    return i1 + i2;
  }

  static function mul(i1:Int, i2:Int) {
    return i1 * i2;
  }
}