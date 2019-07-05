class Main {
  static public function main() {
    var myConcat = (a : String, b : String) -> a + b;
    var myChar = (a : String, b : Int) -> (a.charAt(b) : String);
    $type(myConcat); // (a : String, b : String) -> String
    $type(myChar); // (a : String, b : Int) -> String
    trace(myConcat("foo", "bar")); // "foobar"
    trace(myChar("example", 1)); // "x"
    var oneArgument = number -> number + 1;
    var noArguments = () -> "foobar";
    var myContains = (a : String, needle : String) -> {
      if (a.indexOf(needle) == -1) return false;
      trace(a, needle);
      true;
    };
  }
}
