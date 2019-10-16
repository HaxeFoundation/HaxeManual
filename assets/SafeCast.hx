class Base {
  public function new() {}
}

class Child1 extends Base {}
class Child2 extends Base {}

class Main {
  public static function main() {
    var child1:Base = new Child1();
    var child2:Base = new Child2();
    cast(child1, Base);   // Ok
    cast(child1, Child2); // Exception: Class cast error
  }
}
