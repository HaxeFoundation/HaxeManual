class Resolve implements Dynamic<String> {
  public var present:Int;
  public function new() {}
  function resolve(field:String) {
    return "Tried to resolve " +field;
  }
}

class Main {
  static public function main() {
    var c = new Resolve();
    c.present = 2;
    trace(c.present);
    trace(c.resolveMe);
  }
}