class FunctionType {
  static public function main() {
    // i : Int -> s : String -> Bool
    $type(test);
    $type(test(1, "foo")); // Bool
  }

  static function test(i:Int, s:String):Bool {
    return true;
  }
}