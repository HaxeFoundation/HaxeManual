class Main {
  static public function main() {
    // Compile Error: Arrays of mixed types are
    // only allowed if the type is forced to
    // Array<Dynamic>
    //var myArray = [10, "Bob", false];

    // Array<Dynamic> with mixed types
    var myExplicitArray:Array<Dynamic> =
      [10, "Sally", true];
  }
}