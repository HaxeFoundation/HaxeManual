class TypeInference {
  public static function main() {
    var x = null;
    $type(x); // Unknown<0>
    x = "foo";
    $type(x); // String
  }
}