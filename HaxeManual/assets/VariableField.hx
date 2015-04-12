class VariableField {
  static var member:String = "bar";

  public static function main() {
    trace(member);
    member = "foo";
    trace(member);
  }
}