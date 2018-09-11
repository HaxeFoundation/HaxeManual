class Base {
  public function new() { }
  public function myMethod() {
    return "Base";
  }
}

class Child extends Base {
  public override function myMethod() {
    return "Child";
  }

  public function callHome() {
    return super.myMethod();
  }

}

class Main {
  static public function main() {
    var child = new Child();
    trace(child.callHome()); // Base
  }
}
