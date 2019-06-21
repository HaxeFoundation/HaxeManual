class Main {
  static function test(a:Int, ?b:String):Void {}

  static public function main() {
    var fn = test.bind(1);
    $type(fn); // Void->Void
    fn('foo'); //Compiler error: Too many arguments

    var fn = test.bind(1, _);
    $type(fn); // ?String->Void
    fn('foo'); //works
  }
}