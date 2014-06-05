class TypeInference2 {
  public static function main() {
    var x = [];
    $type(x); // Array<Unknown<0>>
    x.push("foo");
    $type(x); // Array<String>
  }
}