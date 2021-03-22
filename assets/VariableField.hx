class Main {
  static var example:String = "bar";

  public static function main() {
    trace(example);
    example = "foo";
    trace(example);
  }
}
