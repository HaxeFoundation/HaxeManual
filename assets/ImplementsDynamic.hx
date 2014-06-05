class ImplementsDynamic
  implements Dynamic<String> {
  public var present:Int;
  public function new() {}
}

class Main {
  static public function main() {
    var c = new ImplementsDynamic();
    // valid, present is an existing field
    c.present = 1;
    // valid, assigned value is a String
    c.stringField = "foo";
    // error, Int should be String
    //c.intField = 1;
  }
}