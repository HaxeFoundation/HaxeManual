class Main {
  static public function main() {
    const("foo", 1, 1.5, true);
  }

  macro static function
  const(s:String, i:Int, f:Float, b:Bool) {
    trace(s);
    trace(i);
    trace(f);
    trace(b);
    return macro null;
  }
}